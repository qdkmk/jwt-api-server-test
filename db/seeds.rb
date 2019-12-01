# frozen_string_literal: true

User.destroy_all
Task.destroy_all

u = User.new
u.name = 'daisuke.takayama'
u.email = 'test@user.com'
u.password = 'test123'
u.password_confirmation = 'test123'
u.save!

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

#User.destroy_all
#User.create!(
#  name: 'daisuke.takayama',
#  email: 'test@user.com',
#  password: 'test123',
  #password_confirmation: 'test123'
#)
10.times do |i|
  Task.create(
    title: "task No.#{i}",
    description: "This is task No.#{i}",
    completed: false,
    # target_at: DateTime.parse('12/10/2019 8:00'),
    user: u
  )
end
