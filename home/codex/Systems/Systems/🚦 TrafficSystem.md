# TrafficSystem

kinda has to do with [[🅿️ Parking]]

The traffic system is a global system, i.e. it’s not linked to specific tiles and stays loaded the whole time on top of the map.

Keeping this system lightweight will be crucial. It’s nature lends it to be a prime candidate for conversion to the JobSystem and there are some ECS examples online.

Individual segments are parsed from OSM and instantiated by TrafficController.

An algorithm traverses all these nodes and builds a branch.

For this purpose, roads are sorted along their name. The first road of a batch is picked, we search for other segments where:

- the last point of the other segment equals the first point of our current segment, or
- the first point of the other segment equals the last point of our current segment

When one of the above is true, we configure the segments, linking them up until we run out of options.

When the segment is completely back filled and forward filled, it is considered a complete road and the segments that make it up are removed from the unsorted list.

Then, a new random segment is selected from the unsorted list and the process is started again.

When traffic network is available, cars are spawned on top of it. (Check out Megacity demo where they include cars in baking)

Cars are assigned a segment and traverse it. When they end their segment, they are offered options.

When no options are available, car will attempt to reverse if it is allowed.

When no options are available on a one way road, car will return to vehicle pool and await new spawn.

Roads should be as modular and lightweight as possible, using the tag dictionary and maybe interfaces.
