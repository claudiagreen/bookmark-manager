feature 'Multi-tag' do
  scenario 'User can add multiple tags' do
    visit('/links/new')
    fill_in :title, with: 'Google'
    fill_in :url, with: 'http://www.google.com'
    fill_in :tags, with: 'search_engine pics'
    click_button 'submit'
    link = Link.first
    expect(link.tags.map(&:name)).to include('search_engine', 'pics')
  end

end
