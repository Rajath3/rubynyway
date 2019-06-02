class User < ApplicationRecord
    # including serializable hash
    include ActiveModel::Serializers::JSON
    attr_accessor :name
    validates :name ,presence: true
    # normal scope
    scope :logged_in, -> { where(:logged_in => true)}
    #lambda scopes
    scope :update_loggedinusers, lambda { |name| where(:name=> name)}

    # either class methods or scope whicher we can use
    # depends on individual
    def self.select_field
        select(:name,:id)
    end

    def self.pluck_names
        pluck(:name)
    end

    # instance methods in model which can be modified 
    def get_my_login_status
        unless self.logged_in
          self.logged_in = true 
          save
        end
    end

    # getting an object serialize and getting it back as object when needed
    # TODO: WHy?? Dig much deeper
    def attributes
        {'name' =>nil}
    end
end
