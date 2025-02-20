# Installation Guide

## Overview
This guide will walk you through the setup process for local development.

## Table of Contents
- [Prerequisites](#prerequisites)
- [Install Dependencies](#install-dependencies)
- [Add Environment Variables](#add-environment-variables)
- [Set Up Database](#set-up-database)
- [Usage](#usage)
- [API Documentation](#api-documentation)
- [Testing](#testing)

## Prerequisites
Ensure the following tools are installed on your system:
- **Ruby:** 3.1.2
- **Bundler:** 2.5.18
- **Rails:** 7.2.2.1
- **PostgreSQL:** 14.5

## Install Dependencies
Clone the repository and install the required dependencies:
```sh
git clone https://github.com/vinhbt241/tiny-url.git
cd tiny-url
bundle install
```

## Add Environment Variables
1. Create an `.env` file.
2. Copy the variables from `.example.env` and adjust them according to your local environment.

## Set Up Database
Create and migrate the database:
```sh
rails db:create
rails db:migrate
```

## Usage
Common commands used in the project
```sh
# Start the server
rails s

# Annotate models with table schema
bundle exec annotate

# Lint the codebase
bundle exec rubocop -A
```

## API Documentation
Start the server and navigate to [http://localhost:3000/api-docs](http://localhost:3000/api-docs) to explore and interact with the API documentation.

## Testing
Run the test suite:
```sh
bundle exec rspec
```

To view the test coverage report, open the `coverage/index.html` file after running the tests.

To regenerate the API documentation from request test suites, use the following command:
```sh
bundle exec rake rswag:specs:swaggerize
```