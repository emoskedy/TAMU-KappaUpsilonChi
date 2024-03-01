# frozen_string_literal: true
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
admin_emails = [
  { email: 'nghilam@tamu.edu', full_name: 'Tran Lam', role: "admin" },
  { email: 'mikekha109@tamu.edu', full_name: 'Michael Kha', role: "admin" },
  { email: 'alejandro.muller@tamu.edu', full_name: 'Alex Muller', role: "admin" },
  { email: 'jerrytran@tamu.edu', full_name: 'Jerry Tran', role: "admin"},
  # Add more email accounts as needed
]

admin_emails.each do |data|
  Admin.find_or_create_by(email: data[:email]) do |admin|
    admin.full_name = data[:full_name]
    admin.role = data[:role]
    admin.save!
  end
end