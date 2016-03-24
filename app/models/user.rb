require 'dm-validations'


class User
  include DataMapper::Resource

  property :id, Serial
  property :email, String
  property :password, BCryptHash
  attr_accessor :password_confirmation

  validates_confirmation_of :password

end
