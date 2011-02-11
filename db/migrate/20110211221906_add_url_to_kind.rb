class AddUrlToKind < ActiveRecord::Migration
  def self.up
    add_column :kinds, :url, :string
  end

  def self.down
    remove_column :kinds, :url
  end
end
