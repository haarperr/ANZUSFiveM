# qbx-apartments
Apartments System for QBOX-Core Framework :office:

## Dependencies
- [qbx-core](https://github.com/Qbox-project/qbx-core)
- [qbx-clothing](https://github.com/Qbox-project/qbx-clothing) - To save outfits
- [qbx-houses](https://github.com/Qbox-project/qbx-houses) - House logic
- [qbx-interior](https://github.com/Qbox-project/qbx-interior) - Interior logic
- [qbx-weathersync](https://github.com/Qbox-project/qbx-weathersync) - To desync weather while inside
- [qbx-spawn](https://github.com/Qbox-project/qbx-spawn) - To spawn the player at apartment if last location was in apartment

## Screenshots
![Inside Apartment](https://i.imgur.com/mp3XL4Y.jpg)
![Inside Apartment](https://i.imgur.com/3DH9RFw.jpg)
![Enter Apartment](https://imgur.com/1giGyt1.png)
![Stash](https://imgur.com/t6crf4c.png)
![Saved Outfits](https://imgur.com/I0YLuQA.png)
![Log Out](https://imgur.com/q1Yx3nS.png)

## Features
- Door Bell
- Stash
- Log Out Marker
- Saved Outfits

## Installation
### Manual
- Download the script and put it in the `[qbx]` directory.
- Import `qbx-apartments.sql` in your database
- Add the following code to your server.cfg/resouces.cfg
```
ensure qbx-core
ensure qbx-interior
ensure qbx-weathersync
ensure qbx-clothing
ensure qbx-houses
ensure qbx-spawn
ensure qbx-apartments
```

## Configuration
```
Apartments = {} -- Don't touch

Apartments.SpawnOffset = 30 -- Don't touch

Apartments.Locations = {
    ["apartment1"] = { -- Needs to be unique
        name = "apartment1", -- Apartment id
        label = "South Rockford Drive", -- Apartment Label (for Blip and other stuff)
        coords = {
            enter = {x = -667.372, y = -1106.034, z = 14.629, h = 65.033}, -- Enter Apartment Marker Location
            doorbell = {x = -667.601, y = -1107.354, z = 15.133, h = 65.033}, -- Exit Apartment Marker Location
        }
    },
    ["apartment2"] = {
        name = "apartment2",
        label = "Morningwood Blvd",
        coords = {
            enter = {x = -1288.046, y = -430.126, z = 35.077, h = 305.348},
            doorbell = {x = -667.682, y = -1105.876, z = 14.629, h = 65.033},
        }
    },
    ["apartment3"] = {
        name = "apartment3",
        label = "Integrity Way",
        coords = {
            enter = {x = 269.075, y = -640.672, z = 42.02, h = 70.01},
            doorbell = {x = -667.682, y = -1105.876, z = 14.629, h = 65.033},
        }
    },
    ["apartment4"] = {
        name = "apartment4",
        label = "Tinsel Towers",
        coords = {
            enter = {x = -621.016, y = 46.677, z = 43.591, h = 179.36},
            doorbell = {x = -667.682, y = -1105.876, z = 14.629, h = 65.033},
        }
    },
    ["apartment5"] = {
        name = "apartment5",
        label = "Fantastic Plaza",
        coords = {
            enter = {x = 291.517, y = -1078.674, z = 29.405, h = 270.75},
            doorbell = {x = -667.682, y = -1105.876, z = 14.629, h = 65.033},
        }
    },
}
```
