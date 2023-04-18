# README

* Ruby version
  - 3.2.0

* Setup
  - install ruby 3.2.0 with whatever version manager you like. I use `rvm`; if it's too much trouble you can change the .ruby-version to whatever binary you have installed.
  - The data store is postgres so you will need to have that installed and running locally
  - In the application directory run `bundle install` to install dependencies
  - Create the database:
    - `bundle exec rails db:create`
    - `bundle exec rails db:migrate`
    - this will create a development and test database
    - You can optionally start the server by running `bundle exec rails s`
    - I have included database seeds for Users, Visits, Transactions and Accounts.  They can optionally be seeded by running `bundle exec rails db:seed`.  This will allow you to do things like curl your local server and examine the json response. E.g `curl localhost:3000/v1/users`

* Tests
  - All specs are located in `spec/requests`.  I chose to write request specs as they test most of the stack as well as http responses, status codes, etc. The models are very simple so I chose to omit tests for them, as Rails has extensive tests for the basic model behavior.  The 'Commands' I have created are tested through the request specs.
  - run the test suite with `bundle exec rspec`

* Assumptions
  - Generally, I've tried to stick to the instructions as much as possible.  I've left the code decoupled and open to modifications to the requirements.  I have a configurable 'discount amount' that can be set with the env var `OVERHEAD_FEE` that defaults to 15%.

  - I have assumed that this is a backend service that sits behind a web app or another service with authentication and authorization, therefore I have not implemented any user auth in this service (as clarified by a follow up question on the assignment).  I started to go down the path of implementing user auth and an endpoint that would act as a token broker to make authenticated requests for visits and so fourth, but abandoned this after asking about the assignment requirements.

  - I thought about the possibility of other roles besides Member and Pal and was initially thinking about `roles` and `user_roles` tables, but decided to keep it simple and go from the stated requirements.

* Design
  - I designed this API using somewhat typical Rails conventions.  I have versioned this under `/v1`.

  - I've chosen postgres for data persistence. I wanted an ACID database as there are important bookkeeping transactions that need to be executed atomically and need to be able to be aborted cleanly. I can see future use cases for things like event streaming and analytics.

  - I've kept the API controllers thin and have used a command pattern for the execution of the application logic behind each API call.

  - In addition to the stated requirements I've added GET endpoints to list users, visits and transactions because I thought this would be useful and make the API easier to use, i.e. adding the ability to list visits so one can grab an ID to pass to a ‘fulfill visit’ call.

  - I used an Account model that belongs to each user.  I thought it could be helpful for things like frontloading credit to a user. I viewed the Transactions a bookkeeping affordance and having an account allows a bit more flexibility and made sense to me as a logical part of the domain.  I can also see a case for a separate bookkeeping service altogether.

  - Most of the interesting code to check out is in `app/models`, `app/controllers`, `lib/commands` and `spec/requests`.  The database schema can be viewed in `db/schema.rb`.

* API documentation
  - I have used code as documentation that can be viewed at `localhost:3000/apipie`
  - <img width="794" alt="image" src="https://user-images.githubusercontent.com/5577425/232812254-d2fb4705-1146-4de2-8485-8a31f7f9a526.png">



