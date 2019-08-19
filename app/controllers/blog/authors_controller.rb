# frozen_string_literal: true

# Author controller for blog
class Blog::AuthorsController < Blog::BaseController
  def show
    @author = ButterCMS::Author.find(params[:slug], include: :recent_posts)
  end
end
