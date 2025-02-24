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

## Notes

I've never worked with GraphQL before so this took a bit of time to figure out. Also, my day-to-day framework is [Hanami](https://hanamirb.org/), so my Rails setup might look a bit weird.

As per "Please provide detailed explanations of your thought process and approach when facing a problem" -- I've jotted down my notes in [stream-of-consciousness.md](./docs/stream-of-consciousness.md) which is not really how I usually operate, so it's a bit messy.

Overall there were a few small decisions to be made:
- Setting stuff up from scratch on a (relatively new) laptop, e.g. asdf-postgres, as opposed to using a template repo
- Wiring up a single model on the GraphQL before setting up any relations
- Working around minor issues if it feels tricky to fix
  - Example: how do I change the schema from `menu.menuSections` to `menu.sections`?
      - This fails with `Types::MenuSectionType#display_order, which did not exist` but it does exist.
      - I think I have to tweak the resolver so Types::MenuSectionType is explicitly linked to the MenuSection model
      - But [the docs](https://graphql-ruby.org/fields/resolvers.html) mention "do you really need a resolver?" which gave me enough pause to simply decide on renaming this field
  - Another example: Rails complains if I use `type` as a column name in the Item model. I'm 100% sure there's a real workaround (I think something like `inheritance_column = nil`) but it looks cumbersome. I decided to rename to `kind` to avoid fighting the framework.
  - Example: linter suggestions to use `plugins` instead of `requires` -- I don't know why the installed gem [differs from the github source](https://github.com/rails/rubocop-rails-omakase/blob/main/rubocop.yml), which does use `plugins`
  - My tests are almost nonexistent because most of the legwork is already done by the graphql gem. All I did was cover the controller lightly to avoid 'testing the framework'
