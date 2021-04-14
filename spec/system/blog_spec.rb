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
      first_row = find("#favorite-#{third_blog.id}")
      second_row = find("#favorite-#{second_blog.id}")
      click_link nil, href: favorites_path(blog_id: second_blog.id)
      expect(first_row).not_to have_selector '.delete-favorite'
      expect(first_row).to have_selector '.post-favorite'
      expect(second_row).to have_selector '.delete-favorite'
      expect(second_row).not_to have_selector '.post-favorite'
    end
    it '非同期で解除すること', js: true do
      first_row = find("#favorite-#{third_blog.id}")
      second_row = find("#favorite-#{second_blog.id}")
      click_link nil, href: favorites_path(blog_id: second_blog.id)
      sleep 0.5
      click_link nil, href: favorite_path(id: user.favorites.first.id, blog_id: second_blog.id)
      expect(first_row).not_to have_selector '.delete-favorite'
      expect(first_row).to have_selector '.post-favorite'
      expect(second_row).not_to have_selector '.delete-favorite'
      expect(second_row).to have_selector '.post-favorite'
    end
  end
end
