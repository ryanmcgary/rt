class CreateLinks < ActiveRecord::Migration[6.1]
  def change
    create_table :links do |t|
      t.string :url
      t.string :admin_id
      t.boolean :active
      t.integer :view_count

      t.timestamps
    end
  end
end
