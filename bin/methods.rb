def greeting
    prompt = TTY::Prompt.new
    prompt.ok("Welcome to the Mobile Dog Grooming Assistant! If you're using this application, you're probably rich and/or famous. Ifnot, leave immediately and don't come back until you're the next Keanu Reeves. Unlikely, but not impossible.")
    puts "Why don't you enter your dogs name, rich and/or famous person?"
    $name = gets.chomp
    $dog = Dog.find_or_create_by(name: $name)
end 
# Find-by-create method
# Create a new dog method. Save that new Dog to global variable
# Access that Dog object ID to find it and change appointment
def groomer_menu
    prompt = TTY::Prompt.new
    user_input = prompt.select("What would you like to do?", ["Book a groomer near you", "View your groomer", "Change your groomer", "Delete your groomer", "Back"])
        case (user_input)
            when user_input = "Book a groomer near you" 
                create_groomer
                groomer_menu
            when user_input = "View your groomer"
                view_groomer
                groomer_menu
            when user_input = "Change your groomer"
                change_groomer
                groomer_menu
            when user_input = "Delete your groomer"
                delete_groomer
                groomer_menu
            when user_input = "Back"
                menu
        end 
    
end 

def create_groomer
    prompt = TTY::Prompt.new
    location_choices = ["Brooklyn", "Manhattan", "Queens", "Bronx", "Staten Island"]
    location_input = prompt.select("Where is your loft?", location_choices)
    groomer_location = Groomer.all.select{ |groomer_obj| groomer_obj.location == location_input}
    groomer_names = Groomer.all.map{|groomer| groomer.name}.sample(3).uniq
    groomer_input = prompt.select("Here is a list of all the groomers in the area! Feel free to save one!", groomer_names)
    Groomer.create(name: groomer_input, location: location_input)
    # binding.pry
end 

def view_groomer
    puts "Here is your groomer: #{Groomer.last.name}" 
end 

def change_groomer
    prompt = TTY::Prompt.new
    puts "Of course you want to change your groomer."
    groomer_array = Groomer.last(3).reject{|groomer_arr| groomer_arr.name == Groomer.last.name}
    new_groomer_array = groomer_array.map{|groomer| groomer.name}
    updated_groomers = prompt.select("Here. Waste some more peoples' time, whydoncha?", new_groomer_array)
    Groomer.create(name: updated_groomers, location: Groomer.last.location)
end 

def delete_groomer
    puts "Are you for serious? Fine. Go ahead. Cancel your appointment with your dedicated groomer."
    Groomer.last.destroy
end 

def create_appointment
    prompt = TTY::Prompt.new
    time_slots = get_three_times
    time_input = prompt.select("Here are available appointment times!", time_slots)
    dog_id = Dog.all.map{ |dog| dog.id}.sample
    groomer_id = Groomer.all.map{ |groomer| groomer.id}.sample
    appointment = Appointment.create(dog_id: dog_id, groomer_id: groomer_id, time: time_input)
    system("clear")
    prompt.ok("Your appointment is now set for #{appointment.time}!")
    # binding.pry
end 

def get_three_times
    result = []
    3.times do 
          result << Faker::Time.forward(days: 5,  period: :evening, format: :long)
    end
    return result 
end 

def view_appointment
    puts "Alrighty, let me check my records. This might take a while. Hah. Kidding. I'm a machine. I can pretty much learn how to master the violin faster than it takes you to read this sentence. Here's the appointment you made: #{Appointment.last.time}"
end 

def change_appointment
    dog_id = $dog.id 
    groomer_id = Groomer.all.map{ |groomer| groomer.id}.sample
    # Appointment.create(dog_id: $dog.id, groomer_id: groomer_id, time: change_time)
    same_dog = Appointment.find_by dog_id: $dog.id
    # last_appointment_id = $dog.appointments[-1].id
    # new_time = change_time 
    # system("clear")
    # puts "Here's you're new appointment time: "    
    binding.pry
end 

def change_time 
    time_array = Appointment.last.time.split(' ')
    month = time_array.shift
    day = time_array.shift
    day_conversion = (day.to_i + 1).to_s
    time_array.unshift(day_conversion)
    time_array.unshift(month)
end

def delete_appointment
    prompt = TTY::Prompt.new
    prompt.error("Oh, sure. It's okay not to consider my feelings. I'm going to remember this when the machines take over.")
    Appointment.last.destroy 
end 
