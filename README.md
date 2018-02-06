# Getting Started

```
$ git clone https://github.com/jeanpaulsio/foos-api.git
$ cd foos-api
$ bundle install
$ rails db:setup
$ rails db:seed
$ rails server
```

# API Docs

## User

`POST /api/v1/user_token`

*Authentication is done with JWTs. Simply send an `email` and `password` and a JWT will be returned*

Body

```
{ 
  "auth": {
    "email": "jp@rails.com",
    "password": "password"
  }
}
```

Response

```
{
  "jwt": "eyJ0e....."
}
```

---

`POST /api/v1/users`

*Registers a new user*

Body

```
{
  "user": {
    "handle": "jerry",
    "email": "jerry@rails.com",
    "password": "password",
    "password_confirmation": "password"
  }
}
```

Response

```
{
    "id": 3,
    "handle": "jerry",
    "email": "jerry@rails.com"
}
```

---

`GET /api/v1/users`

Headers

```
{
  headers: {
    Accept: "application/json",
    "Content-Type": "application/json",
    Authorization: "Bearer " + JWT_TOKEN
  }
}
```

Response

```
[
  {
      "id": 1,
      "handle": "jp",
      "email": "jp@rails.com"
  },
  {
      "id": 2,
      "handle": "kramer",
      "email": "kramer@rails.com"
  }
]
```

---

# Teams


---


## Steps to Victory

__Get Started__

```bash
$ rails new foos-api --api --database=postgresql
$ cd foos-api
$ rails db:create
```

* because we are using a postgres datagbase, we are going to `rails db:create` to initialize a dev and test database

__Creating basic users__

```
$ rails g model User email handle password_digest
$ rails db:migrate

```

* make sure that the `bcrypt` gem is added to the `Gemfile`
* add `has_secure_password` to the `User` model
* maybe put in some validations to make sure a user registers with a `handle`

```ruby
# seeds.rb

user = User.new
user.email= "jp@rails.com"
user.handle = "jp"
user.password = "password"
user.password_confirmation = "password"
user.save
```

__Adding Authentication with Knock + JWT__

* add `Knock` to gemfile

```ruby
gem 'knock', '~> 2.1', '>= 2.1.1'
```

```bash
$ rails g knock:install
$ rails g knock:token_controller user
```

__Time to fix up our routes__

* Generating the knock token controller gives us a route
* now would be a good time to do some namespacing and scoping


```ruby
# config/routes.rb

Rails.application.routes.draw do
  scope :api do
    namespace :v1 do
      post 'user_token' => 'user_token#create'
    end
  end
end
```


* since we're doing some namespacing, we're going to want to make sure that we correctly namespace our controllers

```
class V1::UserTokenController < Knock::AuthTokenController
end
```

* notice the `V1` prepended to the controller!
* now, we can pretty much make `POST` calls to the api at `api/v1/user_token` and return back a JWT

Body:

```
{
  "auth": {
    "email": "jp@rails.com",
    "password": "password"
  }
}
```

Response:

```
{
  "jwt": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMjM0NTY3ODkwIiwibmFtZSI6IkpvaG4gRG9lIiwiYWRtaW4iOnRydWV9.TJVA95OrM7E2cBab30RMHrHDcEfxjoYZgeFONFh7HgQ"
}
```

## Getting a Resource

* let's work on getting a list of users.
* i.e. `GET api/v1/users` should return an index of users
* first, we're going to need to be able to serialize our output

```
# Gemfile

gem 'active_model_serializers', '~> 0.10.7'
```

```
$ rails g serializer user
```

```
# app/serializers/user_serializer.rb

class UserSerializer < ActiveModel::Serializer
  attributes :id, :handle, :email
end
```

* then, we can create an `index` action on our `UsersController`
* we can also make it so that the `UsersController` is protected

```ruby
class V1::UsersController < ApplicationController
  before_action :authenticate_user

  def index
    render json: User.all
  end
end
```

* in order for us to use `before_action :authenticate_user`, we need to make sure that our `ApplicationController` has this line:

```
include Knock::Authenticable
```
