class UsersController < ApplicationController
  # Sign up feature
  def create
    #create a new user and save to db
    user = User.create(user_params)

    # chack if user is valid
    if user.valid?
      #Save the user's ID in the session hash
      session[:user_id] = user.id

      #render user
      render json: user, status: :created
    else
      render json: {errors: user.errors.full_messages}, status: :unprocessable_entity
    end
    
  end

  #Auto login feature
  def show
    # check if user is logged in
    user = User.find_by(id: session[:user_id])

    # check if user is authorized
    if user
      render json: user, status: :ok
    else
      render json: {error: "Invalid username or password"}, status: :unauthorized
    end
  end

  private
  #strong params
  def user_params
    params.permit(:username, :password, :password_confirmation, :image_url, :bio)
  end
end
