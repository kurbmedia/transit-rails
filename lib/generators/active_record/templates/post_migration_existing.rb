class TransitAddPostFunctionalityTo<%= table_name.camelize %> < ActiveRecord::Migration
  def self.up
    change_table(:<%= table_name %>) do |t|
      t.string  :title
      t.text    :teaser
      t.string  :slug
      t.text    :keywords
      t.text    :content
      t.text    :content_schema

      ##
      # Publishable
      # 
      # t.boolean  :published, :default => false
      # t.datetime :publish_date
      
      ##
      # Orderable
      # 
      # t.integer :position, :default => 0
      
      # Uncomment unless your model already has timestamps
      # t.timestamps
    end
    
    add_index :<%= table_name %>, :identifier, :unique => true
  end
  
  def self.down
    raise ActiveRecord::IrreversibleMigration
  end
end