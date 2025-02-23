class Item < ApplicationRecord
  has_many :item_modifier_groups
  has_many :modifier_groups, through: :item_modifier_groups
end
