// server/server.ts
var QBCore = exports["qb-core"].GetCoreObject();
var hotReloadConfig = {
  resourceName: GetCurrentResourceName(),
  files: ["/dist/server.js", "/dist/client.js", "/dist/html/index.js"]
};
if (GetResourceState("hotreload") === "started") {
  exports["hotreload"].add(hotReloadConfig);
}
var MYSQL = global.exports["oxmysql"];
exports("ReloadAllTracks", async (arg) => {
  console.log("reloadalltracks");
  emitNet("npwd:qb-racing:updateTracks" /* UpdateTracks */, -1);
});
onNet("npwd:qb-racing:getTracks" /* GetTracks */, async () => {
  const src = source;
  const rawTracks = await MYSQL.query_async("SELECT * from lapraces");
  const rawUsers = await MYSQL.query_async("SELECT citizenid, charinfo from characters");
  const tracks = rawTracks.map(parseTrack(rawUsers));
  emitNet("npwd:qb-racing:sendTracks" /* SendTracks */, src, tracks);
});
onNet("npwd:qb-racing:getRaces" /* GetRaces */, async () => {
  const src = source;
  const rawUsers = await MYSQL.query_async("SELECT citizenid, charinfo from characters");
  const races = await new Promise((resolve) => {
    QBCore.Functions.TriggerCallback("qb-lapraces:server:GetRaces", 0, resolve);
  });
  const parsedRaces = races.map(parseRace(rawUsers));
  emitNet("npwd:qb-racing:sendRaces" /* SendRaces */, src, parsedRaces);
});
onNet("npwd:qb-racing:getUser" /* GetUser */, async () => {
  const src = source;
  const player = QBCore.Functions.GetPlayer(src);
  emitNet("npwd:qb-racing:sendUser" /* SendUser */, src, player.PlayerData);
});
onNet("npwd:qb-racing:deleteTrack" /* DeleteTrack */, async (raceId) => {
  const src = source;
  const player = QBCore.Functions.GetPlayer(src);
  const { affectedRows } = await MYSQL.query_async("DELETE FROM lapraces WHERE creator=? AND raceid=?", [player.PlayerData.citizenid, raceId]);
  if (affectedRows > 0) {
    emit("qb-lapraces:server:CancelRace" /* CancelRace */, raceId);
    emitNet("npwd:qb-racing:sendDeleteTrack" /* SendDeleteTrack */, src, true);
    return;
  }
  emitNet("npwd:qb-racing:sendDeleteTrack" /* SendDeleteTrack */, src, false);
});
function parseRecord(record) {
  if (!record) {
    return null;
  }
  const raceRecord = JSON.parse(record);
  if (!raceRecord.Holder) {
    return null;
  }
  return {
    name: `${raceRecord.Holder[0]} ${raceRecord.Holder[1]}`,
    time: raceRecord.Time
  };
}
function parseTrack(users) {
  return (rawTrack) => {
    const record = parseRecord(rawTrack.records);
    const creator = users.find((user) => user.citizenid === rawTrack.creator);
    const charInfo = creator && JSON.parse(creator.charinfo);
    const creatorName = charInfo ? `${charInfo.firstname} ${charInfo.lastname}` : "Unknown";
    return {
      records: null,
      ...rawTrack,
      record,
      creatorId: rawTrack.creator,
      creatorName,
      raceId: rawTrack.raceid,
      checkpoints: JSON.parse(rawTrack.checkpoints)
    };
  };
}
function parseRace(users) {
  return (race) => {
    const record = parseRecord(JSON.stringify(race.RaceData.Records));
    const creator = users.find((user) => user.citizenid === race.SetupCitizenId);
    const charInfo = creator && JSON.parse(creator.charinfo);
    const creatorName = charInfo ? `${charInfo.firstname} ${charInfo.lastname}` : "Unknown";
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
      checkpoints: race.RaceData.Checkpoints
    };
  };
}
//# sourceMappingURL=server.js.map
