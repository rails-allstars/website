class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.datetime :start_time
      t.string :title
      t.text :description
      t.belongs_to :location

      t.timestamps
    end
    add_index :events, :location_id
  end
end
