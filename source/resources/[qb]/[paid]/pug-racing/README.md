# Pug-Racing
Pug-Racing 2.0.0
# My other scripts
https://pug-scripts.tebex.io/category/2141020


# Installation

# This needs to go into qb-core/server/players.lua like this https://gyazo.com/18e7a16bf70564f0125e2a93ad545915
PlayerData.metadata['alias'] = PlayerData.metadata['alias'] or 'NO ALIAS'

# Items needed to shared
['ausb2']                       = {['name'] = 'ausb2',                        ['label'] = 'Alias USB',                     ['weight'] = 3000,         ['type'] = 'item',         ['image'] = 'ausb.png',                 ['unique'] = true,         ['useable'] = true,     ['shouldClose'] = true,   ['combinable'] = nil,   ['description'] = 'BE WHOEVER YOU WANT TO BE...'},
['vpn']                       = {['name'] = 'vpn',                        ['label'] = 'Lime USB',                     ['weight'] = 2000,         ['type'] = 'item',         ['image'] = 'limedong.png',                 ['unique'] = true,         ['useable'] = true,     ['shouldClose'] = true,   ['combinable'] = nil,   ['description'] = 'Marked for police seizure...'},

# THIS IS IN CLIENT MAIN TO EDIT IF YOU LIKE
exports['qb-target']:AddBoxZone('limedoor', vector3(720.76, 1292.34, 360.3), 1.4, 1.0, { 
    name = 'limedoor', 
    heading=270,
    --debugPoly=true,
    minZ=359.3,
    maxZ=361.9,
}, {
options = { 
    {
        type = "client",
        event = "Pug:client:VPNDeliveryStart",
        icon = "fas fa-car",
        label = "DELIVERY DRIVERS ONLY",
    },
},
    distance = 1.0,
})   

# INSTALL GUIDE qb-phone client.lua Find these callbacks and change then to match below in qb-phone client.lua
RegisterNUICallback('IsInRace', function(_, cb)
    local InRace = exports['pug-racing']:IsInRace()
    cb(InRace)
end)

RegisterNUICallback('IsAuthorizedToCreateRaces', function(data, cb)
    QBCore.Functions.TriggerCallback('qb-lapraces:server:IsAuthorizedToCreateRaces', function(IsAuthorized, NameAvailable)
        data = {
            IsAuthorized = IsAuthorized,
            IsBusy = exports['pug-racing']:IsInEditor(),
            IsNameAvailable = NameAvailable,
        }
        cb(data)
    end, data.TrackName)
end)

RegisterNUICallback('IsBusyCheck', function(data, cb)
    if data.check == "editor" then
        cb(exports['pug-racing']:IsInEditor())
    else
        cb(exports['pug-racing']:IsInRace())
    end
end)

(**DICOLAIMER**)
REPLACE YOUR CALLBACK WITH THIS IN QB-PHONE CLIENT/MAIN.LUA (the same on both phones)
RegisterNUICallback('SetupRace', function(data, cb)
    TriggerServerEvent('qb-lapraces:server:SetupRace', data.RaceId, tonumber(data.AmountOfLaps), data.isPhasing)
    cb("ok")
end)

(**DICOLAIMER**)
REPLACE YOUR CALLBACK WITH THIS IN QB-PHONE CLIENT/MAIN.LUA (the same on both phones)
RegisterNUICallback('JoinRace', function(data,cb)
    local veh = GetVehiclePedIsIn(PlayerPedId(), false)
    local plate = GetVehicleNumberPlateText(veh)
    if IsPedInAnyVehicle(PlayerPedId()) then
        if GetPedInVehicleSeat(veh, -1) == PlayerPedId() then
            TriggerServerEvent('qb-lapraces:server:JoinRace', data.RaceData, plate)
        end
    else
        QBCore.Functions.Notify('You need to be in a vehicle')
    end
    cb('ok')
end)

