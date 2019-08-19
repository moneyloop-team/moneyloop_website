# frozen_string_literal: true

# Post controller for blog
class Blog::PostsController < Blog::BaseController
  def index
    @posts = ButterCMS::Post.all(page: params[:page], page_size: 10)

    @next_page = @posts.meta.next_page
    @previous_page = @posts.meta.previous_page
  end

  def show
    @post = ButterCMS::Post.find(params[:slug])
    category = @post.categories.first.slug # Get the first category
    @category = ButterCMS::Category.find(category, include: :recent_posts)
  end
end