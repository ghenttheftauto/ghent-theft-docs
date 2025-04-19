# Time

## Introduction

Ghent Theft Auto can be run in realtime, i.e. local time with a realtime game speed.

The progression of time in Ghent Theft Auto can also be manipulated to simulate higher or lower speeds.

Time is even able to be halted completely by a single Player.

This means time of day and calendar are fully mocked.

The [[⏳ Time]] namespace contains public events for sunset and sunrise, allowing for example [[💡 Street Lamp]] behaviors.

Time has events based on day of week, triggering [[💼 Profession]] behaviors. Conversely, Weekend and Holiday events will cause [[👤 Human]] to stay at their [Residence](https://www.notion.so/Residence-0867e0ef50764c3686f227342945cf02?pvs=21) .

Example given:

On any given Sunday...

- a [[👩‍🎓 Student]] _doesn't_ go to school on a Sunday as part of their [[💼 Profession]]
- a [[🧙‍♂️ Priest]] **_does_** go to [[🧎‍♂️ Place of worship]] to perform activities related to their [[💼 Profession]]
- [[👩‍🎓 Student]] **can** still attend church to fill their Piety need.

Buildings that have a build year are only shown when the year has passed. For this, we use the calculated pivot of building instances and request the converted WGS84 as an address, we then use this address to look up build year on the GRB API.

## Events

Calendar events are calculated for each year.

[[👒 Holidays]]

## Systems

Time drives systems such as:

- analog clocks such as on the Belfry, the [[🚉 Train station]], etc.
- the ringing of [[🧎‍♂️ Place of worship]] bells
- opening and closing hours of public locations, such as [Shops](https://www.notion.so/Shops-e7f46c3dccdd49738b4512dd1d23848a?pvs=21) or [[🅿️ Parking]]
- activation and deactivation of [[💡 Street Lamp]]
- activity of citizens, based on [[💼 Profession]]
- spawning of trash, as described in [[🚮 Sanitation]]]
- graduation of [[👩‍🎓 Student]] at the end of the academic year
- Holidays:
  - Fireworks at [[0101_Nieuwjaarsdag_🎊]]
  - Gentse Feesten
- Construction (and deconstruction) of buildings based on historical data
- Feeding historical data into the simulation such as population numbers, (un)employment, etc.

## A single day in GhTA

### 00:00

DateTime is advanced one day

new weather data is assigned to the climate

Date is checked for date bound events such as:

- day of week
- nye

### 01:00

bells ring one time at churches because it’s 1 o clock

### 04:37

the moon dissappears behind the horizon because we calculated it using CoordinateSharp

### 07:30

coordinate sharp provided us with a sunrise so we turn off the street lights

### 08:00

since we parsed OSM opening hours for a store, it opens at this hour

### 08:30

schools dont have opening hours but are hardcoded to open at 8:30

### 11:15

analog clocks display 11:15 on Belfort and Sint Pieters station, for example

### 13:47

a train arrives at Gent Dampoort, parsed from [iRail API](https://www.notion.so/iRail-API-808a188b7fd74aac857e6d2fb0dfcdfb?pvs=21)

### 14:00

a postman picks up mail from a postbox parsed from OSM API

### 17:30

a bus leaves at the Zuid, parsed from De Lijn

### 18:00

shops close in the Veldstraat because we parsed their opening hours
