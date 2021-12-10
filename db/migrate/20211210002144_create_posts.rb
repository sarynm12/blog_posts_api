class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.string :author
      t.integer :author_id
      t.integer :likes
      t.float :popularity
      t.integer :reads
      t.string :tags, array: true, default: []

      t.timestamps
    end
  end
end
