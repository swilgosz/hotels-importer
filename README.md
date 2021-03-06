# README

This is Hotels importing application. Deployed to heroku at: https://hotels-importer.herokuapp.com/api/v1/hotels

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

When you run application locally, just run the import to download all the necessary data.

```
rake hotels:import
```

### Listing and filtering hotels

- list all hotels `http://localhost:3000/api/v1/hotels`
- filter by destination `http://localhost:3000/api/v1/hotels?destination_id=5132`
- filter by hotel ids `http://localhost:3000/api/v1/hotels?hotels[]=abc&hotels[]=dce`

## Notes

- Unified all resources to an easy to work-with data structure
- Added Type check for input schema for Acme and Patagonia - I could not add it to Paperfiles yet, but it'd work the same. This is a validation checks so we are 100% sure that the input data format is as expected so we can safely work with.
- Descriptions are merged in the way the longest one is taken, and the rest rejected.
- Values are stripped from unnecessary whitespaces
- amenities - are transformed into a snake_case string format, just to reduce the number of duplicates and improve clarity.
- Specs - due to the limited time I've focused on covering as much of code with as little examples as possible. Therefore I've written integration tests (requests tests) and Transformation tests, for the moment assuming API returns proper data.

**Response format changes**

- country - I decided to return 2-letter country identifier from Acme for easier parsing by frontend clients.
- amenities and images - I've decided to ungroup those two due to the fact it feels natural there can be more groups in other records or providers, or the groups can be named differently.
- Both changes are trivial to change if needed.

## Performance optimizations applied

- DB Indexes for destination and external_id filters
- Caching Responses.
- Model optimized for reading.
- Importing data is done asynchronously and saved to DB to avoid unnecessary calculations while reading.

## Best practices

- Write-part of the application is separated from the read-part. This allows for easy changes without affecting other part and allows to optimize DB records for reads.
- Each transformations are kept as standalone, encapsulated classes, which allow them for easy test coverage, easy removal or adding new providers.

## Todo

- Tests for the importer itself - merging data, saving records.
