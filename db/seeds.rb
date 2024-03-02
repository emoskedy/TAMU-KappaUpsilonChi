# frozen_string_literal: true
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
admin = [
  { email: 'nghilam@tamu.edu', full_name: 'Tran Lam', is_officer: false, is_admin: true },
  { email: 'mikekha109@tamu.edu', full_name: 'Michael Kha', is_officer: false, is_admin: true },
  { email: 'alejandro.muller@tamu.edu', full_name: 'Alex Muller', is_officer: false, is_admin: true },
  { email: 'jerrytran@tamu.edu', full_name: 'Jerry Tran', is_officer: false, is_admin: true},
  # Add more email accounts as needed
]

admin.each do |data|
  Admin.find_or_create_by(email: data[:email]) do |admin|
    admin.full_name = data[:full_name]
    admin.is_officer = data[:is_officer]
    admin.is_admin = data[:is_admin]
    admin.save!
  end
end