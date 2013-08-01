class TransitCreatePages < ActiveRecord::Migration
  def change
    create_table(:pages) do |t|
      t.string  :name
      t.string  :title
      t.text    :description
      t.text    :keywords
      t.string  :slug
      t.string  :identifier
      t.string  :ancestry
      t.integer :ancestry_depth, :default => nil
      t.text    :slug_map
      t.timestamps
      
      ##
      # Publishing extension
      # 
      t.boolean  :published, :default => false
      t.datetime :publish_date
      
      ##
      # Ordering extension
      # 
      t.integer :position, :default => 0
    end
    
    add_index :pages, :identifier, :unique => true
  end
end