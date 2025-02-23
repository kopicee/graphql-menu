module Resolvers
  class MenuResolver < BaseResolver
    type [ Types::MenuType ], null: false
    argument :state, Types::MenuState, required: false

    def resolve(state:)
      state ? ::Menu.where(state:) : ::Menu.all
    end
  end
end
