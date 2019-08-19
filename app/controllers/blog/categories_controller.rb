# frozen_string_literal: true

# Category controller for blog
class Blog::CategoriesController < Blog::BaseController
  def show
    @category = ButterCMS::Category.find(params[:slug], include: :recent_posts)
  end
end