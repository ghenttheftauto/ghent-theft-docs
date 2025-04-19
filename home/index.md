# 🧬 game-of-life docs

> _You better start believing in simulation theories, you're in one!_

### Navigation

- [Codex](codex/) - User guides and tutorials
- [API Reference](api/) - Auto-generated API documentation

- [Articles](articles/) - User guides and tutorials
- [API Reference](api/) - Auto-generated API documentation

This site documents the entire simulation engine, from domain to storytelling.

- 🌐 For design philosophy and guiding principles, see the [Vision Doc](articles/vision.md).

- 🛠️ For ongoing tasks and upcoming features, check the [To-Do List](todos.md).

- 🎨 For UI stuff, go to [UI](ui/index.md)

---

# ✨ Highlights

Welcome to the simulation.

- ### 🧠 Domain-Driven Architecture

  Fully modular simulation engine with dedicated systems for [Education](/api/Domain.Education),[Locations](/api/Domain.Locations), [Profession](/api/Domain.Profession), [Gods](/api/Domain.Gods), [Moments](/api/Domain.Moments), and more.

- ### 🕰️ DateTime-Driven Emergent Behavior

  Each day, the simulation clock ticks — driving events like unpaid [Holiday](/api/Domain.Time.Holiday), school attendance, and the march toward [Death](/api/Domain.Moments.DeathMoment).
  Sacred breaks and civic holidays? We got 'em. From [Easter Sunday to Pinkstermaandag](/api/Domain.Time.Calendar), this temporal core governs academic years, school vacations, and divine feast days alike.
  All the while, the [Clock](/api/Domain.Time.Clock) keeps ticking — orchestrating the emergence of life’s rhythms.

- ### 🌅 Eclestial Easter Calculator

  A totally unhinged, fully halal, and vaguely canonical [Easter calculation](xref:Domain.Gods.Religion) — just as ordained by the Council of Nicaea in 325-whatever.
  For all your sacred scheduling needs, from Ash Wednesday to Corpus Christi.

- ### 🍆 Static Sex Class

  Absolutely cursed. You know what [this](/api/Domain.Gods.Sex) is.
