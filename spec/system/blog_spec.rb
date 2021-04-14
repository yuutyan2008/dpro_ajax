require 'rails_helper'
RSpec.describe Blog do
  let!(:user) { FactoryBot.create(:user) }
  let!(:second_user) { FactoryBot.create(:second_user) }
  let!(:third_user) { FactoryBot.create(:third_user) }
  let!(:blog) { FactoryBot.create(:blog, user_id: user.id) }
  let!(:second_blog) { FactoryBot.create(:second_blog, user_id: second_user.id) }
  let!(:third_blog) { FactoryBot.create(:third_blog, user_id: third_user.id) }

  describe 'お気に入り機能' do
    before do
      visit new_user_session_path
      fill_in "Email", with: user.email
      fill_in "Password", with: user.password
      click_on "Log in"
    end
    it '非同期で登録すること', js: true do
      find(".post-#{second_blog.id}").click
      expect(page).not_to have_css ".post-#{second_blog.id}"
      expect(page).to have_css ".delete-#{second_blog.id}"
      expect(page).to have_css ".post-#{third_blog.id}"
      expect(page).not_to have_css ".delete-#{third_blog.id}"
    end
    it '非同期で解除すること', js: true do
      find(".post-#{second_blog.id}").click
      find(".delete-#{second_blog.id}").click
      expect(page).to have_css ".post-#{second_blog.id}"
      expect(page).not_to have_css ".delete-#{second_blog.id}"
      expect(page).to have_css ".post-#{third_blog.id}"
      expect(page).not_to have_css ".delete-#{third_blog.id}"
    end
  end
end
