# require 'Faker'
5.times do
    Dog.create(
        name: Faker::Creature::Dog.name,
        location: Faker::Address.city
    )
end 


15.times do
    Groomer.create(
        name: Faker::DcComics.hero,
        location: ["Brooklyn", "Manhattan", "Queens", "Bronx", "Staten Island"].sample
    )
end

45.times do 
    Appointment.create(
        dog_id: Faker::Number.non_zero_digit,
        groomer_id: Faker::Number.non_zero_digit,
        time: Faker::Time.backward(days: 5, period: :morning, format: :short)
    )
end 