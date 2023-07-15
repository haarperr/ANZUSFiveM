(() => {
  var __defProp = Object.defineProperty;
  var __defProps = Object.defineProperties;
  var __getOwnPropDescs = Object.getOwnPropertyDescriptors;
  var __getOwnPropSymbols = Object.getOwnPropertySymbols;
  var __hasOwnProp = Object.prototype.hasOwnProperty;
  var __propIsEnum = Object.prototype.propertyIsEnumerable;
  var __defNormalProp = (obj, key, value) => key in obj ? __defProp(obj, key, { enumerable: true, configurable: true, writable: true, value }) : obj[key] = value;
  var __spreadValues = (a, b) => {
    for (var prop in b || (b = {}))
      if (__hasOwnProp.call(b, prop))
        __defNormalProp(a, prop, b[prop]);
    if (__getOwnPropSymbols)
      for (var prop of __getOwnPropSymbols(b)) {
        if (__propIsEnum.call(b, prop))
          __defNormalProp(a, prop, b[prop]);
      }
    return a;
  };
  var __spreadProps = (a, b) => __defProps(a, __getOwnPropDescs(b));

  // node_modules/@project-error/pe-utils/lib/client/functions.js
  var RegisterNuiCB = (event, callback) => {
    RegisterNuiCallbackType(event);
    on(`__cfx_nui:${event}`, callback);
  };

  // client/client.ts
  var QBCore = global.exports["qb-core"].GetCoreObject();
  var npwdExports = global.exports["npwd"];
  RegisterNuiCB("npwd:qb-racing:getTracks" /* GetTracks */, (_, cb) => {
    emitNet("npwd:qb-racing:getTracks" /* GetTracks */);
    onNet("npwd:qb-racing:sendTracks" /* SendTracks */, (data) => {
      cb({ status: "ok", data: data.map(addDistanceToTrack) });
    });
  });
  onNet("npwd:qb-racing:updateTracks" /* UpdateTracks */, () => {
    npwdExports.sendUIMessage({ type: "npwd:qb-racing:updateData" /* UpdateData */, payload: {} });
  });
  RegisterNuiCB("npwd:qb-racing:getRaces" /* GetRaces */, (_, cb) => {
    emitNet("npwd:qb-racing:getRaces" /* GetRaces */);
    onNet("npwd:qb-racing:sendRaces" /* SendRaces */, (data) => {
      cb({ status: "ok", data });
    });
  });
  RegisterNuiCB("npwd:qb-racing:getUser" /* GetUser */, (_, cb) => {
    emitNet("npwd:qb-racing:getUser" /* GetUser */);
    onNet("npwd:qb-racing:sendUser" /* SendUser */, (data) => {
      cb({ status: "ok", data });
    });
  });
  RegisterNuiCB("npwd:qb-racing:setupRace" /* SetupRace */, (data, cb) => {
    var _a;
    emitNet("qb-lapraces:server:SetupRace" /* SetupRace */, data.RaceId, data.laps, (_a = data.isPhasing) != null ? _a : false);
    cb({ status: "ok" });
  });
  RegisterNuiCB("npwd:qb-racing:joinRace" /* JoinRace */, (data, cb) => {
    const veh = GetVehiclePedIsIn(PlayerPedId(), false);
    const plate = GetVehicleNumberPlateText(veh);
    if (IsPedInAnyVehicle(PlayerPedId(), false)) {
      if (GetPedInVehicleSeat(veh, -1) == PlayerPedId()) {
        emitNet("qb-lapraces:server:JoinRace" /* JoinRace */, { RaceName: data.raceName, RaceId: data.raceId }, plate);
      }
    } else {
      QBCore.Functions.Notify("You need to be in a vehicle");
    }
    cb({ status: "ok" });
  });
  RegisterNuiCB("npwd:qb-racing:leaveRace" /* LeaveRace */, (data, cb) => {
    emitNet("qb-lapraces:server:LeaveRace" /* LeaveRace */, { RaceName: data.raceName, RaceId: data.raceId });
    cb({ status: "ok" });
  });
  RegisterNuiCB("npwd:qb-racing:startRace" /* StartRace */, (raceId, cb) => {
    emitNet("qb-lapraces:server:StartRace" /* StartRace */, raceId);
    cb({ status: "ok" });
  });
  RegisterNuiCB("npwd:qb-racing:createTrack" /* CreateTrack */, (trackName, cb) => {
    emitNet("qb-lapraces:server:CreateLapRace" /* CreateTrack */, trackName);
    cb({ status: "ok" });
  });
  RegisterNuiCB("npwd:qb-racing:deleteTrack" /* DeleteTrack */, (raceId, cb) => {
    emitNet("npwd:qb-racing:deleteTrack" /* DeleteTrack */, raceId);
    onNet("npwd:qb-racing:sendDeleteTrack" /* SendDeleteTrack */, (isSuccess) => {
      cb({ status: "ok", data: isSuccess });
    });
  });
  onNet("qb-phone:client:UpdateLapraces", () => {
    npwdExports.sendUIMessage({ type: "npwd:qb-racing:updateData" /* UpdateData */, payload: {} });
  });
  RegisterNuiCB("npwd:qb-racing:getDistanceToRace" /* GetDistanceToRace */, (data, cb) => {
    QBCore.Functions.TriggerCallback("qb-lapraces:server:GetRacingData" /* GetRacingData */, (race) => {
      const ped = PlayerPedId();
      const coords = GetEntityCoords(ped, true);
      const raceCoords = race.Checkpoints[0].coords;
      const distance = getDistance(getVector(coords), raceCoords);
      if (distance <= 115) {
        if (data.joined) {
          emit("qb-lapraces:client:WaitingDistanceCheck" /* WaitingDistanceCheck */);
        }
        cb(true);
      } else {
        QBCore.Functions.Notify("You're too far away from the race. GPS has been set to the race.", "error", 7500);
        SetNewWaypoint(raceCoords.x, raceCoords.y);
        cb(false);
      }
    }, data.raceId);
  });
  RegisterNuiCB("npwd:qb-racing:getIsAuthorizedToCreateRaces" /* GetIsAuthorizedToCreateRaces */, (trackName, cb) => {
    QBCore.Functions.TriggerCallback("qb-lapraces:server:IsAuthorizedToCreateRaces" /* GetIsAuthorizedToCreateRaces */, (isAuthorized, isNameAvailable) => {
      cb([isAuthorized, isNameAvailable, global.exports["pug-racing"].IsInEditor()]);
    }, trackName);
  });
  function addDistanceToTrack(track) {
    const ped = PlayerPedId();
    const coords = GetEntityCoords(ped, true);
    const trackCoords = track.checkpoints[0].coords;
    const distance = getDistance(getVector(coords), trackCoords);
    return __spreadProps(__spreadValues({}, track), {
      distanceToTrack: distance
    });
  }
  function getVector(coords) {
    const [x, y, z] = coords;
    return {
      x,
      y,
      z
    };
  }
  function getDistance(v1, v2) {
    const dx = v1.x - v2.x;
    const dy = v1.y - v2.y;
    const dz = v1.z - v2.z;
    return Math.sqrt(dx * dx + dy * dy + dz * dz);
  }
  RegisterNuiCB("npwd:qb-racing:stopRace" /* StopRace */, (raceId, cb) => {
    emitNet("qb-lapraces:server:CancelRace" /* CancelRace */, raceId);
    cb({ status: "ok" });
  });
})();
