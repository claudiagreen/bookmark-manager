def sign_up
  visit '/users/new'
  fill_in :email, with: "test@gmail.com"
  fill_in :password, with: "password"
  fill_in :password_confirmation, with: "password"
  click_button "submit"
end

def sign_up2
  visit '/users/new'
  fill_in :email, with: "test2@gmail.com"
  fill_in :password, with: "password2"
  fill_in :password_confirmation, with: "password2"
  click_button "submit"
end

def sign_up_bad_password
  visit '/users/new'
  fill_in :email, with: "test@gmail.com"
  fill_in :password, with: "password"
  fill_in :password_confirmation, with: "pissword"
end

def sign_in(email:, password:)
  visit '/links'
  fill_in :email, with: email
  fill_in :password, with: password
  click_button 'submit'
end
