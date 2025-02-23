# frozen_string_literal: true

module Types
  class MenuSectionType < Types::BaseObject
    field :display_order, Integer

    field :label, String
    field :description, String
    field :items, [ Types::ItemType ]
  end
end
