class AddModelComments < ActiveRecord::Migration
  def self.up
    create_table :comments do |t|
      t.column :article_id,         :integer
      t.column :admin,              :boolean,   :default => false
      t.column :user_ip,            :string
      t.column :user_agent,         :string
      t.column :referrer,           :string
      t.column :approved,           :boolean,   :default => false
      t.column :name,               :string
      t.column :email,              :string
      t.column :website,            :string
      t.column :yay,                :text,      :default => ""
      t.column :nay,                :text,      :default => ""
      t.column :vote_count,         :integer,   :default => 1
      t.column :body,               :text
      t.column :body_html,          :text
      t.timestamps
    end
    add_index :comments, :article_id
    add_index :comments, :approved
  end

  def self.down
    drop_table :comments
  end
end
