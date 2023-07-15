import { RawUser, User } from '../types/User';
import { RawTrack, Track, RaceRecord, Race, QBRace } from '../types/Racing';
import { QBRacingEvents, RacingEvents } from '../types/Events';
import { SQLJSON } from '../types/Common';

const QBCore = exports['qb-core'].GetCoreObject();

const hotReloadConfig = {
  resourceName: GetCurrentResourceName(),
  files: ['/dist/server.js', '/dist/client.js', '/dist/html/index.js'],
};

if (GetResourceState('hotreload') === 'started') {
  exports['hotreload'].add(hotReloadConfig);
}

const MYSQL: OXMysqlExports = global.exports['oxmysql'];

interface OXMysqlExports {
  query_async: <T>(query: string, args?: string[]) => Promise<T>;
}

exports('ReloadAllTracks', async (arg) => {
  console.log('reloadalltracks');
  emitNet(RacingEvents.UpdateTracks, -1);
});

onNet(RacingEvents.GetTracks, async () => {
  const src = source;
  const rawTracks = await MYSQL.query_async<RawTrack[]>('SELECT * from lapraces');
  const rawUsers = await MYSQL.query_async<RawUser[]>('SELECT citizenid, charinfo from characters');
  const tracks = rawTracks.map(parseTrack(rawUsers));
  emitNet(RacingEvents.SendTracks, src, tracks);
});

onNet(RacingEvents.GetRaces, async () => {
  const src = source;

  const rawUsers = await MYSQL.query_async<RawUser[]>('SELECT citizenid, charinfo from characters');
  const races = await new Promise<QBRace[]>((resolve) => {
    QBCore.Functions.TriggerCallback('qb-lapraces:server:GetRaces', 0, resolve);
  });

  const parsedRaces = races.map(parseRace(rawUsers));

  emitNet(RacingEvents.SendRaces, src, parsedRaces);
});

onNet(RacingEvents.GetUser, async () => {
  const src = source;
  const player = QBCore.Functions.GetPlayer(src);
  emitNet(RacingEvents.SendUser, src, player.PlayerData);
});

onNet(RacingEvents.DeleteTrack, async (raceId: string) => {
  const src = source;
  const player = QBCore.Functions.GetPlayer(src);

  const { affectedRows } = await MYSQL.query_async<{ affectedRows: number }>(
    'DELETE FROM lapraces WHERE creator=? AND raceid=?',
    [player.PlayerData.citizenid, raceId],
  );

  if (affectedRows > 0) {
    emit(QBRacingEvents.CancelRace, raceId);
    emitNet(RacingEvents.SendDeleteTrack, src, true);
    return;
  }

  emitNet(RacingEvents.SendDeleteTrack, src, false);
});

function parseRecord(record: SQLJSON | null): RaceRecord | null {
  if (!record) {
    return null;
  }

  const raceRecord = JSON.parse(record);

  if (!raceRecord.Holder) {
    return null;
  }

  return {
    name: `${raceRecord.Holder[0]} ${raceRecord.Holder[1]}`,
    time: raceRecord.Time,
  };
}

function parseTrack(users: RawUser[]) {
  return (rawTrack: RawTrack): Track => {
    const record = parseRecord(rawTrack.records);
    const creator = users.find((user) => user.citizenid === rawTrack.creator);
    const charInfo = creator && (JSON.parse(creator.charinfo) as User['charInfo']);
    const creatorName = charInfo ? `${charInfo.firstname} ${charInfo.lastname}` : 'Unknown';

    return {
      records: null,
      ...rawTrack,
      record,
      creatorId: rawTrack.creator,
      creatorName,
      raceId: rawTrack.raceid,
      checkpoints: JSON.parse(rawTrack.checkpoints),
    };
  };
}

function parseRace(users: RawUser[]) {
  return (race: QBRace): Race => {
    const record = parseRecord(JSON.stringify(race.RaceData.Records) as SQLJSON);
    const creator = users.find((user) => user.citizenid === race.SetupCitizenId);
    const charInfo = creator && (JSON.parse(creator.charinfo) as User['charInfo']);
    const creatorName = charInfo ? `${charInfo.firstname} ${charInfo.lastname}` : 'Unknown';

    return {
      id: -1,
      record,
      name: race.RaceData.RaceName,
      racers: race.RaceData.Racers,
      raceCreatorName: creatorName,
      lastLeaderboard: race.RaceData.LastLeaderboard,
      laps: race.Laps,
      waiting: race.RaceData.Waiting,
      started: race.RaceData.Started,
      distance: race.RaceData.Distance,
      creatorName: race.RaceData.Creator,
      raceCreatorId: race.SetupCitizenId,
      raceId: race.RaceId,
      creatorId: race.RaceData.Creator,
      checkpoints: race.RaceData.Checkpoints,
    };
  };
}
