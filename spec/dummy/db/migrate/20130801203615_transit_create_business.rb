class TransitCreateBusiness < ActiveRecord::Migration
  def change
    create_table(:businesses) do |t|
      t.string  :name
      t.text    :summary
      t.string  :slug
      t.timestamps
    end
  end
end