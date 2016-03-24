feature 'creating a new user' do
  scenario 'creating a new user increases user count by 1' do
  expect { sign_up }.to change(User, :count).by(1)
  expect(page).to have_content('Welcome, test@gmail.com')
  expect(User.first.email).to eq('test@gmail.com')
  end
end

feature 'password confirmation' do
  scenario 'user not created when password mismatch' do
    sign_up_bad_password
    expect { click_button "submit" }.to_not change(User, :count)
    expect(current_path).to eq '/users'
    expect(page).to have_content('Password does not match the confirmation')
  end
  scenario 'email persists when password mismatch' do
    sign_up_bad_password
    click_button 'submit'
    expect(find_field('email').value).to eq 'test@gmail.com'
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
  scenario 'user must use a valid email address' do
    visit '/users/new'
    fill_in :email, with: "test@gmail"
    fill_in :password, with: "password"
    fill_in :password_confirmation, with: "password"
    expect { click_button "submit" }.to_not change(User, :count)
    expect(current_path).to eq '/users'
    expect(page).to have_content('Email address invalid')
  end
  scenario 'user must use a valid email address' do
    sign_up
    expect { sign_up }.to_not change(User, :count)
    expect(current_path).to eq '/users'
    expect(page).to have_content('Email address already exits')
  end

end
