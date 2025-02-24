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

<details><summary>Click to show a sample response</summary>

```json
{
  "data": {
    "menu": [
      {
        "id": "13",
        "label": "Pizza Menu",
        "state": "active",
        "startDate": "2025-02-23",
        "endDate": "2025-03-25",
        "createdAt": "2025-02-23T19:06:14Z",
        "updatedAt": "2025-02-23T19:06:14Z",
        "menuSections": [
          {
            "displayOrder": 1,
            "label": "Classic Pizzas",
            "description": "A delightful selection of our handmade pizzas",
            "items": [
              {
                "label": "Margherita Pizza",
                "description": "Margherita pizza with fresh basil, a timeless classic.",
                "kind": "product",
                "price": 10.99,
                "modifierGroups": [
                  {
                    "label": "Extra toppings?",
                    "selectionRequiredMin": 0,
                    "selectionRequiredMax": 3,
                    "modifiers": [
                      {
                        "displayOrder": 1,
                        "label": "Extra Cheese",
                        "description": "Can't go wrong with more cheese!",
                        "kind": "component",
                        "priceOverride": 1.5,
                        "defaultQuantity": 0
                      },
                      {
                        "displayOrder": 2,
                        "label": "Mala sauce",
                        "description": "We won't judge!",
                        "kind": "component",
                        "priceOverride": 2.5,
                        "defaultQuantity": 0
                      }
                    ]
                  },
                  {
                    "label": "Select size",
                    "selectionRequiredMin": 1,
                    "selectionRequiredMax": 1,
                    "modifiers": [
                      {
                        "displayOrder": 1,
                        "label": "Solo",
                        "description": "9-inch pizza, just for you.",
                        "kind": "component",
                        "priceOverride": 0,
                        "defaultQuantity": 0
                      },
                      {
                        "displayOrder": 2,
                        "label": "Mega",
                        "description": "11-inch pizza, perfect for a pair.",
                        "kind": "component",
                        "priceOverride": 0,
                        "defaultQuantity": 0
                      },
                      {
                        "displayOrder": 3,
                        "label": "Giga",
                        "description": "13-inch pizza, for a family of four.",
                        "kind": "component",
                        "priceOverride": 0,
                        "defaultQuantity": 0
                      }
                    ]
                  }
                ]
              },
              {
                "label": "Currywurst Pizza",
                "description": "Confuse your German, Indian and Italian friends!",
                "kind": "product",
                "price": 14.99,
                "modifierGroups": [
                  {
                    "label": "Extra toppings?",
                    "selectionRequiredMin": 0,
                    "selectionRequiredMax": 3,
                    "modifiers": [
                      {
                        "displayOrder": 1,
                        "label": "Extra Cheese",
                        "description": "Can't go wrong with more cheese!",
                        "kind": "component",
                        "priceOverride": 1.5,
                        "defaultQuantity": 0
                      },
                      {
                        "displayOrder": 2,
                        "label": "Mala sauce",
                        "description": "We won't judge!",
                        "kind": "component",
                        "priceOverride": 2.5,
                        "defaultQuantity": 0
                      }
                    ]
                  },
                  {
                    "label": "Select size",
                    "selectionRequiredMin": 1,
                    "selectionRequiredMax": 1,
                    "modifiers": [
                      {
                        "displayOrder": 1,
                        "label": "Solo",
                        "description": "9-inch pizza, just for you.",
                        "kind": "component",
                        "priceOverride": 0,
                        "defaultQuantity": 0
                      },
                      {
                        "displayOrder": 2,
                        "label": "Mega",
                        "description": "11-inch pizza, perfect for a pair.",
                        "kind": "component",
                        "priceOverride": 0,
                        "defaultQuantity": 0
                      },
                      {
                        "displayOrder": 3,
                        "label": "Giga",
                        "description": "13-inch pizza, for a family of four.",
                        "kind": "component",
                        "priceOverride": 0,
                        "defaultQuantity": 0
                      }
                    ]
                  }
                ]
              }
            ]
          },
          {
            "displayOrder": 2,
            "label": "Drinks",
            "description": "To wash down the grease!",
            "items": [
              {
                "label": "Soft drink",
                "description": "Just grab a can from our chiller!",
                "kind": "product",
                "price": 3.5,
                "modifierGroups": []
              },
              {
                "label": "Lemonade",
                "description": "Home-brewed lemonade. Hits the spot!",
                "kind": "product",
                "price": 8,
                "modifierGroups": []
              },
              {
                "label": "Cherryade",
                "description": "Like lemonade, but uses cherry.",
                "kind": "product",
                "price": 8,
                "modifierGroups": []
              },
              {
                "label": "Marine Parade",
                "description": "Ask us about our East Coast plans!",
                "kind": "product",
                "price": 8,
                "modifierGroups": []
              },
              {
                "label": "Esplanade",
                "description": "I'm not going to explain this one.",
                "kind": "product",
                "price": 8,
                "modifierGroups": []
              }
            ]
          }
        ]
      }
    ]
  }
}
```


</details>

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
