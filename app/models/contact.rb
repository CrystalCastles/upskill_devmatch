# Gets attributes from db schema file
class Contact < ActiveRecord::Base
    # Form validation
    validates :name, presence: true
    validates :email, presence: true
    validates :comments, presence: true
end