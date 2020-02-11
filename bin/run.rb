require_relative '../config/environment'
require "tty-prompt"

def greeting
    prompt = TTY::Prompt.new
    prompt.ok("Welcome to the Mobile Dog Grooming Assistant! If you're using this application, you're probably rich and/or famous. Ifnot, leave immediately and don't come back until you're the next Keanu Reeves. Unlikely, but not impossible.")
    puts "Why don't you enter your dogs name, rich and/or famous person?"
    name = gets.chomp
    prompt.ok("Why, hello there, #{name}!")
end 
greeting

def groomer 
    prompt = TTY::Prompt.new
    location_choices = ["Brooklyn", "Manhattan", "Queens", "Bronx", "Staten Island"]
    location_input = prompt.select("Where is your loft?", location_choices)
    groomer_1 = Groomer.all.select{ |groomer_obj| groomer_obj.location == location_input}
    groomer_name_array = groomer_1.map{|groomer| groomer.name}
    groomer_name_list = groomer_name_array.each{ |groomer_name| puts groomer_name }
    system("clear")
    puts "Here is a list of all the groomers in the area!" 
    puts groomer_name_list
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
#<Appointment:0x00007f8b7345f3c0 id: 106, dog_id: 1, groomer_id: 15, time: "07 Feb 06:14">
#<Appointment:0x00007f8b73257be0 id: 107, dog_id: 1, groomer_id: 15, time: "09 Feb 07:57">
#<Appointment:0x00007f8b729d37f8 id: 107, dog_id: 1, groomer_id: 15, time: "09 Feb 07:57">
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

def menu
    prompt = TTY::Prompt.new
    choices = ["Find a groomer", "Book an appointment", "View an existing appointment", "Change an existing appointment", "Delete an existing appointment", "Exit"]
    user_input = prompt.select("What can I do for you today?", choices)
    
    case (user_input)
        when user_input = "Find a groomer"
            groomer
            menu
        when user_input = "Book an appointment"
            create_appointment
            menu
        when user_input = "View an existing appointment"
            view_appointment
            menu
        when user_input = "Change an existing appointment"
            change_appointment
            menu
        when user_input = "Delete an existing appointment"
            delete_appointment
            menu
        when user_input = "Exit"
            puts "Thank you for using Mobile Grooming Assistant! Unless you cancelled an appointment, in which case, don't come back."
    end 
        
end 
menu


# TO DO TOMORROW:
# -CREATE GLOBAL APPOINTMENT VARIABLE AND APPLY CRUD OPTIONS

