class Types::MenuState < Types::BaseEnum
  value "unapproved", "Menu has been defined but not activated"
  value "inactive", "Menu has been approved but not yet visible to customers"
  value "active", "Menu is active and visible to customers"
end
