# 🐺 The Steppe

Ever since I read this [VRT article](https://www.vrt.be/vrtnws/nl/2025/03/10/gent-archeologie-prehistorie-geschiedenis-sint-baafskathedraal-o/) about deep soil drilling beneath the Saint Bavo cathedral, I've been thinking about the [Steppe](xref:Life.Steppe). 🐺🌙🦬

> "De oudste afzetting is een dikke zandlaag die afgezet is door de wind, vanuit het Noordzeebekken. **Dat gebeurde in de prehistorie, 18.000 tot 14.650 jaar geleden**.

This triggered me to 'tick the game loop back to 18,000 BCE to pre-cook the simulation and all it's souls', not just as a technical gimmick but as an act of reverence.

The tundra beneath Sint-Baafskathedraal remembers. We know we can do it since we fixed [Easter](easter.md) with Metonic cycles and Epacts. We just need more maths, bigger numbers and possibly more balls, than the monks did in 500AD.

In the simulation, every living human is tied to a Soul. These are not erased upon death—they return to the Steppe. A `static` list of 227,000 souls forms the canonical registry, passed around like candle flames between vessels. You can invoke the GC on a [IVessel](xref:Humans.IVessel), but the Soul `struct` is `readonly`.

## The Plan

This doc serves as a napkin to scriblle manic thoughts on as I descend into the rabbit hole that is Easter calc for mammoths.

The plan? We start out _anno domini style_ where we have access to wonderful things like [DateTime](xref:System.DateTime) and [Solar Time lib](dunnoyet). We ask those friendly boys for a DayOfWeek, Day, Month, Year yadda.

In combination with a Astronomical Date (is this a float?). We then take a very dependable monk and counting frame, and let that wonderful dude count back 6 million times using like, a slightly better Epact, I think.

Like a Gregorian Epact. If possible. The AstroLib is still giving us coherent days, because the orbital period of the Earth has been super stable since like forever. Earth's spin rate (day length) is another thing. Lucklly the Steppe throws a SteppeException when we go back beyond 20k years from now. Where was I? Ah yes. The Epact 2.0. Afaik the Computus is still dank, the only thing kinda mid is the Epact because counting frame reasons.

But like we can Computus more dank, more stank, float Epact, count shit all the way back after 6 million ticks we ask the monks yo whatsup and they are all like, its a fecking monday 03 april -180000, there is a mammoth standing next to me and ash wednesdays was two weeks ago, happy birthday btw!!!"

Any temporal simulation, any render engine is already ticking dat clock. We are just gonna make ART out of it. Dank easter on fleek Lent, #BlazeItSarracen.

Do we cook a better epact?

“If I render it in a datepicker, it’s Gregorian. Always has been.”
– Me, reclaiming time from scared historians

### Tick tock on the clock, and the dj don't stop

```csharp
public readonly long TicksSinceSteppeEpoch;
```

Every game engine ticks. We just do it in style.

Turns out 30k BCE there were early modern humans in France carving moon days into stones. SOURCE THIS.
Those guys with the cave paintings. Not really Neaderthal territory.

8K BCE Warren Field calendar in Scotland, consist of a series of pits that align with lunar phases, suggesting a base12 method to track months and base4 seasons.

Stonehenge tracks base2 equinoxes.

Turns out I'm the clown after all! Big surprise.

### Sky answers

> Long ago the humans looked at the sky, a UI they didnt build and desperately wanted to parse.

You might be looking at me funny for a lot of reasons, but I can imagine a main one being 'why is this guy so obsessed with monks'.

I'm not religious, it's just that monks from all over the world had this tendency to model the natural world, to explain it, predict it and harness it. They needed God, we have Steve Ballmer.

So you got Chinese monks scribing down Chang'e stuff all the way over there (oh yeah, we are already at that time and place in the article where time and place become interchangeable)

Meanwhile you got the Euro branch of monk coders typing it down in Computus dank (the same Computus we still use to order Easter bunnies).

I see a lot of data points.

We gonna have a Sun God System looping perfect stable orbits for 20k years and one C# monk on a counting frame ticking the stuff into comprehensible SteppeDateTime.

We gonna have unit tests backtesting Gregorian date deletion, battle of hastings wednesdayness, we gonna unit test the og ash wednesday of wednesydayness.

It's gonna be wild af.

### 🔧 Gregorian Proleptic Supremacy

SteppeTime uses the Gregorian calendar everywhere, for all ticks, from Tick 0 (-18000-04-03) to the Heat Death of the Simulation™.

There is no fallback to Julian.

There is no concern for 1582.

There is no drift, no patch, no reform.

It’s all one smooth calendar, like you’d expect in a database UI, a date picker, or a divine ledger.

🚨 Historical Correction:
"Hastings was on a Saturday in the Julian calendar."

⚠️ Yeah? Well that's cool and all and we will compare it to our Gregorian but with a 10 day offset.
The Steppe remembers—but on our terms.

This isn’t heresy. This is temporal sovereignty.

### SteppeDateTime

SteppeDate what are you doing????

We gon mimick/wrap/extends a System.DateTime into a GhTA.SteppeDateTime. Yes.

SteppeDateTime is the most primal form of time. Positive big integer number, very `long`.

### Modulo Math

Easiest counting frame ever.

If it's a Saturday today, and I make you count back 6 millie times on a counting frame, you should still be able to tell me what weekday it is from our Gregorian hotfix lens, which is the only one that matters for us.

```csharp
DayOfWeek day = 685493058 % 7 as DayOfWeek
```

`.DayOfWeek => Ticks % 7` and we _done_.

Computation without dogma. Love to see it.

The 7-day cycle has been unbroken since ancient Babylon, regardless of calendar reforms?

7 gods, 7 days.

Bronze age

jewish tradition to romans

accepted under constantine

once it got locked in with islamic

the [Days](xref:Days) are all [Celestial](xref:Celestial).

### Before the Common Era vs Anno Domini

Dem Monks never leave the room when we talk time. 🙄

So yeah true: monkboys also decided our **Anno Domini** and what we consider Before the Christ Era or **Before the Common Era**. I know, total buzzkill. Whole other story.

All I know is that's where our offset lies.

So like when i talk -18000, the SteppeDate sees 0.

Shokran Al-Mashrik 🙏

Me? As a feral chaotic vibe mathematician, I just want clean positive integers, preferably very `long`.

### 🧮 Epact++? EpactSharp? SteveBallmerPact?

A monk thing.

The Epact is basically how many days are between the moon's year and the solar year. Used in the Computus (how they compute Easter). Julian monks say it’s ~11 days. Gregorian monks patched it.

They cooked that stuff up on a counting frame so they didn't have to look at the Moon because deep down they know there is no God other than our Sun and the Moon. But I digress!!!

We C# Computus a float Epact that transcends Julian leap year logic and can tick us into the Steppe without drift.

We can totally cook this. Here's the vibe:

Earth orbit (tropical year) = ~365.24219 days

Lunar month (synodic) = ~29.530588 days

So lunar year = 12 × 29.530588 = 354.36706 days

Difference = ~10.87513 days per year

Your float epact is basically:

```csharp
float epact = (yearsSinceBaseEpoch \* 10.87513f) % 29.530588f;
```

Ceremonial Modulo: How % 29.530588f might actually be the closest we get to divine division.

We just locked in a moon phase calculator that works 20,000 years deep on spite only. Watch and learn kids.

From here on we can derive lunar phases, Easter-style events, Sabbats, Solstices, or weird time rituals in the Steppe Calendar.

Much like the monks but unit testable against [AstroLib].

## Backtesting

YouTube traders backtest markets.
We backtest centuries.

### 1066 Hastings, 742 2 April Wednes day

> At dawn on Saturday 14 October 1066, two great armies prepared to fight for the throne of England.

```csharp
[Test]
public void HastingsWasWednesday()
{
    long ticksFromEpoch = DaysFromSteppeEpoch(-1066, 10, 14);
    var dt = new SteppeDateTime(ticksFromEpoch);
    Assert.AreEqual(DayOfWeek.Saturday, dt.DayOfWeek);
}
```

```csharp
[Test]
public void HastingsWasSaturday()
{
    var steppe = new SteppeDateTime(DaysFromSteppeEpoch(-1066, 10, 24)); // Gregorian
    var julian = JulianConverter.ToGregorian("1066-10-14"); // Historical record
    Assert.AreEqual(julian.DayOfWeek, steppe.DayOfWeek); // Alignment = ✅
}
```

this is kinda complex for pe 1580 ish because of gregory

This one’s big. The Gregorian reform happened in October 1582 (or later in Protestant countries). We can’t assume a continuous Gregorian calendar before then.

✅ Fix:

SteppeDateTime is proleptic Gregorian (extends it infinitely backward)

But historical events like Hastings must be tested via Julian calendar conversion.

We can build a SteppeJulianConverter that handles this logic. Your engine should treat Gregorian as default but allow Julian corrections for events before 1582 if required.

#### **👑 Charlemagne's Birth**

> On Wednesday the 2nd of April 742 a great King was born in France (?)

This date is widely accepted among historians, and the weekday aligns with the proleptic Gregorian calendar.

### The Wednesydayness of Ash Wednesday

```csharp
[Test]
public void AshWednesdayFeelsCorrect()
{
    var ash = new SteppeDateTime(DaysFromSteppeEpoch(2025, 3, 5));
    Assert.AreEqual(DayOfWeek.Wednesday, ash.DayOfWeek); // Sanity baseline
}

```

### Julian Drift Detection

Julian dates drift 3 days every 400 years.

We simulate this drift to verify the superior Epact we cooked.

### Delta T Liturgy – Moon Phase Regression

Backtest superior epact against regression of moonphase.

11 != ~10.87513 days, get shysted.

## Theological SteppeTime Challenges

### LeapSecond heresy

The LeapSecond Heresy: why UTC cannot be trusted in the Steppe.

📜 We reject Earth’s wobble as a calendrical truth.

It's a cringe 1972 patch made by some incels for political reasons.

UTC has no authority in the Steppe. All SteppeTime is based on dynamical time (Terrestrial Time, TT).

### The 0 Bug

Year 0 doesn't exist in Gregorian logic. But it does in the Steppe.
Because the Steppe says: "A beginning with no name still counts."

Very beta monks thought of Arabic zero too be too chad and/or blasphemous so yeah.

Our years are not zero indexed. Very Haram.

```markdown
“Ash Wednesday was two weeks ago.
There is a mammoth next to me.
Happy birthday, btw.”

— Gospel of the Steppe, line 1.
```

🚫 No Year 0 in Gregorian
✅ Your fix: The SteppeCalendar has a Year 0. Gregorian doesn’t.

In historical reality:

1 BCE → 1 CE jumps by 1.

But astronomers use astronomical year numbering, where 0 = 1 BCE, -1 = 2 BCE, etc.

📜 SteppeTime should follow astronomical year logic. Year 0 is a real year. We bless it.

✅ Verdict: Good and necessary heresy.

### Delta T Devil

🧠 Delta T is the difference between:

TT (Terrestrial Time) – smooth ephemeris time

UT (Universal Time) – Earth rotation time

Delta T is non-linear, and grows over time. Currently ~69 seconds (2025), but back in 1000 AD it was ~157 seconds.
Back in 18000 BCE, it’s chaos.

🦴 Problem: This means full-on astrophysical moon phase calculations might diverge from your float epact by ~2–3 days at 18,000 BCE.

Haram af.
