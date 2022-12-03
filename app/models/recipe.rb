class Recipe < ApplicationRecord
    #validations
    validates :title, presence: true
    validates :instructions, presence: true, length: {minimum: 50}

    #association macro
    belongs_to :user
end
