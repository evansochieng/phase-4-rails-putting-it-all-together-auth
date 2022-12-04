class RecipesController < ApplicationController
  # handle invalid error
rescue_from ActiveRecord::RecordInvalid, with: :handle_invalid_response
  # Recipe list feature
  def index
    # find user (check if logged in)
    user = User.find_by(id: session[:user_id])

    if user
      # return an array of all recipes
      render json: Recipe.all, include: ["user"], status: :created
    else
      # raise an error
      render json: { errors: ["Not authorized"] }, status: :unauthorized
    end
  end

  # Recipe creation feature
  def create
    # find user (check if logged in)
    user = User.find_by(id: session[:user_id])

    # if user is logged in
    if user
      recipe = user.recipes.create!(recipe_params)

      # check if recipe is valid
      if recipe.valid?
        render json: recipe, include: ["user"], status: :created
      else
        render json: {errors: ["Invalid parameters"]}, status: :unprocessable_entity
      end
    else
      # raise an error
      render json: { errors: ["Not authorized"] }, status: :unauthorized
    end
  end

  private
  # strong params for recipe creation
  def recipe_params
    params.permit(:title, :instructions, :minutes_to_complete)
  end

  # handle invalid instance
  def handle_invalid_response(exeption)
    render json: {errors: exeption.record.errors.full_messages}, status: :unprocessable_entity
  end
end
