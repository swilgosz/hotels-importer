# README

This is Hotels importing application.

## Development

Prerequirements

- Ruby 2.7.2
- Postgres server

To setup the environment run:

`bundle`
`rake db:setup`
`rails s`

There are several improvmenets yet to be applied to say this application is ready.


## Usage

Data import is done manually atm. Will be moved to an automatic sidekiq job next.

```
rails c
require 'managing_hotels/importing/import'
ManagingHotels::Importing::Import.call
```

### Listing and filtering hotels

- list all hotels `http://localhost:3000/api/v1/hotels`
- filter by destination `http://localhost:3000/api/v1/hotels?destination_id=5132`
- filter by hotel ids `http://localhost:3000/api/v1/hotels?hotels[]=abc&hotels[]=dce`

## Notes

- Unified all resources to an easy to work-with data structure
- Descriptions are merged in the way the longest one is taken, and the rest rejected.
- Values are stripped from unnecessary whitespaces
- amenities - are transformed into a snake_case string format, just to reduce the number of duplicates and improve clarity.

## Performance optimizations applied

- DB Indexes for destination and external_id filters
- Caching Responses.
- Model optimized for reading.
- Importing data is done asynchronously and saved to DB to avoid unnecessary calculations while reading.

## Todo

- sidekiq integration with job scheduled as a repeatitive rake task.
- deployment configuration
- dockerization for easier running
