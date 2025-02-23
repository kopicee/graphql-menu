class CreateItemModifierGroups < ActiveRecord::Migration[8.0]
  def change
    create_table :item_modifier_groups do |t|
      t.references :item, foreign_key: true
      t.references :modifier_group, foreign_key: true
    end
  end
end
