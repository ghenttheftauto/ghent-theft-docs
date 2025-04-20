# ☢️ Nukemap

What is one the most outlandish ways to query a city-scale spatial datastructure fast?

You **nuke** it. In 2 milliseconds.

You've seen them. The cute webmap tile interfaces supposed to make your bones shudder or something when they draw three concentric circles, each a different color.

Some number is ticking up somewhere in the corner of the map.

Pathetic.

Imagine you’ve got 270,000 entities in Ghent running around in between 127,000 buildings. Each building, person, and bird is spatially indexed.

We want to ask it: what is visible? What _feels_ the heat?

What does a mach stem ripping through 800+ years of history look like?

Would the Citadel bunker shield you from a neutron bomb?

**Yes**. This is peak Ghent Theft Auto, and _you know_ you love it too.

## 🤹‍♂️ Concentric circles

We don't want to render pixels. We want to render Celcius, Pascal and Sievert.

### 🔥 Thermal Radiation

Melted stained glass windows.

### 💨 Overpressure Shockwave

Doornikse blauwsteen turned to shrapnel.

### 🌫️ Fallout Radius

Radioactive Macha tea in Patershol date?

## 🧠 Query by Death

This isn't `SELECT \* FROM Buildings WHERE Distance < radius`.

Ghent is a Quadtree.
The payload is a Vector3.
The sradius is a float.

We traverse once. We run a visibility check with shadows and render targets.

We say: "Show me what’s dead."

The engine responds: "Everyone east of the ring road except that guy swimming, but the fallout gets him about 30 minutes later."

We imprint the `BitGrid` with isotopes for that real real.

## 📍 Precision, please

Want to know if a glass pane at Graslei survives? We can tell you.

Want to know if a pigeon 340 meters up gets flash-fried? Also yes.

This isn’t just nuke-core.
This is context-aware annihilation.

## Don't mention the war

For those with delicate dispositions: yes, you can look away. I am a math enjoyer, I don't fatshame isotopes.
