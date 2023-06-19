# Notes for [Coding Challenge]() 
## Upfront Questions
- There is an API to get a list of food trucks
- Can I get the location for just one food truck? Or do I have to get the whole list every time I want to get their current location?
- Is there a "food style"/description? That way I could pull that into a drop-down of some kind for inclusion/exclusion
- Do I need to use the API or can I use the provided CSV file? Or should I start with JSON file I can download from DataSF?
- Should we store the data from DataSF in ETS or PostgreSQL?

## Initial Ideation For Challenge
Since this was for interesting ideas on what to do with Food Truck data I wanted to think of some different things other 
than "track my favorite food truck" or something similar. Here were three ideas I came up with that could fit within the 2 - 3 hour dev time frame.
1. Food Truck Crawl
   2. I remember hearing about an unconference that was held in SF that bounced from food truck to food truck. I thought this might be a fun one to try.
3. Something like [Where The F*** Should I Go To Eat](https://wtfsigte.com/) but for nearby food trucks
4. Food Truck rating app

Ultimately I went with the last one because I wasn't sure if I could get the location stuff figured out within the timeframe. And I wasn't sure if DataSF would allow me to query on an individual Food Truck or not to get it's current location.

## Risks
- Not 100% sure how to start with querying the data from DataSF and sometimes that can be tricky
  - Mitigation: start with just downloading the JSON data and work with that to begin with, if time allows then move on to a full request and parse of data
- Do we worry about auth or user creation?
  - Mitigation: start with `phx.gen.auth` and see if it works out of the box, if not go simpler

## Dev Journal
- Setup basic app
- Ran `mix phx.gen.auth`
- Tried to create a new user and got an error rendering the register page (along with all the other generated auth pages)
  - `key :name not found in: %{label: "Email", type: "email", prompt: nil, field: %Phoenix.HTML.FormField{id: "user_email", name: "user[email]"`
- Ultimately had to fix all of the generated auth pages
  - From `{@form[:email]}`
  - To `{{@form, :email}}`
  - The latter worked in one of my other apps that I had generated the auth for so I just copied and pasted, haven't had a chance to investigate why this worked yet
- Ran `mix phx.gen.schema FoodTruck food_trucks` to create the Food Truck schema that will store the fields I want from DataSF
- Updated schema and migration for table
- Figure out how to parse and make the json into a seed data packet
  - Got all the data inserted after some messing around with missing fields (like `fooditems` and `dayshours`) and converting `status` to its `Ecto.Enum` equivalents
- Now to make the rating stuff
- First we need a basic view for all the food trucks - generated using `mix phx.gen.live FoodTrucks FoodTruck food_trucks`
  - Added in columns we want to show
- Now we need a new schema for rating a food truck
  - `mix phx.gen.schema FoodTruckRating food_truck_ratings`