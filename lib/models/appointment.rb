class Appointment < ActiveRecord::Base 
    belongs_to :dog
    belongs_to :groomer
end 