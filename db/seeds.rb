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

post1 = user1.posts.create!(title: "example post 1",
                  content: "hahahaha",
                  topic: "A.I")

user2 = User.create!(email: "david@halo.com",
                  mobile: "1234567890",
                  password: "password",
                  password_confirmation: "password",
                  name: "david")

post2 = user2.posts.create!(title: "example post 2",
                content: "hahahaha",
                topic: "V.R")

user3 = User.create!(email: "baboon@halo.com",
                mobile: "1234567890",
                password: "password",
                password_confirmation: "password",
                name: "baboon")

post3 = user3.posts.create!(title: "example post 3",
              content: "hahahaha",
              topic: "Game")
            
user4 = User.create!(email: "tiger@halo.com",
              mobile: "1234567890",
              password: "password",
              password_confirmation: "password",
              name: "tiger")

post4 = user4.posts.create!(title: "example post 4",
            content: "hahahaha",
            topic: "Rest")

post4.comments.create!(content: "Hi I am baboon",
                        user_id: user3.id)

post3.comments.create!(content: "Hi I am tiger",
                        user_id: user4.id)

post2.comments.create!(content: "Hi I am alex",
                        user_id: user1.id)

post1.comments.create!(content: "Hi I am david",
                        user_id: user2.id)