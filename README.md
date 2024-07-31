# Buildings API

## Overview
This is an API-only Rails 7 application with a PostgreSQL database.

## Prerequisites
Ensure you have the following installed on your local machine:
- Ruby (version 3.3.4)
- Rails (version 7.1.3.4)
- PostgreSQL (version 14 or higher)

## Setup Instructions

### 1. Clone the Repository
```bash
git clone https://github.com/cblokker/client_provider_network.git
cd client_provider_network
```

### 2. Install Ruby Dependencies
Ensure you are using the correct Ruby version. You can use tools like [rbenv](https://github.com/rbenv/rbenv) or [rvm](https://rvm.io/) to manage Ruby versions: 

```bash
rbenv install 3.1.0
rbenv local 3.1.0
```

Bundle install:

```bash
gem install bundler
bundle install
```

### 4. Set Up PostgreSQL
#### 4.1 Create PostgreSQL Role
First, ensure PostgreSQL is running. Then create a new role and database:

Login in postgres console:

```bash
$> sudo -u postgres psql
```

create user with name rails and password:

```bash
=# create user client_provider_network with password 'password';
```

make user rails superuser:

```bash
=# alter role client_provider_network superuser createrole createdb replication;
```

in database.yml, make sure things match:
```yml
development:
  username: client_provider_network
  password: password
```

You may need to do the same for the test db.

#### 4.2 Create, migrate, & seed Database

```bash
rails db:create
rails db:migrate
rails db:seed
```

### 5. Run tests

I decided to place the queries in a rake file, so you can observe behavior:
```bash
rake query:run
```

Note that no tests were written (intentionally, and for the same of time).

```bash
bundle exec rspec
```

