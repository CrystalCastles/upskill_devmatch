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
            flash[:success] = "Message sent"
            redirect_to new_contact_path
        else
            flash[:error] = @contact.errors.full_messages.join(", ")
            redirect_to new_contact_path
        end
    end
    
    # Get the parameters securely, private will only allow the method to be executed internally
    private
        def contact_params
            params.require(:contact).permit(:name, :email, :comments)
        end
end