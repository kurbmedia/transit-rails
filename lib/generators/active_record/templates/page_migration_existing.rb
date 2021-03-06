class TransitAddPageFunctionalityTo<%= table_name.camelize %> < ActiveRecord::Migration
  def self.up
    change_table(:<%= table_name %>) do |t|
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
      # t.boolean  :published, :default => false
      # t.datetime :publish_date
      
      ##
      # Ordering extension
      # 
      # t.integer :position, :default => nil
      
      # Uncomment unless your model already has timestamps
      # t.timestamps
    end
    
    add_index :<%= table_name %>, :identifier, :unique => true
  end
  
  def self.down
    raise ActiveRecord::IrreversibleMigration
  end
end