class MenuSection < ApplicationRecord
  belongs_to :menu
  belongs_to :section

  delegate :label, :description, :created_at, :updated_at, :items, to: :section
end
