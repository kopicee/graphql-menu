class CreateSectionItems < ActiveRecord::Migration[8.0]
  def change
    create_table :section_items do |t|
      t.integer :display_order, default: 0

      t.references :section, foreign_key: true
      t.references :item, foreign_key: true

      t.index [ :section_id, :item_id, :display_order ], unique: true
    end
  end
end
