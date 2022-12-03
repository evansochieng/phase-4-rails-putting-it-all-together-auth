class SessionsController < ApplicationController
  # login
  def create
    # find user
    user = User.find_by(username: params[:username])

    #authenticate user
    if user&.authenticate(params[:password])
      # save user's id in sessions hash
      session[:user_id] = user.id

      # render user
      render json: user, status: :ok
    else
      # raise an error
      render json: { error: user.errors.full_messages }, status: :unauthorized
    end
  end

  def destroy
    # find user
    user = User.find_by(id: session[:user_id])

    #check if user is logged in
    if  user.valid?
      # delete user's id in sessions hash
      session.delete :user_id

      # return empty response 
      head :no_content
    else
      # raise an error
      render json: { error: user.errors.full_messages }, status: :unauthorized
    end
  end
end
