class RemovePriceOverrideFromModifiers < ActiveRecord::Migration[8.0]
  def change
    remove_column :modifiers, :price_override, :integer
  end
end
