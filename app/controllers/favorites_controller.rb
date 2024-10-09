class FavoritesController < ApplicationController
  before_action :set_blog

  def create
    current_user.favorites.create(blog: @blog)
    # Ajaxリクエストに対応
    respond_to do |format|
      
      # リクエストに対応するフォーマット（format.htmlやformat.js）を記述
      # format.jsで指定した非同期のレスポンスindex.js.erb を返す
      format.js { render :create }
    end
  end

  def destroy
    favorite = current_user.favorites.find_by(blog: @blog)
    favorite&.destroy
    respond_to do |format|
      format.js { render :destroy}
    end
  end

  # いいねの登録削除前に対象のblog_idをもつblogを取得
  def set_blog
    @blog = Blog.find(params[:blog_id])
  end

end
