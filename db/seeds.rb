# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Category.create(name: "Drama")
Category.create(name: "Comedy")

Video.create(title: "Monk", description: "It's that show Monk.", small_cover_url: "monk.jpg", large_cover_url: "monk_large.jpg", category_id: 1)
Video.create(title: "South Park", description: "Crazy kids in that Colorado town.", small_cover_url: "south_park.jpg", large_cover_url: "southpark_large.jpg", category_id: 2)
Video.create(title: "Family Guy", description: "Drunk husband abuses family.", small_cover_url: "family_guy.jpg", large_cover_url: "familyguy_large.jpg", category_id: 2)
Video.create(title: "Futurama", description: "Drunk robot's antics, others included.", small_cover_url: "futurama.jpg", large_cover_url: "futurama_large.jpg", category_id: 1)
