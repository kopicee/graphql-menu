class Types::ItemKind < Types::BaseEnum
  value "product", "A standalone product that can be selected on its own"
  value "component", "A component that modifies a product selection"
end
