class AddTitleandtextToBlogs < ActiveRecord::Migration[5.2]
  def change
    add_column :blogs, :title, :string
    add_column :blogs, :text, :text
  end
end
