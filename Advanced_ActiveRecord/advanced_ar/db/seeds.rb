# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Person.destroy_all

# create with ! will tell you if it failed as opposed to regular create
Person.create! [
                   {first_name: "Kalman", last_name: "Smith", age: 33},
                   {first_name: "John", last_name: "Whatever", age: 27},
                   {first_name: "Michael", last_name: "Smith", age: 15},
                   {first_name: "Josh", last_name: "Oreck", age: 57},
                   {first_name: "John", last_name: "Smith", age: 27},
                   {first_name: "Bill", last_name: "Gates", age: 75},
                   {first_name: "LeBron", last_name: "James", age: 30}
               ]
