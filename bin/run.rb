require_relative '../config/environment'
require_relative 'methods.rb'
require "tty-prompt"

greeting
def menu
    prompt = TTY::Prompt.new
    choices = ["Find a groomer", "Book an appointment", "View an existing appointment", "Change an existing appointment", "Delete an existing appointment", "Exit"]
    user_input = prompt.select("What can I do for you today?", choices)
    
    case (user_input)
        when user_input = "Find a groomer"
            groomer_menu
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

