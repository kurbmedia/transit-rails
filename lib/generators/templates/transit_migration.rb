class InstallTransit < ActiveRecord::Migration
  def change
    create_table(:transit_pages) do |t|
      t.string   :name
      t.string   :title
      t.text     :description
      t.text     :keywords
      t.string   :slug
      t.string   :identifier
      t.string   :template, :default => "default"
      t.string   :ancestry
      t.integer  :ancestry_depth, :default => nil
      t.boolean  :published, :default => false
      t.datetime :publish_date
      
      ##
      # Orderable
      # 
      # t.integer :position, :default => nil
      
      # Uncomment unless your model already has timestamps
      t.timestamps
    end
    
    create_table(:transit_regions) do
      t.string :dom_id
      t.text   :content
      t.text   :draft_content
      t.string :type
      t.text   :data
    end
    
    add_index :transit_pages, :identifier, :unique => true
  end
end