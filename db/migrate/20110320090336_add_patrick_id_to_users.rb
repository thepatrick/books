class AddPatrickIdToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :patrick_id, :integer
  end

  def self.down
    remove_column :users, :patrick_id
  end
end
