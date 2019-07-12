class CreateBlogimages < ActiveRecord::Migration[5.2]
  def change
    create_table :blogimages do |t|
      t.integer :blog_ref
      t.integer :im_ref

      t.timestamps
    end
  end
end
