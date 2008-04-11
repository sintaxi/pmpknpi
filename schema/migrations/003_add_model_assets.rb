class AssetMigration < ActiveRecord::Migration
  def self.up
    create_table :assets do |t|
      t.column :filename,           :string
      t.column :width,              :integer
      t.column :height,             :integer
      t.column :content_type,       :string
      t.column :size,               :integer
      t.column :attachable_type,    :string
      t.column :attachable_id,      :integer
      t.column :thumbnail,          :string
      t.column :parent_id,          :integer
      t.timestamps
    end
    add_index :assets, :attachable_type
    add_index :assets, :attachable_id
    add_index :assets, :parent_id
  end

  def self.down
    drop_table :assets
  end
end

