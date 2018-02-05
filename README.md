

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
user.password = "Ready2go"
user.password_confirmation = "Ready2go"
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

```json
{
	"auth": {
		"email": "jp@rails.com",
		"password": "Ready2go"
	}
}
```

Response:

```json
{
    "jwt": "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJleHAiOjE1MTc4MDEyNTcsInN1YiI6MX0.TnkIt3jzPYWxMSF2-DFjXfpLUVlcdt8LFmFe_fIIL0c"
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
