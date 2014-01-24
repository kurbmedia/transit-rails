class InstallTransit < ActiveRecord::Migration
  def change
    create_table(:transit_settings) do |t|
      t.string :key
      t.text   :value
      t.string :value_type
      t.text   :options
      t.timestamps
    end
    
    create_table(:transit_pages) do |t|
      t.string   :name
      t.string   :title
      t.text     :description
      t.text     :keywords
      t.string   :slug
      t.string   :identifier
      t.text     :region_data, :default => nil
      t.string   :draft_state, :default => 'draft'
      t.string   :template, :default => "default"
      t.string   :ancestry
      t.integer  :ancestry_depth, :default => nil
      t.boolean  :published, :default => false
      t.datetime :publish_on
      t.boolean  :editable, :default => true
      
      ##
      # Orderable
      # 
      # t.integer :position, :default => nil
      
      t.timestamps
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
      t.integer    :ancestry_depth, :default => nil
      t.belongs_to :menu
      t.belongs_to :page
      t.integer    :position
      t.string     :uid
      t.timestamps
    end
    
    create_table(:transit_medias) do |t|
      t.string     :name
      t.string     :file_name
      t.string     :content_type, default: ""
      t.integer    :file_size, default: 0
      t.string     :fingerprint
      t.string     :media_type
      t.belongs_to :attachable, polymorphic: true
      t.timestamps
    end

    
    add_index :transit_pages, :identifier, :unique => true
    add_index :transit_menus, :identifier, :unique => true
  end
end