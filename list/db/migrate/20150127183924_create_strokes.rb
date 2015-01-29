class CreateStrokes < ActiveRecord::Migration
  def change
    create_table :strokes do |t|
      t.text :content
      t.text :tags
      t.text :icon
      t.integer :like
      t.text :keyhole
      t.text :url

      t.timestamps null: false
    end
  end
end