# Find racing-setup in qb-phone/html/index.html and replace it with this
(the same on both phones)
<div class="racing-setup">
    <div class="racing-app-header">
        Racing - Setup
    </div>

    <span id="racing-setup-trackheader">Race Track</span>
    <div class="dropdown">
        <div class="select">
            <span>Select a Track</span>
            <i class="fa fa-chevron-left"></i>
        </div>
        <input type="hidden" name="gender">
        <ul class="dropdown-menu"></ul>
    </div>

    <span id="racing-setup-lapsheader">Laps</span>
    <input type="number" min="0" oninput="this.value = Math.abs(this.value)" class="racing-setup-laps" required spellcheck="false" placeholder="Number of laps (0 is Sprint)">

    <span id="phasing-header">Phasing</span>
    <input type="text" class="phasing-toggle" required spellcheck="false" placeholder="true or false">

    <span id="racing-setup-informationheader">Race Information</span>
    <div class="racing-setup-information-distance">Select a Track</div>
    <div class="racing-setup-information-creator">Select a Track</div>
    <div class="racing-setup-information-wr">Select a Track</div>

    <div class="racing-setup-buttons">
        <div class="racing-setup-button" id="setup-race-accept" data-toggle="race-setup" data-placement="bottom" title="Accept">
            <i class="fas fa-check-circle"></i>
        </div>
        <div class="racing-setup-button" id="setup-race-cancel" data-toggle="race-setup" data-placement="bottom" title="Cancel">
            <i class="fas fa-times-circle"></i>
        </div>
    </div>
</div>

# DEFAULT QB-PHONE ONLY. SKIP PAST THESE TO GET TO THE RENEWED PHONE EDIT

(**DICOLAIMER**)
IGNORE THIS AND SKIP IF YOU ARE USING THE RENEWED QB-PHONE EDIT
# Place this in qb-phone\html\js where you find #setup-race-accept like this
$(document).on('click', '#setup-race-accept', function(e){
    e.preventDefault();

    var track = $('.dropdown').find('input').attr('value');
    var laps = $(".racing-setup-laps").val();
    var phase = $(".phasing-toggle").val();

    $.post('https://qb-phone/HasCreatedRace', JSON.stringify({}), function(HasCreatedRace){
        if (!HasCreatedRace) {
            $.post('https://qb-phone/RaceDistanceCheck', JSON.stringify({
                RaceId: track,
                Joined: false,
            }), function(InDistance){
                if (InDistance) {
                    if (track !== undefined || track !== null) {
                        if (laps !== "") {
                            if (phase !== "") {
                                $.post('https://qb-phone/CanRaceSetup', JSON.stringify({}), function(CanSetup){
                                    if (CanSetup) {
                                        $.post('https://qb-phone/SetupRace', JSON.stringify({
                                            RaceId: track,
                                            AmountOfLaps: laps,
                                            isPhasing: phase,
                                        }))
                                        $(".racing-overview").animate({
                                            left: 0+"vh"
                                        }, 300)
                                        $(".racing-setup").animate({
                                            left: -30+"vh"
                                        }, 300, function(){
                                            $(".racing-setup-information-distance").html('Select a Track');
                                            $(".racing-setup-information-creator").html('Select a Track');
                                            $(".racing-setup-information-wr").html('Select a Track');
                                            $(".racing-setup-laps").val("");
                                            $(".phasing-toggle").val("");
                                            $('.dropdown').find('input').removeAttr('value');
                                            $('.dropdown').find('span').text("Select a Track");
                                        });
                                    } else {
                                        QB.Phone.Notifications.Add("fas fa-flag-checkered", "Racing", "There can't be any ..", "#1DA1F2");
                                    }
                                });
                            } else {
                                QB.Phone.Notifications.Add("fas fa-flag-checkered", "Racing", "Choose phasing or not", "#1DA1F2");
                            }
                        } else {
                            QB.Phone.Notifications.Add("fas fa-flag-checkered", "Racing", "Fill in an amount of laps..", "#1DA1F2");
                        }
                    } else {
                        QB.Phone.Notifications.Add("fas fa-flag-checkered", "Racing", "You haven't selected a track..", "#1DA1F2");
                    }
                }
            })
        } else {
            QB.Phone.Notifications.Add("fas fa-flag-checkered", "Racing", "You already have a race active..", "#1DA1F2");
        }
    });
});

(**DICOLAIMER**)
IGNORE THIS AND SKIP IF YOU ARE USING THE RENEWED QB-PHONE EDIT
# Place this into qb-phone\html\CSS\racing.css anywhere
#phasing-header {
    position: absolute;
    left: 2vh;
    top: 25.8vh;
    color: white;
    font-family: 'Poppins', sans-serif;
}

