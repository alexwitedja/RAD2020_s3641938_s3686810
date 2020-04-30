# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

user1 = User.create!(email: "alex@halo.com",
                    mobile: "1234567890",
                    password: "password",
                    password_confirmation: "password",
                    name: "alex")

user1.posts.create!(title: "example post 1",
                  content: "hahahaha",
                  topic: "A.I")

user2 = User.create!(email: "david@halo.com",
                  mobile: "1234567890",
                  password: "password",
                  password_confirmation: "password",
                  name: "david")

user2.posts.create!(title: "example post 3",
                content: "hahahaha",
                topic: "V.R")

user3 = User.create!(email: "baboon@halo.com",
                mobile: "1234567890",
                password: "password",
                password_confirmation: "password",
                name: "baboon")

user3.posts.create!(title: "example post 3",
              content: "hahahaha",
              topic: "Game")
            
user4 = User.create!(email: "tiger@halo.com",
              mobile: "1234567890",
              password: "password",
              password_confirmation: "password",
              name: "tiger")

user4.posts.create!(title: "example post 3",
            content: "hahahaha",
            topic: "Rest")