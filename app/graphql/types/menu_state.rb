class Types::MenuState < Types::BaseEnum
  value "UNAPPROVED", "Menu has been defined but not activated"
  value "INACTIVE", "Menu has been approved but not yet visible to customers"
  value "ACTIVE", "Menu is active and visible to customers"
end
