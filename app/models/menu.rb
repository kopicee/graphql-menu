class Menu < ApplicationRecord
  has_many :menu_sections
  has_many :sections, through: :menu_sections

  enum :state, unapproved: "unapproved", active: "active", inactive: "inactive"
end
