class CreateMenuSections < ActiveRecord::Migration[8.0]
  def change
    create_table :menu_sections do |t|
      t.integer :display_order, default: 0

      t.references :menu, foreign_key: true
      t.references :section, foreign_key: true

      t.index [ :menu_id, :section_id, :display_order ], unique: true
    end
  end
end
