# SfFoodTrucks

This app will let you rate a food truck in the San Francisco area (this data is pulled from [DataSF : Mobile Food Facility Permit](https://data.sfgov.org/Economy-and-Community/Mobile-Food-Facility-Permit/rqzj-sfat/data)).
It is a demo Phoenix Elixir app to show a few concepts:
- Pattern Matching
- use of `with` statement for happy path
- New Phoenix `liveview` templates

## This app uses
- Phoenix 1.7
- Elixir 1.14.5 (see .tool-versions)
- Erlang 26.0.1 (see .tool-versions)
- PostgreSQL
- ASDF to manage installed versions of Elixir

## How to run this app
- Make sure that you have installed or have access to a PostgreSQL server
- Change your `config/dev.exs` to point to that server
- Run the following in the project directory
```
mix deps.get
mix ecto.setup
mix phx.server
```
      
## Testing
- update `confign/text.exs` to point to your test database
- `mix test`