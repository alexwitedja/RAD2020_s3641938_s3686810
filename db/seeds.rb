# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

user = User.create!(email: "alex@halo.com",
            mobile: "1234567890",
            password: "password",
            password_confirmation: "password")

user.posts.create!(title: "example post",
                  content: "hahahaha",
                  topic: "cool stuff")