.phasing-toggle {
    position: absolute;
    width: 22vh;
    height: 4vh;
    top: 26.5vh;
    left: 2vh;
    border: none;
    outline: none;
    background-color: transparent;
    border-bottom: .2vh solid #fff;
    font-family: 'Poppins', sans-serif;
    color: white;
    transition: .1s linear;
}

.phasing-toggle:focus {
    border-bottom: .2vh solid rgb(60, 128, 192);
}

.phasing-toggle:valid {
    border-bottom: .2vh solid rgb(55, 199, 27);
}

.phasing-toggle::-webkit-inner-spin-button {
    display: none;
}

(**DICOLAIMER**)
THIS IS FOR BOTH PHONES (RENEWED-PHONE AND QB-PHONE)
# Find this in qb-phone\html\CSS\racing.css and replace it with here:
.name {
	position: relative;
	display: inline-block;
    width: 1vh;
	line-height: 1vh;
}
.time {
	position: relative;
	display: inline-block;
	width: 0vh;
    left: 6.5vh;
    top: -1.2vh;
}
.score {
	position: relative;
	display: inline-block;
	width: 1vh;
    left: 15.5vh;
    top: -2.7vh;
}

(**DICOLAIMER**)
IGNORE THIS AND SKIP IF YOU ARE USING THE RENEWED QB-PHONE EDIT
# Find this in qb-phone\html\CSS\racing.css and replace it with here:
#racing-setup-lapsheader {
    position: absolute;
    left: 2vh;
    top: 19.5vh;
    color: white;
    font-family: 'Poppins', sans-serif;
}

.racing-setup-laps {
    position: absolute;
    width: 22vh;
    height: 4vh;
    top: 20.5vh;
    left: 2vh;
    border: none;
    outline: none;
    background-color: transparent;
    border-bottom: .2vh solid #fff;
    font-family: 'Poppins', sans-serif;
    color: white;
    transition: .1s linear;
}

# THIS PORTION IS FOR RENEWED QB-PHONE EDIT ONLY

(**DICOLAIMER**)
THIS IS FOR RENEWED QB-PHONE EDIT ONLY
# Place this in qb-phone\html\js where you find #setup-race-accept like this
$(document).on('click', '#setup-race-accept', function(e){
    e.preventDefault();

    var track = $('.dropdown').find('input').attr('value');
    var laps = $(".racing-setup-laps").val();
    var phase = $(".phasing-toggle").val();

    $.post('https://qb-phone/HasCreatedRace', JSON.stringify({}), function(HasCreatedRace){
        if (!HasCreatedRace) {
            $.post('https://qb-phone/RaceDistanceCheck', JSON.stringify({
                RaceId: track,
                Joined: false,
            }), function(InDistance){
                if (InDistance) {
                    if (track !== undefined || track !== null) {
                        if (laps !== "") {
                            if (phase !== "") {
                                $.post('https://qb-phone/CanRaceSetup', JSON.stringify({}), function(CanSetup){
                                    if (CanSetup) {
                                        $.post('https://qb-phone/SetupRace', JSON.stringify({
                                            RaceId: track,
                                            AmountOfLaps: laps,
                                            isPhasing: phase,
                                        }))
                                        $(".racing-app-background").animate({
                                            left: -38+"vh"
                                        }, 300);

                                        $(".racing-setup").animate({
                                            left: -76+"vh"
                                        }, 300, function(){
                                            $(".racing-setup-information-distance").html('Select a Track');
                                            $(".racing-setup-information-creator").html('Select a Track');
                                            $(".racing-setup-information-wr").html('Select a Track');
                                            $(".racing-setup-laps").val("");
                                            $(".phasing-toggle").val("");
                                            $('.dropdown').find('input').removeAttr('value');
                                            $('.dropdown').find('span').text("Select a Track");
                                        });
                                    } else {
                                        QB.Phone.Notifications.Add("fas fa-flag-checkered", "Racing", "There can't be any ..", "#1DA1F2");
                                    }
                                });
                            } else {
                                QB.Phone.Notifications.Add("fas fa-flag-checkered", "Racing", "Choose phasing or not", "#1DA1F2");
                            }
                        } else {
                            QB.Phone.Notifications.Add("fas fa-flag-checkered", "Racing", "Fill in an amount of laps..", "#1DA1F2");
                        }
                    } else {
                        QB.Phone.Notifications.Add("fas fa-flag-checkered", "Racing", "You haven't selected a track..", "#1DA1F2");
                    }
                }
            })
        } else {
            QB.Phone.Notifications.Add("fas fa-flag-checkered", "Racing", "You already have a race active..", "#1DA1F2");
        }
    });
});

