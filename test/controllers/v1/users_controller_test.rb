module V1
  class UserTokenController < ActionDispatch::IntegrationTest
    def authenticated
      @jerry         = users(:jerry)
      @token         = Knock::AuthToken.new(payload: { sub: @jerry.id }).token
      @invalid_token = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9'
    end

    test 'GET /api/v1/users' do
      authenticated
      get v1_users_path, headers: { Authorization: "Bearer #{@token}" }
      assert_response :success
      assert_equal 'application/json', @response.content_type
    end

    test 'POST /api/v1/users' do
      user_params = {
        user: {
          handle: 'costanza',
          email: 'costanza@rails.com',
          password: 'foobar',
          password_confirmation: 'foobar'
        }
      }

      assert_difference 'User.count', 1 do
        post v1_users_path, params: user_params
      end

      assert_response :created
    end

    test 'POST /api/v1/users should fail when passwords do not match' do
      user_params = {
        user: {
          handle: 'costanza',
          email: 'george@rails.com',
          password: 'foobar',
          password_confirmation: 'password'
        }
      }

      assert_no_difference 'User.count' do
        post v1_users_path, params: user_params
      end

      assert_match(/doesn't match Password/, @response.body)
      assert_response :unprocessable_entity
    end

    test 'POST /api/v1/users should fail when email is taken' do
      user_params = {
        user: {
          handle: 'costanza',
          email: 'jerry@rails.com',
          password: 'foobar',
          password_confirmation: 'foobar'
        }
      }

      assert_no_difference 'User.count' do
        post v1_users_path, params: user_params
      end

      assert_match(/has already been taken/, @response.body)
      assert_response :unprocessable_entity
    end

    test 'POST /api/v1/users should fail when handle is blank' do
      user_params = {
        user: {
          handle: '',
          email: 'george@rails.com',
          password: 'foobar',
          password_confirmation: 'foobar'
        }
      }

      assert_no_difference 'User.count' do
        post v1_users_path, params: user_params
      end

      assert_match(/can't be blank/, @response.body)
      assert_response :unprocessable_entity
    end

    test 'PATCH /api/v1/users/:id updates single field' do
      authenticated
      new_handle = 'jerry'
      patch v1_user_path(@jerry), params: { user: { handle: new_handle } },
                                  headers: { Authorization: "Bearer #{@token}" }
      @jerry.reload

      assert_equal new_handle, @jerry.handle
    end

    test 'PATCH /api/v1/users/:id updates multiple fields' do
      authenticated
      new_handle = 'jerry2'
      new_email = 'jerry2@rails.com'
      patch v1_user_path(@jerry), params: { user: { handle: new_handle, email: new_email } },
                                  headers: { Authorization: "Bearer #{@token}" }
      @jerry.reload

      assert_equal new_handle, @jerry.handle
      assert_equal new_email,  @jerry.email
    end
  end
end
