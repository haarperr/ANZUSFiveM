import { SQLJSON } from './Common';

export interface Coord {
  coords: { y: number; x: number; z: number };
  offset: {
    left: { y: number; x: number; z: number };
    right: { y: number; x: number; z: number };
  };
}

export interface LeaderBoard {}

export interface Racer {
  id: string;
  name: string;
  Checkpoint: number;
  finished: boolean;
  lap: number;
}

export interface RaceRecord {
  name: string;
  time: number;
}

export interface RawTrack {
  id: number;
  raceid: string;

  name: string;
  distance: number;

  checkpoints: SQLJSON;
  records: SQLJSON;

  creator: string;
}

export interface Track {
  id: number;
  raceId: string;

  name: string;
  distance: number;

  record: RaceRecord | null;
  checkpoints: Coord[];

  creatorId: string;
  creatorName: string;

  distanceToTrack?: number;
}

export interface QBRace {
  RaceId: string;
  SetupCitizenId: string;
  Laps: number;
  RaceData: {
    LastLeaderboard: [];
    Started: boolean;
    RaceId: string;
    Distance: number;
    RaceName: string;
    Checkpoints: Coord[];
    Waiting: boolean;
    Racers: Record<string, Racer>;
    Creator: string;
    Records: {
      Time: number;
      Holder: string[];
    };
  };
}

export interface Race extends Track {
  laps: number;
  raceCreatorId: string;
  raceCreatorName: string;
  started: boolean;
  waiting: boolean;
  lastLeaderboard: LeaderBoard;
  racers: Record<string, Racer>;
}

export interface CreateRaceInput {
  RaceId: string;
  laps: number;
  isPhasing: boolean;
}

export interface JoinRaceInput {
  raceId: string;
  raceName: string;
}

export interface LeaveRaceInput {
  raceId: string;
  raceName: string;
}

export interface GetDistanceToRaceInput {
  raceId: string;
  joined: boolean;
}
