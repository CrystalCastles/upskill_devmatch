class ContactsController < ApplicationController
    
    # GET request to /contact-us
    # Show new contact form
    def new
        # New instance variable using the contact.rb model
        @contact = Contact.new
    end
    
    # POST request /contacts
    def create
        # Mass assignment of form fields (defined below) into Contact object
        @contact = Contact.new(contact_params)
        # Save contact object to database
        if @contact.save
            # Store form fields via parameters, into variables
            name = params[:contact][:name]
            email = params[:contact][:email]
            body = params[:contact][:comments]
            # Plug variables into Contact Mailer email method and send email
            ContactMailer.contact_email(name, email, body).deliver
            # Store success message into flash hash 
            # and redirect to the new action
            flash[:success] = "Message sent"
            redirect_to new_contact_path
        else
            # If Contact object doesn't save, store errors in flash hash
            # and redirect to the new action
            flash[:danger] = @contact.errors.full_messages.join(", ")
            redirect_to new_contact_path
        end
    end
    
    # Get the parameters securely, private will 
    # only allow the method to be executed internally
    private
        # To collect data from form, we need to use strong parameters
        # and whitelist the form fields
        def contact_params
            params.require(:contact).permit(:name, :email, :comments)
        end
end