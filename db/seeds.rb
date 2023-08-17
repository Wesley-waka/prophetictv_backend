# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
Admin.create([{username:'Wes',email:'wes@gmail.com',password:'Wesleywaka2.',church_id: 1}])

Church.create([{name:'Anglican Church',postalAddress: 'Nairobi'}])