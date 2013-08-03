class TransitCreate<%= table_name.camelize %>WithPageFunctionality < ActiveRecord::Migration
  def change
    create_table(:<%= table_name %>) do |t|
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
      # Publishable
      # 
      # t.boolean  :published, :default => false
      # t.datetime :publish_date
      
      ##
      # Orderable
      # 
      # t.integer :position, :default => nil
      
      
      t.timestamps
    end
    
    add_index :<%= table_name %>, :identifier, :unique => true
  end
end