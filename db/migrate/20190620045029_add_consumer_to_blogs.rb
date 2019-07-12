class AddConsumerToBlogs < ActiveRecord::Migration[5.2]
  def change
    add_column :blogs, :consumer, :string
  end
end