(**DICOLAIMER**)
THIS IS FOR RENEWED QB-PHONE EDIT ONLY
# Place this into qb-phone\html\CSS anywhere
#phasing-header {
    position: absolute;
    left: 0.5vh;
    top: 20.8vh;
    color: white;
    font-family: 'Poppins', sans-serif;
}

.phasing-toggle {
    position: absolute;
    width: 22vh;
    height: 4vh;
    top: 21.5vh;
    left: 0.5vh;
    border: none;
    outline: none;
    background-color: transparent;
    border-bottom: .2vh solid #fff;
    font-family: 'Poppins', sans-serif;
    color: white;
    transition: .1s linear;
}

.phasing-toggle:focus {
    border-bottom: .2vh solid rgb(60, 128, 192);
}

.phasing-toggle:valid {
    border-bottom: .2vh solid rgb(55, 199, 27);
}

.phasing-toggle::-webkit-inner-spin-button {
    display: none;
}

(**DICOLAIMER**)
THIS IS FOR RENEWED QB-PHONE EDIT ONLY
# Find this in qb-phone\html\CSS and replace it with here:
#racing-setup-informationheader {
    position: absolute;
    left: 0.5vh;
    top: 27vh;
    color: white;
    font-family: 'Poppins', sans-serif;
}

.racing-setup-information-distance {
    position: absolute;
    left: 0vh;
    top: 36vh;
    color: white;
    padding: .5vh;
    padding-left: .5vh;
    padding-right: 1vh;
    border-radius: 4vh;
    font-family: 'Poppins', sans-serif;
}

.racing-setup-information-creator {
    position: absolute;
    left: 0vh;
    top: 33vh;
    color: white;
    padding: .5vh;
    padding-left: .5vh;
    padding-right: 1vh;
    border-radius: 4vh;
    font-family: 'Poppins', sans-serif;
}

.racing-setup-information-wr {
    position: absolute;
    left: 0vh;
    top: 30vh;
    color: white;
    padding: .5vh;
    padding-left: .5vh;
    padding-right: 1vh;
    border-radius: 4vh;
    font-family: 'Poppins', sans-serif;
}

(**DICOLAIMER**)
THIS IS FOR RENEWED QB-PHONE EDIT ONLY
# Find this in qb-phone\client\racing.lua and replace it with here:
RegisterNUICallback('RaceDistanceCheck', function(data, cb)
    QBCore.Functions.TriggerCallback('qb-lapraces:server:GetRacingData', function(RaceData)
        if RaceData then
            local ped = PlayerPedId()
            local coords = GetEntityCoords(ped)
            local checkpointcoords = RaceData.Checkpoints[1].coords
            local dist = #(coords - vector3(checkpointcoords.x, checkpointcoords.y, checkpointcoords.z))
            if dist <= 115.0 then
                if data.Joined then
                    TriggerEvent('qb-lapraces:client:WaitingDistanceCheck')
                end
                cb(true)
            else
                QBCore.Functions.Notify('You\'re too far away from the race. GPS set.', "error", 5000)
                SetNewWaypoint(checkpointcoords.x, checkpointcoords.y)
                cb(false)
            end
        else
            QBCore.Functions.Notify('You need to select a race.', "error", 5000)
        end
    end, data.RaceId)
end)

# Pug-Racing
Pug-Racing 2.0.0

# My other scripts
https://pug-scripts.tebex.io/category/2141020

# Features
● Entirely open resource to fully edit to your liking other than 2 events

● A very clean simplistic user interface

● Toggle option for vehicle phasing

● Multiple blips to see two checkpoints ahead

● Completely optimized positioning that updates when you or others go through a checkpoint

● Fully customizable racing rewards for all race positions

● Custom racing alias item and script provided to obtain racing alias

● 0 known scuff. Has been activly used everyday by lots of players in my live server for two weeks now.

● qb-phone js, css, html files for changes.

● A readme with step by step installation guide.

● Full support in my discord here: https://discord.gg/jYZuWYjfvq.

note:
NITROUS NOT APART OF THIS SCRIPT. YOU CAN GET THAT HERE: https://jimathy666.tebex.io/package/4821399

Requirements consist of:
qb-core
qb-phone
qb-target
qb-input