class TransitCreatePages < ActiveRecord::Migration
  def change
    create_table(:transit_pages) do |t|
      t.string  :name
      t.string  :title
      t.text    :description
      t.text    :keywords
      t.string  :slug
      t.string  :identifier
      t.string  :ancestry
      t.integer :ancestry_depth, :default => nil
      t.text    :slug_map
      t.text    :content
      t.text    :content_schema
      
      ##
      # Publishing extension
      # 
      t.boolean  :published, :default => false
      t.datetime :publish_date
      
      ##
      # Ordering extension
      # 
      t.integer :position, :default => nil
      
      t.timestamps
    end
    
    add_index :pages, :identifier, :unique => true
  end
end