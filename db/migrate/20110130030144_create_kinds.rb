class CreateKinds < ActiveRecord::Migration
  def self.up
    create_table :kinds do |t|
      t.string :title
      t.boolean :ebook

      t.timestamps
    end
  end

  def self.down
    drop_table :kinds
  end
end
