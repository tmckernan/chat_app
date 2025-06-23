# Project real time chat app Challenge

## System dependencies
* [Ruby 3.4.4]
* [Rails 8.0.2]
* [Turbo && Stimulus]
* [Rubocop] - Ruby static code analyzer
* [RSpec && Capybara] - Rspec tests && Capybara feature tests.

## Features
1. user signup/authentication using devise gem
2. User can create chatrooms
3. user can join and leave a chatroom
4. Several user can join a chatroom
5. User can send text messages in real time
6. All message are persisted in a database

## Installation

1. Clone the repository:
```bash
git clone [git@github.com:tmckernan/chat_app.git]
cd chat_app
```

2. Install dependencies:
```bash
bundle install
```

3. Create database:
```bash
rails db:create db:migrate db:seed
```

## Run the application:
```bash
bin/dev
```
Application will be running on http://localhost:3000


### Tests && code coverage

```sh
cd chat_app
bundle exec rspec
```
