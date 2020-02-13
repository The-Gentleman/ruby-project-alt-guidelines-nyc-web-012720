def greeting
    prompt = TTY::Prompt.new
    prompt.ok("Welcome to the Mobile Dog Grooming Assistant! If you're using this application, you're probably rich and/or famous. Ifnot, leave immediately and don't come back until you're the next Keanu Reeves. Unlikely, but not impossible.")
    puts "Why don't you enter your dogs name, rich and/or famous person?"
    name = gets.chomp
    prompt.ok("Why, hello there, #{name}!")
end 

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
    time_slots = Appointment.all.map{ |appointment| appointment.time }.sample(3)
    time_input = prompt.select("Here are available appointment times!", time_slots)
    dog_id = Dog.all.map{ |dog| dog.id}.sample
    groomer_id = Groomer.all.map{ |groomer| groomer.id}.sample
    appointment = Appointment.create(dog_id: dog_id, groomer_id: groomer_id, time: time_input)
    system("clear")
    prompt.ok("Your appointment is now set for #{appointment.time}!")
end 

def view_appointment
    puts "Alrighty, let me check my records. This might take a while. Hah. Kidding. I'm a machine. I can pretty much learn how to master the violin faster than it takes you to read this sentence. Here's the appointment you made: #{Appointment.last.time}"
end 

def change_appointment
    prompt = TTY::Prompt.new
    new_time_slots = Appointment.all.map{ |appointment| appointment.time }.sample(3)
    new_time_input = prompt.select("Ugh, fine. Here are more chances to not honor your commitments.", new_time_slots) 
    dog_id = Appointment.last.dog_id
    groomer_id = Appointment.last.groomer_id
    new_appointment = Appointment.create(dog_id: dog_id, groomer_id: groomer_id, time: new_time_input)
    system("clear")
    puts "Here's you're new appointment time: #{new_appointment.time}. Try not to be a terrible person and reschedule again."
end 

def delete_appointment
    prompt = TTY::Prompt.new
    prompt.error("Oh, sure. It's okay not to consider my feelings. I'm going to remember this when the machines take over.")
    Appointment.last.destroy 
end 
