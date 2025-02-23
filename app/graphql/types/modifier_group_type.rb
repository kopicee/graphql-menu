# frozen_string_literal: true

module Types
  class ModifierGroupType < Types::BaseObject
    field :label, String
    field :selection_required_min, Integer
    field :selection_required_max, Integer

    field :modifiers, [ Types::ModifierType ]
  end
end
