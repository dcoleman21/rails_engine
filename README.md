# Rails Engine
<div style="background: grey;">

This is an E-Commerce Application that communicates via APIs. This application exposes the data that powers the E-Commerce site through an API that will be consumed by our front end team.

## Summary

  - [Getting Started](#getting-started)
  - [Set Up](#set-up)
  - [Runing the tests](#running-the-tests)
  - [Authors](#authors)

## Getting Started

These instructions will get you a copy of the project up and running on
your local machine for development and testing purposes.


### Prerequisites

What things you need to install, the software and how to install them

Create a directory where you want this project to live `mkdir <name goes here>`

cd into that newly created directory.

![](https://img.shields.io/badge/Rails-5.2.4-informational?style=flat&logo=<LOGO_NAME>&logoColor=white&color=2bbc8a) ![](https://img.shields.io/badge/Ruby-2.5.3-orange)

Make sure you have ruby version >=2.5.3 and rails version 5.2.4.3.
```
$ ruby -v # ruby 2.5.3p105 (2018-10-18 revision 65156) [x86_64-darwin19]
$ rails -v # Rails 5.2.4.3
```
If your ruby version is not up to date, you can update it with a ruby version manager like [rvm](https://rvm.io/) or [rbenv](https://github.com/rbenv/rbenv).
```
# when using rbenv
$ rbenv install 2.5.3
# set 2.5.3 as the global version
$ rbenv global 2.5.3
```
```
# when using rvm
$ rvm install 2.5.3
# set 2.5.3 as the global version
$ rvm use 2.5.3
```
If your rails version is not up to date, update to the latest version by running:
```
$ gem update rails
```
### Set Up

From within your project directory follow the below steps:

1. Clone [Rails Driver](https://github.com/turingschool-examples/rails_driver).
  * Run the following commands when you are in the `rails_driver` repository
    - `bundle`
    - `rails db:{create,migrate}`
    - `bundle exec figaro install`
      - This command creates the `config/application.yml`, within this file append `RAILS_ENGINE_DOMAIN: http://localhost:3000`

2. Generate a new project `rails_engine`. Run the following command when you are in the `rails_engine` repository:
  ```
  $ rails new rails_engine --api -T -d
  ```
Below are the gems that we will be using within `rails_engine`:

#### Dependencies

  * [rspec-rails](https://github.com/rspec/rspec-rails)- Testing Framework
  * [factory_bot_rails](https://github.com/thoughtbot/factory_bot_rails)- A fixtures replacement with a more straightforward syntax.
  * [shoulda_matchers](https://github.com/thoughtbot/shoulda-matchers)- Provides RSpec with additional matchers.
  * [faker](https://github.com/faker-ruby/faker)- A library for generating fake data. We’ll use this to generate test data.
  * [SimpleCov](https://github.com/simplecov-ruby/simplecov)- To track test coverage.

Initialize the spec directory (where our tests will reside).
```
$ rails generate rspec:install
```
This adds the following files which are used for configuration:

  * `.rspec`
  * `spec/spec_helper.rb`
  * `spec/rails_helper.rb`

Include the above Gems into your `Gemfile` like this:
```
group :test do
  gem 'capybara'
  gem 'rspec-rails'
  gem 'simplecov'
  gem 'shoulda-matchers'
end

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'pry'
  gem 'factory_bot_rails'
  gem 'faker'
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end
```
In your `spec/rails_helper.rb` file add SimpleCov, FactoryBot and Shoulda-Mathcers: (See below for where to add them)
```
# This file is copied to spec/ when you run 'rails generate rspec:install'
require 'spec_helper'
ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../config/environment', __dir__)
# Prevent database truncation if the environment is production
abort("The Rails environment is running in production mode!") if Rails.env.production?
require 'rspec/rails'
# Add additional requires below this line. Rails is not loaded until this point!

<code> <b>require 'simplecov'</b> </code>
SimpleCov.start

# Requires supporting ruby files with custom matchers and macros, etc, in
# spec/support/ and its subdirectories. Files matching `spec/**/*_spec.rb` are
# run as spec files by default. This means that files in spec/support that end
# in _spec.rb will both be required and run as specs, causing the specs to be
# run twice. It is recommended that you do not name files matching this glob to
# end with _spec.rb. You can configure this pattern with the --pattern
# option on the command line or in ~/.rspec, .rspec or `.rspec-local`.
#
# The following line is provided for convenience purposes. It has the downside
# of increasing the boot-up time by auto-requiring all files in the support
# directory. Alternatively, in the individual `*_spec.rb` files, manually
# require only the support files necessary.
#
# Dir[Rails.root.join('spec', 'support', '**', '*.rb')].sort.each { |f| require f }

# Checks for pending migrations and applies them before tests are run.
# If you are not using ActiveRecord, you can remove these lines.
begin
  ActiveRecord::Migration.maintain_test_schema!
rescue ActiveRecord::PendingMigrationError => e
  puts e.to_s.strip
  exit 1
end
RSpec.configure do |config|

  config.include FactoryBot::Syntax::Methods

  # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  # If you're not using ActiveRecord, or you'd prefer not to run each of your
  # examples within a transaction, remove the following line or assign false
  # instead of true.
  config.use_transactional_fixtures = true

  # You can uncomment this line to turn off ActiveRecord support entirely.
  # config.use_active_record = false

  # RSpec Rails can automatically mix in different behaviours to your tests
  # based on their file location, for example enabling you to call `get` and
  # `post` in specs under `spec/controllers`.
  #
  # You can disable this behaviour by removing the line below, and instead
  # explicitly tag your specs with their type, e.g.:
  #
  #     RSpec.describe UsersController, type: :controller do
  #       # ...
  #     end
  #
  # The different available types are documented in the features, such as in
  # https://relishapp.com/rspec/rspec-rails/docs
  config.infer_spec_type_from_file_location!

  # Filter lines from Rails gems in backtraces.
  config.filter_rails_from_backtrace!
  # arbitrary gems may also be filtered via:
  # config.filter_gems_from_backtrace("gem name")

  Shoulda::Matchers.configure do |config|
    config.integrate do |with|
      with.test_framework :rspec
      with.library :rails
    end
  end
end
```
Intall the gems by running:
```
$ bundle install
$ rails db:create
```
3. We will be importing data from [sales_engine](https://github.com/turingschool-examples/sales_engine/tree/master/data) into the `rails_engine`. To do that:
  - Fork the `sales_engine` repo
  - Clone the `sales_engine` repo into your project directory
  - You will then need to open (in separate atom windows) both `rails_engine` and `sales_engine`
  - In your `rails_engine` create a new dirctory in the `db` directory called `data`.
  - In your `sales_engine` copy/drag the `data` directory into your newly created `data` directory in `rails_engine`.

4. We will need to seed the data into our `seeds.rb` within our `rails_engine` repository. Some things to be aware of:
  - Be sure to use the ID values from the CSV data in your own database.
  - Use ActiveRecord to reset the Primary Key sequences in PostgreSQL afterward.
  - Convert all of your prices from pennies to dollars and pennies before they get put in the database. Otherwise, the spec harness will not work correctly.
  - Make sure you implement a way to destroy the seeded data so that it does not duplicate data.

## Running the tests

![](https://img.shields.io/badge/Spec--Tests-17%20total%2016%20passing%201%20skipped-yellowgreen) ![](https://img.shields.io/badge/Local__Tests-45%20total%2C%200%20failures%2C%201%20pending-green)

You will need to be running the following tabs simultaneously in your terminal:

  1. `rails_engine` - to run your local tests
  2. `rails_driver` - to run your harness spec
  3. `rails_engine - rails s` - to run the local server

You may decide to check out the `harness_spec` in the `rails_driver` to verify what your local tests on `rails_engine` need to test for.
Make sure that your tests pass both the `harness_spec` and your local test.

### Created Tables

   - Customers
   - Invoices
   - Invoice_Items
   - Items
   - Merchants
   - Transactions

### Break down into end to end tests

In this application we exposing data through a multitude of API endpoints. Follow these technical expectations:
  * All endpoints should be fully tested. The Rails Driver Spec Harness is not a substitute for writing your own tests.
  * All endpoints will expect to return JSON data
  * All endpoints should be exposed under an api and version `(v1)` namespace (e.g. `/api/v1/merchants`)
  * API will be compliant to the [JSON API spec](https://jsonapi.org/)
  * Controller actions should be limited to only the standard Rails actions. For endpoints such as `GET /api/v1/merchants/find?parameters` try something like this which adheres to the above approach of only using RESTful actions:
  ```
  module Api
  module V1
    module Merchants
      class SearchController
        def show
        # code omitted
        end
      end
    end
  end
end
```

You will need to expose Restful API endpoints for both `Items` and `Merchants`
  * Index, Show, Create, Update, Destroy

You will need to expose relationship endpoints:
  * `GET /api/v1/merchants/:id/items` - return all items associated with a merchant.
  * `GET /api/v1/items/:id/merchants` - return the merchant associated with an item.

You will also need to build "find" endpoints for both `Items` and `Merchants`.
  * Single Finders - returns a single record that matches a set of criteria (through query parameters)
    - `GET /api/v1/<resource>/find?<attribute>=<value>`
  * Find partial matches for strings and be case insensitive
    - `GET /api/v1/merchants/find?name=ring` - can return 'ball' or 'basketball'

Here is an expmple JSON response:
```
{
  "data": {
    "id": 4,
    "type": "merchant",
    "attributes": {
      "name": "Ring World"
    }
  }
}
```
  * Multi Finders - returns all records that match a set of criteria (through query parameters)
    - `GET /api/v1/<resource>/find_all?<attribute>=<value>`

Here is an example JSON response:
```
{
  "data": [
    {
      "id": "4",
      "type": "merchant",
      "attributes": {
        "name": "Ring World"
      }
    },
    {
      "id": "1",
      "type": "merchant",
      "attributes": {
        "name": "Turing School"
      }
    }
  ]
}
```

And lastly you will want to think about building in some sort of Business Intelligence Endpoints that will utilize ActiveRecord querying.
  * Merchants with Most Revenue - `GET /api/v1/merchants/most_revenue?quantity=x` (x is the number of merchants returned)
    - Exampe JSON response:
    ```
    {
      "data": [
        {
          "id": "1",
          "type": "merchant",
          "attributes": {
            "name": "Turing School"
          }
        },
        {
          "id": "4",
          "type": "merchant",
          "attributes": {
            "name": "Ring World"
          }
        }
      ]
    }
    ```
  * Merchants with Most Items Sold - `GET /api/v1/merchants/most_items?quantity=x` (x is the number of merchants returned)
    - Example JSON response:
    ```
    {
      "data": [
        {
          "id": "1",
          "type": "merchant",
          "attributes": {
            "name": "Turing School"
          }
        },
        {
          "id": "4",
          "type": "merchant",
          "attributes": {
            "name": "Ring World"
          }
        }
      ]
    }
    ```
  * Revenue across Date Range - `GET /api/v1/revenue?start=<start_date>&end=<end_date>` (ex start=2012-03-09&end=2012-03-24)
    - Example JSON response:
    ```
    {
      "data": {
        "id": null,
        "attributes": {
          "revenue"  : 43201227.8000003
        }
      }
    }
    ```
  * Revenue for a Merchant - `GET /api/v1/merchants/:id/revenue`
    - Example JSON response:
    ```
    {
      "data": {
        "id": null,
        "attributes": {
          "revenue"  : 43201227.8000003
        }
      }
    }
    ```

## Authors

  - [Dani Coleman](https://github.com/dcoleman21/rails_engine)
</div>
<br>
