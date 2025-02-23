class CreateModifiers < ActiveRecord::Migration[8.0]
  def change
    create_table :modifiers do |t|
      t.integer :display_order, default: 0
      t.integer :default_quantity, default: 0
      t.integer :price_override, null: true

      t.references :item, foreign_key: true
      t.references :modifier_group, foreign_key: true

      t.index [ :modifier_group_id, :display_order ], unique: true

      t.timestamps
    end
  end
end
