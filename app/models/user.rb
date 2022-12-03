class User < ApplicationRecord
    # validations 
    validates :username, presence: true, uniqueness: true

    #association macro
    has_many :recipes

    #macro for password encryption with bcrypt
    has_secure_password
end
