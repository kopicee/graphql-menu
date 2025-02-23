class Modifier < ApplicationRecord
  belongs_to :modifier_group
  belongs_to :item

  delegate :kind, :label, :description, to: :item

  def price_override
    item.price
  end
end
