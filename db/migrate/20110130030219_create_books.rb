class CreateBooks < ActiveRecord::Migration
  def self.up
    create_table :books do |t|
      t.string :title
      t.string :author
      t.integer :kind_id
      t.date :started
      t.date :ended

      t.timestamps
    end
  end

  def self.down
    drop_table :books
  end
end
