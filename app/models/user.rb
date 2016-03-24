require 'dm-validations'


class User
  include DataMapper::Resource

  property :id, Serial
  property :email, String, required:true, unique:true,
    format: :email_address, messages: {
      presence:'Email address required to register',
      is_unique:'Email address already exits',
      format:'Email address invalid'
    }
  property :password, BCryptHash
  attr_accessor :password_confirmation

  validates_confirmation_of :password

  def pw_match?
    password == password_confirmation
  end

  def no_email?
    email.empty?
  end

  def error_msgs
    errors.values.flatten
  end

  def self.find_user(email, password)
    found_user = User.all(email: email)
    return found_user[0] if found_user[0].password == password
    User.create
  end

end
