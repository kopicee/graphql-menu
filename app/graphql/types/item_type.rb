# frozen_string_literal: true

module Types
  class ItemType < Types::BaseObject
    field :kind, ItemKind
    field :label, String
    field :description, String
    field :price, Float

    field :modifier_groups, [ Types::ModifierGroupType ]
  end
end
