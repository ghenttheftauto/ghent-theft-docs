# Family Doctor

Origin:
[Open Data Gent](https://www.notion.so/Open-Data-Gent-64cb9944aeb44eebba264cbc2f2dac8d?pvs=21)

## JSON

**JSON schema:**

```json
{
 "FID":"Huisartsen.1",
 "NAAM":"Dr. Hans Taragola",
 "HUISNR":"114",
 "TYPE":"Duo",
 "STRAAT":"Gontrode Heirweg",
 "GEMEENTE":"Melle",
 "POSTCODE":"9090",
 "EMAIL":"",
 "TELEFOON":"09/252.23.84",
 "WEBSITE":"",
 "GESLACHT":"M",
 "OPENOP":"",
 "FICHE":"",
 "DRUPAL_ID":"4837",
 "GlobalID":"fd619ecb-530e-4ede-8edf-6fddaeb6ea3b",
 "SHAPE":"POINT (421743.24240000173 6620832.234200001)"},
}
```

## **Parsing logic**

- `"NAME"` value decides the `GameObject` name.
- `"GESLACHT"` value decides wether the `GameObject` `Sprite` is 👩‍⚕️ or 👨‍⚕️.
- `"SHAPE"` value is converted to GameCoordinates to place the `GameObject`
  using its `Transform.position`
- `"WEBSITE"` value, when it isn't null, a
  [](https://www.notion.so/99d03d95fa5a442aabd1faa5bd1a97fd?pvs=21) is added to
  the `GameObject`.
- When `HUISNR`, `STRAAT`, `GEMEENTE`, `POSTCODE` aren't null, an
  [](https://www.notion.so/b4be45fe1cee470c827cd98b7529deed?pvs=21) is added to
  the `GameObject`.

Doctors have a revive component
