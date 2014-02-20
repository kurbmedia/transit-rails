class InstallTransit < ActiveRecord::Migration
  def change
    create_table(:transit_settings) do |t|
      t.string :key
      t.text   :value
      t.string :value_type
      t.text   :options
      t.timestamps
    end

    create_table(:transit_drafts) do |t|
      t.belongs_to  :draftable, polymorphic: true
      t.text        :content
    end
  end
end