class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :name
      t.string :quan
      t.text :notes
      t.integer :list_id

      t.timestamps
    end
  end
end
