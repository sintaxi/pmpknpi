class AddModelComments < ActiveRecord::Migration
  def self.up
    create_table :comments do |t|
      t.column :article_id,         :integer
      t.column :author,             :string
      t.column :name,               :string
      t.column :email,              :string
      t.column :website,            :string
      t.column :mods_up,            :text,      :default => ""
      t.column :mods_down,          :text,      :default => ""
      t.column :mods_count,         :integer,   :default => 1
      t.column :body,               :text
      t.column :body_html,          :text
      t.column :created_at,         :datetime
      t.column :updated_at,         :datetime
    end
    add_index :comments, :article_id
  end

  def self.down
    drop_table :comments
  end
end
