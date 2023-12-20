# Question Vault

Question Vault is an intuitive software platform designed to empower users in curating and organizing a personalized collection of technical interview questions, enabling seamless practice and preparation for software engineering assessments.

## Features

- Manage list of question groups
- Manage list of questions
- Import list of questions and groups from Notion and soon Google Docs and One Drive
- Create multiple integrations to different Notion and Google Docs accounts
- Auto daily data synchronization with external service integrations

## Tech

Technologies, libraries, gems and other tools used for this development:

- Ruby On Rails: Full stack web framework
- Resque: Library for creating background jobs
- Redis: In-memory data structure store, used as a database
- PostgreSQL: Free and open-source relational database management system
- Javascript: Programming language and core technology of the World Wide Web
- Notion SDK: Ruby Notion SDK that helps to connect the API using a wrapper
- Active Record Import: Library for bulk inserting data using ActiveRecord
- Brakeman - Free vulnerability scanner specifically designed for Ruby on Rails applications
- RSpec - Testing tool for Ruby, created for behavior-driven development

## Installation

Question Vault requires [Ruby](https://www.ruby-lang.org/) v3.0.0+ to run
Install the dependencies and and start the server

```sh
cd question_vault
bundle install
rails s
bundle exec sidekiq # run this in other terminal
```
## Run tests

This application uses RSpec as testing library, first you need to setup the test database in the `config/database.yml` file, then run the following command in terminal:

```sh
cd question_vault
bundle exec rspec
```
## Third party integrations

Question Vault is currently extended with the following integrations

| Plugin | State |
| ------ | ------ |
| Notion | Complete |
| Google Docs | Pending |
| One Drive | Pending |

## System design diagram
[Go to file](system_diagram.png)

## Entity relationship diagram
[Go to file](entity_relationship_diagram.pdf)

## License
MIT
