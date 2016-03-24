feature 'signing in' do
  scenario 'registered user can sign in' do
    User.create(email: 'test@gmail.com', password: 'password', password_confirmation: 'password')
    visit('/login')
    fill_in :email, with: "test@gmail.com"
    fill_in :password, with: "password"
    click_button 'submit'
    expect(page).to have_content('Welcome, test@gmail.com')
  end
end
