
require_relative '../lib/stdout_helpers'
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

NUM_OF_USERS = 20
NUM_OF_IDEAS = 100
NUM_OF_REVIEWS = 3

PASSWORD = 'supersecret'

Like.destroy_all()
Review.destroy_all()
Idea.destroy_all()
User.destroy_all()
Join.destroy_all()

super_user = User.create(
  first_name: 'jon',
  last_name: 'snow',
  email: 'js@winterfell.gov',
  password: PASSWORD,
  admin: true
)

NUM_OF_USERS.times do |x|
  u = User.create({
    first_name: Faker::Games::SuperSmashBros.fighter,
    last_name: Faker::Name.last_name,
    email: Faker::Internet.email,
    password: PASSWORD
  })
  Stdout.progress_bar(NUM_OF_USERS, x, "█") { "Creating Users" }
end

users = User.all

a = 1
  NUM_OF_IDEAS.times do |x|
    created_at = Faker::Date.backward(days: 365)
    a += 1 
    idea = Idea.create({
      title: Faker::Hipster.sentence + a.to_s,
      description: Faker::Hipster.paragraph,
      user: users.sample,
      created_at: created_at,
      updated_at: created_at
    })
    if idea.valid?
      rand(0..10).times.each do
        Like.create(
          user: users.sample,
          idea: idea
        )
      end
    if idea.valid?
      rand(0..10).to_i.times.each do
        Join.create(
          user: users.sample,
          idea: idea
        )
    end
  end
end

  NUM_OF_REVIEWS.times do
    Review.create({
      rating: rand(1..5),
      body: Faker::Hacker.say_something_smart,
      idea: idea,
      user: users.sample
    })
  end
  Stdout.progress_bar(NUM_OF_IDEAS, x, "█") { "Creating Ideas with Reviews" }
end



ideas = Idea.all
reviews = Review.all
likes = Like.all
joins = Join.all


puts Cowsay.say("Created #{ideas.count} ideas with #{NUM_OF_REVIEWS} reviews each!", :stimpy)
puts Cowsay.say("Created #{users.count}  users!", :turkey)
puts Cowsay.say("Generated #{likes.count} likes!", :turtle)
puts Cowsay.say("Generated #{joins.count} joins!", :ren)