class TransitCreatePosts < ActiveRecord::Migration
  def change
    create_table(:posts) do |t|
      t.string  :title
      t.text    :teaser
      t.string  :slug
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
  end
end