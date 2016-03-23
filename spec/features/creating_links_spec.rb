feature "Creating links" do
  scenario "user can add links" do
    visit('/links/new')
    fill_in :title, with: 'Google'
    fill_in :url, with: 'http://www.google.com'
    click_button 'submit'
    expect(page).to have_content 'Google'
  end
end
