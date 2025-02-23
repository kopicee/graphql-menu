Setup repo
- I have a new laptop and it's a while since I set up rails from scratch, let's do everything by hand
- `rails new app`

Setup deployment
- I recently started using fly.io at work and it's a breeze to provision and operate
- Let's use that too
  - Signup fly.io
  - `fly launch`
  - oof `gem i pg -- --with-pg-config=$HOME/.asdf/installs/postgres/17.4/bin/pg_config`
- `db:prepare` `rails s` - ok
- Push. Fix CI token. it's alive

Prepare to write code
- I use rspec at work, let's go with that `gem i; rails generate rspec:install`
- Setup ruby extension on vscode (thx shopify)
- .rubocop.yml
- wait, how does graphql work to query postgres?
  - thx digitalocean - https://www.digitalocean.com/community/tutorials/how-to-set-up-a-ruby-on-rails-graphql-api
- instead of doing all tables in one shot, let's fiddle with menu first
  - `rails g model menu label:string state:string start_date:date end_date:date`
  - does gql have date type?
    - https://stackoverflow.com/questions/47960194/graphql-ruby-date-or-datetime-type
    - https://github.com/rmosolgo/graphql-ruby/pull/2471/files
- working with grapql -- https://graphql-ruby.org/getting_started
  - generate a type - `rails g graphql:object Menu id:ID! state:String! label:String start_date:ISO8601Date end_date:ISO8601Date`
  - setup field in QueryType `field :menu, resolver: Resolvers::MenuResolver`
  - setup resolver to `::Menu.find(id)`
  - time to try. http://localhost:8080/graphiql
  - looks like the type generator outputs `Types::ISO8601DateType` instead of `GraphQL::Types::ISO8601DateTime`, annoying!
  - oh, looks like there were a bunch of duplicate fields. maybe I just need to pass the model name and nothing else, will try that later
  - let's seed with chatgpt.com
    ```
    given this rails schema
        create_table "menus", force: :cascade do |t| ...
    generate a rails seed with 10 menus and plausible data
    ```
  - finally this works:
    ```
    {
      menu(state:ACTIVE) {
        id
        label
        state
        startDate
        endDate
      }
    }
    ```
