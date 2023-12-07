class UsersController < ApplicationController

    def create
      user = User.find_by(user_params[:username])
        if (user_params[:password] == user_params[:password_confirmation])
          user = User.create(user_params)
          session[:user_id] = user.id
          render json: user, status: :created
        else
          render json: { error: "incorrect password" }, status: :unprocessable_entity
        end
      end

      def me
        if session[:user_id]
          user_name = User.find(session[:user_id])
            render json: user_name
        else 
          render json: {error: "unauthorized"}, status: :unauthorized
        end
      end

      private


      def user_params
        params.permit(:username, :password, :password_confirmation)
      end

end
