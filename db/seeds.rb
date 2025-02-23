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

def this_year(month, day)
  Date.today.change(month:, day:).to_s
end

Menu.create([
  { label: 'new_years_day',    state: 'INACTIVE',  start_date: this_year(1, 1),   end_date: this_year(1, 1) },
  { label: 'chinese_new_year', state: 'ACTIVE',    start_date: this_year(1, 31),  end_date: this_year(2, 20) },
  { label: 'good_friday',      state: 'ACTIVE',    start_date: this_year(4, 18),  end_date: this_year(4, 18) },
  { label: 'labour_day',       state: 'ACTIVE',    start_date: this_year(5, 1),   end_date: this_year(5, 1) },
  { label: 'hari_raya_puasa',  state: 'INACTIVE',  start_date: this_year(5, 16),  end_date: this_year(5, 17) },
  { label: 'deepavali',        state: 'ACTIVE',    start_date: this_year(10, 23), end_date: this_year(10, 23) },
  { label: 'christmas',        state: 'INACTIVE',  start_date: this_year(12, 25), end_date: this_year(12, 25) },
  { label: 'national_day',     state: 'ACTIVE',    start_date: this_year(8, 9),   end_date: this_year(8, 9) },
  { label: 'mothers_day',      state: 'INACTIVE',  start_date: this_year(5, 11),  end_date: this_year(5, 11) },
  { label: 'fathers_day',      state: 'ACTIVE',    start_date: this_year(6, 15),  end_date: this_year(6, 15) }
])
