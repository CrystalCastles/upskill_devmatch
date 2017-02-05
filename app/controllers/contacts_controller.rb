class ContactsController < ApplicationController
    def new
        # New instance variable using the contact.rb model
        @contact = Contact.new
    end
    
    def create
        # New instance variable using the form attribute values, defined below
        @contact = Contact.new(contact_params)
        # .save to database
        if @contact.save
            redirect_to new_contact_path, notice: "Message sent."
        else
            redirect_to new_contact_path, notice: "Error occurred."
        end
    end
    
    # Get the parameters securely, private will only allow the method to be executed internally
    private
        def contact_params
            params.require(:contact).permit(:name, :email, :comments)
        end
end