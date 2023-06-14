# README

## prerequisites

  I use these tools for development:
  - rbenv 1.2.0-58-g8644fb5 (includes a ruby-build plugin)
  - Docker version 23.0.3, build 3e7cbfdee1
  - yarn 1.22.19
  - node v20.2.0
  - ruby 3.2.1
  - Bundler version 2.4.13
  - ngrok 3.3.1

  in addition ensure that you have the library headers for Postgresql installed and avalible for ruby-build

  if all of these are installed then the following commands should get your enviroment set up:

## install

  ```
  docker compose up -d
  bundle install
  yarn

  bundle exec rails db:create
  bundle exec rails db:migrate
  ```

## running locally

  launch ngrok pointing back to http localhost:5100 (or your choice of port) and then edit the callback_url in `config/load_balancer.yml`
  
  then you can run the server with:
  ```
  bundle exec foreman start -f Procfile.dev
  ```

  the core api endpoint will be at `http://localhost:5100/api/message` (or at a custom port if you configured that)
  you can post a json object with your phone number and message like this
  ```
  {
    to_number: "1112223333",
    message: "test"
  }
  ```
  and it will return the id like so
  ```
  {
    id: "e07bb661-4d5a-4cfd-b7ab-18178ab672ba"
  }
  ```

  get on `http://localhost:5100/api/message` will return a list of all messages sent
  and `http://localhost:5100/api/message/:id` will return that message

  if you want to try some more interactive experiences, load the node repl and import the local client package at `packages/parentsquare-interview-texting-api`
  or visit `http://localhost:5100` to use a UI frontend to send and look into messages