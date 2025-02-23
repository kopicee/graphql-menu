class Types::MenuState < Types::BaseEnum
  value "unapproved", "Menu has been defined but not activated", value: "unapproved"
  value "inactive", "Menu has been approved but not yet visible to customers", value: "inactive"
  value "active", "Menu is active and visible to customers", value: "active"
end
