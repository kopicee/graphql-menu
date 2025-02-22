# grain-graphql-menu

For https://atlaskitchen.notion.site/Grain-Technical-Interview-Part-1-4cc4a4ca8c1f4e7697782c0e8b275218

This is a Rails app deployed on Fly.io -- see https://grain-graphql-menu.fly.dev/

## Development

```shell
# Install dependencies
bundle i

# Start app locally
cp .env.example .env
bundle exec rake db:prepare
bin/rails serve

# Run all tests, or just a specific file
bundle exec rspec
bundle exec rspec spec/foo_spec.rb

# Open interactive app console
bin/rails console
```

## Deployment

The application is deployed using Fly.io and GitHub actions. The deployment runs whenever there's a git push to the `main` branch.

You can access the deployment at https://grain-graphql-menu.fly.dev/
