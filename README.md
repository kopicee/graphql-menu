# grain-graphql-menu

For https://atlaskitchen.notion.site/Grain-Technical-Interview-Part-1-4cc4a4ca8c1f4e7697782c0e8b275218

This is a Rails app deployed on Fly.io -- see https://grain-graphql-menu.fly.dev/

## Development

```shell
# Setup app locally
bin/setup

# Start app locally. This installs the Foreman and Rerun gems for code reloading.
bin/dev
# Alternatively, just start the server.
bin/rails server

# Run all tests, or just a specific file
bundle exec rspec
bundle exec rspec spec/foo_spec.rb

# Open interactive app console
bin/rails console
```

## Deployment

The application is deployed using Fly.io and GitHub actions. The deployment runs whenever there's a git push to the `main` branch.

You can access the deployment at https://grain-graphql-menu.fly.dev/

## Interacting with the API

There is an interactive GUI:

- https://grain-graphql-menu.fly.dev/graphiql
- http://localhost:8080/graphiql


Alternatively, use the command line:
```shell
# Call the deployed app.
# Notice that the whole query sits in one line, since CRLF is not supported by the query parser.
curl 'https://grain-graphql-menu.fly.dev/graphql' -X POST \
-H 'Content-Type: application/json' \
-d '{
  "query":"  { menu(state:null){ id } }  "
}'

# Call the local app.
curl 'http://localhost:8080/graphql' -X POST \
-H 'Content-Type: application/json' \
-d '{
  "query":"  { menu(state:null){ id } }  "
}'
```

GraphQL query to fetch all exposed fields:
```
{
  menu(state:null) {
    id
    label
    state
    startDate
    endDate
    createdAt
    updatedAt
    menuSections {
      displayOrder
      label
      description
      items {
        label
        description
        kind
        price
        modifierGroups {
          label
          selectionRequiredMin
          selectionRequiredMax
          modifiers {
            displayOrder
            label
            description
            kind
            priceOverride
            defaultQuantity
          }
        }
      }
    }
  }
}
```

In one-line curl, with [jq](https://jqlang.org/) for readability:
```shell
curl 'https://grain-graphql-menu.fly.dev/graphql' -X POST \
-H 'Content-Type: application/json' \
-d '{
  "query":"  { menu(state:null) { id label state startDate endDate createdAt updatedAt menuSections { displayOrder label description items { label description kind price modifierGroups { label selectionRequiredMin selectionRequiredMax modifiers { displayOrder label description kind priceOverride defaultQuantity } } } } } }  "
}' | jq
```
