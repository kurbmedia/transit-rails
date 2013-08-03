class TransitCreate<%= table_name.camelize %>WithPostFunctionality < ActiveRecord::Migration
  def change
    create_table(:<%= table_name %>) do |t|
      t.string  :title
      t.text    :teaser
      t.string  :slug
      
      t.text    :content
      t.text    :content_schema
      
      t.timestamps

      ##
      # Publishable
      # 
      # t.boolean  :published, :default => false
      # t.datetime :publish_date
      
      ##
      # Orderable
      # 
      # t.integer :position, :default => 0
    end
  end
end