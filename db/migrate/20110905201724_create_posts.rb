class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.belongs_to :user
      t.string :source
      t.text :text
      t.belongs_to :event

      t.timestamps
    end
    add_index :posts, :user_id
    add_index :posts, :event_id
  end
end
