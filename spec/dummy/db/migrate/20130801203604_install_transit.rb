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
      t.datetime :publish_on
      t.boolean  :editable, :default => true
      
      ##
      # Orderable
      # 
      t.integer :position, :default => nil
      
      t.timestamps
    end
    
    create_table(:transit_regions) do |t|
      t.belongs_to  :page
      t.string      :dom_id
      t.text        :content
      t.string      :type
      t.text        :data
      t.text        :snippet_data
    end
    
    create_table(:transit_drafts) do |t|
      t.belongs_to  :draftable, polymorphic: true
      t.text        :content
    end
    
    create_table(:transit_menus) do |t|
      t.string :name
      t.string :identifier
      t.timestamps
    end
    
    create_table(:transit_menu_items) do |t|
      t.string     :title
      t.string     :url
      t.string     :target
      t.string     :ancestry
      t.belongs_to :menu
      t.integer    :ancestry_depth, :default => nil
      t.timestamps
    end
    
    
    add_index :transit_pages, :identifier, :unique => true
    add_index :transit_menus, :identifier, :unique => true
    
  end
end
