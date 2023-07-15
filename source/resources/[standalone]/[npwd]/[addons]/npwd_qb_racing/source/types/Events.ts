export enum RacingEvents {
  GetTracks = 'npwd:qb-racing:getTracks',
  SendTracks = 'npwd:qb-racing:sendTracks',

  GetRaces = 'npwd:qb-racing:getRaces',
  SendRaces = 'npwd:qb-racing:sendRaces',

  GetUser = 'npwd:qb-racing:getUser',
  SendUser = 'npwd:qb-racing:sendUser',

  CreateTrack = 'npwd:qb-racing:createTrack',
  DeleteTrack = 'npwd:qb-racing:deleteTrack',
  SendDeleteTrack = 'npwd:qb-racing:sendDeleteTrack',
  SetupRace = 'npwd:qb-racing:setupRace',

  JoinRace = 'npwd:qb-racing:joinRace',
  LeaveRace = 'npwd:qb-racing:leaveRace',
  StartRace = 'npwd:qb-racing:startRace',
  StopRace = 'npwd:qb-racing:stopRace',

  UpdateTracks = 'npwd:qb-racing:updateTracks',
}

export enum QBRacingEvents {
  SetupRace = 'qb-lapraces:server:SetupRace',
  JoinRace = 'qb-lapraces:server:JoinRace',
  CreateTrack = 'qb-lapraces:server:CreateLapRace',
  LeaveRace = 'qb-lapraces:server:LeaveRace',
  StartRace = 'qb-lapraces:server:StartRace',
  WaitingDistanceCheck = 'qb-lapraces:client:WaitingDistanceCheck',
  GetRacingData = 'qb-lapraces:server:GetRacingData',
  GetIsAuthorizedToCreateRaces = 'qb-lapraces:server:IsAuthorizedToCreateRaces',
  UpdateRaceState = 'qb-lapraces:server:UpdateRaceState',
  CancelRace = 'qb-lapraces:server:CancelRace',
}

export enum NUIEvents {
  UpdateData = 'npwd:qb-racing:updateData',
  GetDistanceToRace = 'npwd:qb-racing:getDistanceToRace',
  GetIsAuthorizedToCreateRaces = 'npwd:qb-racing:getIsAuthorizedToCreateRaces',
}
