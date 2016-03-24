def sign_up
  visit '/users/new'
  fill_in :email, with: "anthony@gmail.com"
  fill_in :password, with: "password"
  fill_in :password_confirmation, with: "password"
  click_button "submit"
end
