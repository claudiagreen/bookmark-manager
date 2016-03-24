require 'dm-validations'


class User
  include DataMapper::Resource

  property :id, Serial
  property :email, String, :required => true
  property :password, BCryptHash
  attr_accessor :password_confirmation

  validates_confirmation_of :password
  validates_length_of :email, :min => 1

  def pw_match?
    password == password_confirmation
  end

  def no_email?
    email.empty?
  end

end
