import { FlagRounded, PeopleAlt } from '@mui/icons-material';
import {
  Avatar,
  Button,
  Card,
  CardActions,
  CardContent,
  CardHeader,
  Chip,
  Divider,
  Stack,
  Tooltip,
} from '@mui/material';
import React from 'react';
import { useRecoilValue } from 'recoil';
import { userAtom } from '../atoms/user';
import { GetDistanceToRaceInput, JoinRaceInput, LeaveRaceInput, Race } from '../../types/Racing';
import fetchNui from '../utils/fetchNui';
import { NUIEvents, RacingEvents } from '../../types/Events';

interface RaceCardProps {
  race: Race;
  onUpdate(): void;
}

const RaceCard = ({ race, onUpdate }: RaceCardProps) => {
  const user = useRecoilValue(userAtom);
  const userId = user?.citizenid ?? '';

  const isSprint = race.laps === 0;
  const isCreator = race.raceCreatorId === userId;
  const isCompeting = Boolean(race.racers[userId]);
  const numberOfRacers = Object.keys(race.racers).length;

  const handleLeave = async () => {
    await fetchNui<boolean, LeaveRaceInput>(RacingEvents.LeaveRace, {
      raceId: race.raceId,
      raceName: race.name,
    });
    onUpdate();
  };

  const handleJoin = async () => {
    const isNearby = await fetchNui<boolean, GetDistanceToRaceInput>(NUIEvents.GetDistanceToRace, {
      raceId: race.raceId,
      joined: true,
    });

    if (!isNearby) {
      // Notify failure to join
      return;
    }

    await fetchNui<boolean, JoinRaceInput>(RacingEvents.JoinRace, {
      raceId: race.raceId,
      raceName: race.name,
    });
    onUpdate();
  };

  const handleStart = async () => {
    await fetchNui(RacingEvents.StartRace, race.raceId);
    onUpdate();
  };

  const handleStop = async () => {
    await fetchNui(RacingEvents.StopRace, race.raceId);
    onUpdate();
  };

  return (
    <Card elevation={4}>
      <CardHeader
        title={`${race.name} ${isSprint ? '(Sprint)' : ''}`}
        subheader={race.raceCreatorName}
        avatar={
          <Avatar
            alt={race.raceCreatorName}
            sx={{ backgroundColor: 'primary.main', color: 'primary.contrastText' }}
          >
            {race.raceCreatorName.substring(0, 1)}
          </Avatar>
        }
        action={
          <Chip
            color={race.started ? 'primary' : 'default'}
            label={race.started ? 'Started' : 'Not started'}
          />
        }
      />

      <CardContent>
        <Stack direction="row" spacing={1}>
          <Tooltip title="Competitors">
            <Chip
              icon={<PeopleAlt fontSize="small" sx={{ paddingLeft: '0.35rem' }} />}
              label={`${numberOfRacers}`}
            />
          </Tooltip>

          <Tooltip title={`${isSprint ? '0 laps (Sprint)' : 'Laps'}`}>
            <Chip
              label={`${isSprint ? 'Sprint' : race.laps}`}
              icon={<FlagRounded fontSize="small" sx={{ paddingLeft: '0.25rem' }} />}
            />
          </Tooltip>

          <Tooltip title="Race distance">
            <Chip label={`${(race.distance / 1609).toFixed(2)}m`} />
          </Tooltip>
        </Stack>
      </CardContent>

      <Divider light />

      {race.started ? (
        <CardActions disableSpacing>
          <Stack direction="row" spacing={1} marginLeft="auto">
            {isCreator && (
              <Button color="error" onClick={handleStop}>
                Stop
              </Button>
            )}

            {isCompeting && (
              <Button color="error" onClick={handleLeave}>
                Abort
              </Button>
            )}
          </Stack>
        </CardActions>
      ) : (
        <CardActions disableSpacing>
          <Stack direction="row" spacing={1} marginLeft="auto">
            {isCreator && (
              <Button color="error" onClick={handleStop}>
                Delete
              </Button>
            )}

            {isCompeting ? (
              <Button color="error" onClick={handleLeave}>
                Leave
              </Button>
            ) : (
              <Button color="success" onClick={handleJoin}>
                Join
              </Button>
            )}

            {isCreator && (
              <Button color="success" disabled={numberOfRacers === 0} onClick={handleStart}>
                Start
              </Button>
            )}
          </Stack>
        </CardActions>
      )}
    </Card>
  );
};

export default RaceCard;
