# frozen_string_literal: true

module Types
  class MenuType < Types::BaseObject
    field :id, ID, null: false
    field :label, String
    field :state, MenuState
    field :start_date, GraphQL::Types::ISO8601Date
    field :end_date, GraphQL::Types::ISO8601Date
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false

    field :menu_sections, [ Types::MenuSectionType ]
  end
end
