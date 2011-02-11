class AddAmazonUrlToBook < ActiveRecord::Migration
  def self.up
    add_column :books, :amazon_url, :string
  end

  def self.down
    remove_column :books, :amazon_url
  end
end
