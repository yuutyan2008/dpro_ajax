require 'rails_helper'

RSpec.describe 'Messages', type: :request do
  let!(:user) { FactoryBot.create(:user) }
  let!(:second_user) { FactoryBot.create(:second_user) }
  let!(:third_user) { FactoryBot.create(:third_user) }
  let!(:blog) { FactoryBot.create(:blog, user_id: user.id) }
  let!(:second_blog) { FactoryBot.create(:second_blog, user_id: second_user.id) }
  let!(:third_blog) { FactoryBot.create(:third_blog, user_id: third_user.id) }
  let!(:params) { { favorite: { user_id: user.id, blog_id: second_blog.id } } }
  before do
    sign_in user
  end

  describe "create favorite" do
    it "create favorite" do
      post favorites_path(blog_id: second_blog.id), xhr: true, params: params
      expect(response).to have_http_status(401)
    end
  end
end
