feature '#filtering' do
  scenario 'allows a user to filter tags' do
    link = Link.create(title: "google", url: "www.google.com")
    tag = Tag.create(name: "bubbles")
    link.tags << tag
    link.save
    link2 = Link.create(title: "facebook", url: "www.facebook.com")
    tag2 = Tag.create(name: "nobubbles")
    link2.tags << tag2
    link2.save
    visit '/tags/bubbles'
    expect(page).to have_content "google"
    expect(page).not_to have_content "facebook"
  end
end
