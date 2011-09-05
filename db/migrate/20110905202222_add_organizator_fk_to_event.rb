class AddOrganizatorFkToEvent < ActiveRecord::Migration
  def change
    add_column :events, :organizator, :belongs_to
  end
end
