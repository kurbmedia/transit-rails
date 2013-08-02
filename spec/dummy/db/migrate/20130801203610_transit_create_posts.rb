class TransitCreatePosts < ActiveRecord::Migration
  def change
    create_table(:transit_posts) do |t|
      t.string  :title
      t.text    :teaser
      t.string  :slug
      t.text    :content
      t.text    :content_schema

      ##
      # Publishing extension
      # 
      t.boolean  :published, :default => false
      t.datetime :publish_date
      
      t.timestamps
    end
  end
end