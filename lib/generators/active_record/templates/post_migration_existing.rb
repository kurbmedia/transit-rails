class TransitAddPostFunctionalityTo<%= table_name.camelize %> < ActiveRecord::Migration
  def self.up
    change_table(:<%= table_name %>) do |t|
      t.string  :title
      t.text    :teaser
      t.string  :slug
      
      # Uncomment unless your model already has timestamps
      # t.timestamps
      
      ##
      # Publishing extension
      # 
      # t.boolean  :published, :default => false
      # t.datetime :publish_date
      
      ##
      # Ordering extension
      # 
      # t.integer :position, :default => 0
    end
    
    add_index :<%= table_name %>, :identifier, :unique => true
  end
  
  def self.down
    raise ActiveRecord::IrreversibleMigration
  end
end