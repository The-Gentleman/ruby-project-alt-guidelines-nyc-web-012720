class Dog < ActiveRecord::Base
    has_many :appointments
    has_many :groomers, through: :appointments
end 