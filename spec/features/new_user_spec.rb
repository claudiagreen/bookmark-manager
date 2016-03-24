feature 'creating a new user' do
  scenario 'creating a new user increases user count by 1' do
  expect { sign_up }.to change(User, :count).by(1)
  expect(page).to have_content('Welcome, anthony@gmail.com')
  expect(User.first.email).to eq('anthony@gmail.com')
  end
end

feature 'password confirmation' do
  scenario 'user not created when password mismatch' do
    visit '/users/new'
    fill_in :email, with: "anthony@gmail.com"
    fill_in :password, with: "password"
    fill_in :password_confirmation, with: "pissword"
    expect { click_button "submit" }.to_not change(User, :count)
    expect(current_path).to eq '/users'
    expect(page).to have_content('Password and confirmation password do not match')
  end
  scenario 'email persists when password mismatch' do
    visit '/users/new'
    fill_in :email, with: "anthony@gmail.com"
    fill_in :password, with: "password"
    fill_in :password_confirmation, with: "pissword"
    click_button 'submit'
    expect(find_field('email').value).to eq 'anthony@gmail.com'
  end
end

feature 'email validation' do
  scenario 'user need an email address to sign up' do
    visit '/users/new'
    fill_in :password, with: "password"
    fill_in :password_confirmation, with: "password"
    expect { click_button "submit" }.to_not change(User, :count)
    expect(current_path).to eq '/users'
    expect(page).to have_content('Email address required to register')
  end

end
