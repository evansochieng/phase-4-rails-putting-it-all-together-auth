class RecipesSerializer < ActiveModel::Serializer
  attributes :id, :title, :instructions, :minutes_to_complete

  # add macro for user
  belongs_to :user
end
