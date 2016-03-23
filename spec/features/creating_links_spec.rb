feature "Creating links" do
  scenario "user can add links" do
    visit('/links/new')
    fill_in :title, with: 'Google'
    fill_in :url, with: 'http://www.google.com'
    fill_in :tags, with: 'search engine'
    click_button 'submit'
    link = Link.first
    expect(link.tags.map(&:name)).to include('search engine')
  end
end
