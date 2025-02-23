# frozen_string_literal: true

module Types
  class ModifierType < Types::BaseObject
    field :display_order, Integer
    field :default_quantity, Integer
    field :price_override, Float

    field :kind, ItemKind
    field :label, String
    field :description, String
  end
end
