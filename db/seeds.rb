# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
# db/seeds.rb
# Create menus
#

pizza_items = {
  items: [
    Item.create!(
      kind: 'product',
      label: 'Margherita Pizza',
      description: 'Margherita pizza with fresh basil, a timeless classic.',
      price: 10.99
    ),
    Item.create!(
      kind: 'product',
      label: 'Currywurst Pizza',
      description: 'Confuse your German, Indian and Italian friends!',
      price: 14.99
    )
  ],
  modifiers: [
    ModifierGroup.create!(
      label: 'Extra toppings?',
      selection_required_min: 0,
      selection_required_max: 3
    ).tap do |modifier_group|
      [
        Modifier.create!(
          modifier_group:,
          display_order: 1,
          item: Item.create!(
            kind: 'component',
            label: 'Extra Cheese',
            description: "Can't go wrong with more cheese!",
            price: 1.5
          )
        ),
        Modifier.create!(
          modifier_group:,
          display_order: 2,
          item: Item.create!(
            kind: 'component',
            label: 'Mala sauce',
            description: "We won't judge!",
            price: 2.5
          )
        )
      ]
    end,
    ModifierGroup.create!(
      label: 'Select size',
      selection_required_min: 1,
      selection_required_max: 1,
    ).tap do |modifier_group|
      [
        Modifier.create!(
          modifier_group:,
          display_order: 1,
          item: Item.create!(
            kind: 'component',
            label: 'Solo',
            description: '9-inch pizza, just for you.',
            price: 0
          )
        ),
        Modifier.create!(
          modifier_group:,
          display_order: 2,
          item: Item.create!(
            kind: 'component',
            label: 'Mega',
            description: '11-inch pizza, perfect for a pair.',
            price: 0
          )
        ),
        Modifier.create!(
          modifier_group:,
          display_order: 3,
          item: Item.create!(
            kind: 'component',
            label: 'Giga',
            description: '13-inch pizza, for a family of four.',
            price: 0
          )
        )
      ]
    end
  ]
}.tap do |config|
  modifier_groups = config[:modifiers]
  items = config[:items]

  modifier_groups.each do |modifier_group|
     items.each do |item|
       ItemModifierGroup.create!(item:, modifier_group:)
     end
  end
end

quaffable_items = {
  items: [
    Item.create!(
      kind: 'product',
      label: 'Soft drink',
      description: 'Just grab a can from our chiller!',
      price: 3.5,
    ),
    Item.create!(
      kind: 'product',
      label: 'Lemonade',
      description: 'Home-brewed lemonade. Hits the spot!',
      price: 8.0,
    ),
    Item.create!(
      kind: 'product',
      label: 'Cherryade',
      description: "Like lemonade, but uses cherry.",
      price: 8.0,
    ),
    Item.create!(
      kind: 'product',
      label: 'Marine Parade',
      description: 'Ask us about our East Coast plans!',
      price: 8.0,
    ),
    Item.create!(
      kind: 'product',
      label: 'Esplanade',
      description: "I'm not going to explain this one.",
      price: 8.0,
    )
  ]
}

Menu.create!(
  label: 'Pizza Menu',
  state: :active,
  start_date: Date.today,
  end_date: Date.today + 30.days,
).tap do |menu|
  sections = [
    {
      label: 'Classic Pizzas',
      description: 'A delightful selection of our handmade pizzas',
      items: pizza_items[:items]
    },
    {
      label: 'Drinks',
      description: 'To wash down the grease!',
      items: quaffable_items[:items]
    }
  ]

  sections.each_with_index do |config, index|
    display_order = index + 1
    label = config[:label]
    description = config[:description]
    items = config[:items]

    Section.create!(label:, description:)
      .tap { |section| MenuSection.create!(menu:, section:, display_order:) }
      .tap do |section|
        items.each_with_index do |item, index|
          display_order = index + 1
          SectionItem.create!(section:, item:, display_order:)
        end
      end
  end
end
