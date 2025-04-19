# Vision Doc

This project is a reinterpretation of Game of Life by Conway.

## Hardcore Conway

Essentially a hardcore semantic domain-driven simulation engine that models the
entire lifecycle of a population of [Human](xref:Humans.Human) in a synthetic
world and is able to talk about what transpired from as many angles as possible
in a very very `Human` way.

It’s not just Conway’s Game of Life with cells—this is way more narrative and
detailed. Every human has a birthdate, experiences key life events (birth,
birthdays, schooling, graduation/exams, work, relationships, and death), and
these events get recorded as “moments” that fuel a rich, dynamic story of the
simulated world.

It’s not just that people are born and die. It’s that:

> “Opa Jan stierf in de lente van 1986. Hij werkte nog in de bakkerij van
> Gentbrugge. Zijn dochter, mijn mama, werd zwanger met mij net na zijn
> begrafenis.”

Where Conway has "under/overpopulation" death, we have death based on
MortalityTuples, FertileAge, and Reaper rolls.

Where Conway has static grids, we have semantic geography (e.g.,
Middelbaarstraat, neighborhoods).

Where Conway had no past, we log everything, canonize it, and tell it back from
each perspective.

Each human is created with a specific birthdate (and potentially a death date,
determined by [Reaper](xref:Gods.Reaper) logic). Their lifecycle is driven by
age thresholds—for example, when they hit their birthday, they age; when they
hit school age, they transition from child to student; eventually, they
graduate, work, retire, and ultimately die.

Every major event is recorded as a Moment:
[`BirthMoment`](xref:Domain.Moments.BirthMoment),
[`BirthdayMoment`](xref:Domain.Moments.BirthdayMoment),
[`SchoolFirstDayMoment`](xref:Domain.Moments.SchoolFirstDayMoment),
(xref:Domain.Moments.SchoolFirstDayMoment),
[`SchoolGraduationMoment`](xref:Domain.Moments.SchoolGraduationMoment),
[`WorkRetirementMoment`](xref:Domain.Moments.WorkRetirementMoment),
[`DeathMoment`](xref:Domain.Moments.DeathMoment), etc.

These events are not just numerical; they’re richly narrated - using the
[Sprookjes](xref:Sprookjes) layer to [Vertel](xref:Sprookjes.Vertel) - with
emojis and a distinct Dutch style of storytelling. This narrative aspect
transforms raw simulation data into story-like outputs.

The simulation is driven by a [Clock](xref:Time.Clock) that ticks on a daily
basis, managing the passage of time. The Clock fires events for things like New
Year’s Eve, the first day of school, school breaks, and holidays, which trigger
corresponding changes in the simulation.

The clock recalculates academic years and holidays every year, affecting how and
when events such as the first day of school or end-of-school events occur.

The `Simulation` class maintains a list of Human instances. It uses the clock
and a daily “tick” to evaluate each human’s state (e.g., are they due for a
birthday? Should they die? Do they need to be “born” if their birthdate has
arrived?)

In flows like `SinglePopulationFlow` or `MultiplePopulationFlow`, the simulation
runs in a loop where each day is processed. During each tick, events are
evaluated (birthdays, graduation events, etc.), moments are recorded, and then
the clock progresses. The simulation stops when no humans are alive, or it hits
a configured cap (to avoid infinite loops).

## Sprookjes

The `Sprookjes` layer bridges the gap between the raw simulation data (moments,
events, lifecycle changes) and a human-friendly narrative. It takes these
`Moments` and “translates” them into stories (in Dutch, with a healthy dose of
emojis) that describe what happened. For example, it can say, “Ik werd 25 jaar
oud op 2016” for a birthday, or “Ik studeerde af van Lageschool in 2002 op mijn
11-jarige leeftijd” for graduation.

Your narrator (or storyteller) functions can dynamically switch between
first-person when describing one’s own life events or third-person (world view)
to describe what happened to others or globally.

The [Simulation](xref:Life.Simulation) is controlled via flow controllers (like
SinglePopulationFlow, MultiplePopulationFlow, MainFlow, etc.) which dictate the
progression of the simulation and how information is presented.

The various [UI systems](/ui) (using Colorify for styling) and custom views
allow you to interact with the simulation—configuring the number of simulated
people, starting the simulation, and later presenting the compiled narrative of
historical moments.

You have clear separation between the simulation engine (domain logic), the
narrative (Sprookjes/Vertel static class), and the user interaction (flow
controllers and views). This modular design means you can extend or refactor
each layer without breaking the others.

## Technical and Poetic

The combination of hard simulation rules (like age calculation via
StaticLife.CalculateAgeAt) with poetic storytelling (using emojis, Dutch
phrasing, and creative narrative functions) makes the project both a technical
challenge and an artistic expression.

It’s like creating a mini-universe where every human life is a story waiting to
be told—and you’re both the programmer and the narrator.
