class TransitCreate<%= table_name.camelize %>WithPostFunctionality < ActiveRecord::Migration
  def change
    create_table(:<%= table_name %>) do |t|
      t.string  :title
      t.text    :teaser
      t.string  :slug
      t.timestamps

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
  end
end