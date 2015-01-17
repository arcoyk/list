class CreateStrokes < ActiveRecord::Migration
  def change
    create_table :strokes do |t|
      t.string :tags
      t.text :content

      t.timestamps null: false
    end
  end
end
