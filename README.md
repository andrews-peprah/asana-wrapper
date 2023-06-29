# Setup

1. To setup the project you would need these installed

- Ruby - v 3.2.0 and above
- Bundler

2. Change directory into project directory `cd ~/asana_wrapper`
3. Run bundler to install necessary gems `bundle install`
4. Generate an access token from Asana and set your asana personal access token in the environment `export ASANA_PERSONAL_ACCESS_TOKEN=token`
5. Run main to see the project in action `ruby main.rb`

# Running tests

Rspec is used in running the tests. Below is the command for testing:\
`rspec spec/asana/client.rb`
