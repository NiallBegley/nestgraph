require 'devise/jwt/test_helpers'

class UsersController < ApplicationController

    def login
        user = User.find_by(email: params[:user][:email].to_s.downcase)
      
        if user && user.valid_password?(params[:user][:password])
            sign_in(:user, user)

            headers = { 'Accept' => 'application/json', 'Content-Type' => 'application/json' }

            auth_headers = Devise::JWT::TestHelpers.auth_headers(headers, user)
            response.set_header("Authorization", auth_headers["Authorization"])
            render json: {message: "ok"}, status: :ok
        else
          render json: {error: 'Invalid username / password'}, status: :unauthorized
        end
      end
      
end
