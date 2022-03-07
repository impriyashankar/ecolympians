# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'faker'
require 'open-uri'
require 'csv'

# destroy all instances

Group.destroy_all
Membership.destroy_all
User.destroy_all
Challenge.destroy_all
GroupChallenge.destroy_all

# create users

puts "Creating 15 users...\n"

users = 15.times.each_with_object([]) do |index, arr|
  arr << user = User.create!(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    email: "user#{index + 1}@gmail.com",
    password: "123456",
    password_confirmation: "123456"
  )

  user.photo.attach(
    io: File.open("app/assets/images/empty_account.png"),
    filename: "empty_account.png",
    content_type: "image/png"
  )

  user.save

  puts "User ##{index + 1}"
  puts "Email: user#{index + 1}@gmail.com"
  puts "Password: 123456"
  puts ""
end

# create groups

puts "Creating 5 groups...\n"
puts ""

5.times do
  Group.create!(
    name: "The #{Faker::Hipster.word.capitalize}s"
  )

  puts "Created group named #{Group.last.name}"
end

# create memberships
puts ""
puts "Assigning group memberships....\n"
puts ""

Group.all.each do |group|
  group_users = users.sample(6) # sample of 6 users

  # create a group leader from first user in sample
  Membership.create!(
    status: "Accepted",
    role: "Admin",
    user: group_users.first,
    group: group
  )

  # create members of the group with the rest of the user sample
  group_users.last(5).each do |user|
    Membership.create!(
      status: "Accepted",
      role: "Member",
      user: user,
      group: group
    )
  end

  puts "#{group.name} has the following members:"
  puts "#{group_users.first.first_name} (Admin)"
  group_users.last(5).each do |member|
    puts member.first_name
  end

  puts ""
end

# create challenges
puts "Creating the challenges...\n"
puts ""

challenges_file = File.read("lib/seeds/challenges.csv")
challenges = CSV.parse(challenges_file, headers: true)

challenges.each do |challenge|
  Challenge.create!(
    name: challenge['name'],
    description: challenge['description'],
    score: challenge['score'],
    category: challenge['category']
  )

  puts "#{challenge['name']} challenge created"
end

# create group challenges

puts ""
puts "Assigning challenges to groups.."
puts ""

counter = -5

Group.all.each do |group|
  challenge = Challenge.all.sample

  group.memberships.each do |member|
    group_challenge = GroupChallenge.create!(
      challenge: challenge,
      membership: member,
      start_date: Date.today + counter,
      status: "waiting"
    )

    group_challenge.status = "ongoing" if group_challenge.start_date <= Date.today

    if group_challenge.status == "ongoing"
      file = URI.open('https://source.unsplash.com/300x300/?earth')
      group_challenge.photo.attach(
        io: file,
        filename: "proof_#{group_challenge.id}.jpg",
        content_type: "image/jpg"
      )

      group_challenge.comment = "Here is a little comment about my proof!"
    end

    group_challenge.save!
  end
  counter += 3
  puts "#{group.name} will do the #{GroupChallenge.last.challenge.name} challenge, which starts at #{GroupChallenge.last.start_date}"
end

puts ""
