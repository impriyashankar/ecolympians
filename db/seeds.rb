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
ProofVote.destroy_all

# create users

puts "Creating 15 users...\n"

photos = ['avatar1.jpg', 'avatar2.jpg', 'avatar3.jpg', 'avatar4.jpg', 'avatar5.jpg', 'avatar6.jpg']
users = 15.times.each_with_object([]) do |index, arr|
  arr << user = User.create!(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    email: "user#{index + 1}@gmail.com",
    password: "123456",
    password_confirmation: "123456"
  )



  photo = photos.sample

  user.photo.attach(
    io: File.open("app/assets/images/#{photo}"),
    filename: photo,
    content_type: "image/jpg"
  )

  user.save

  puts "User ##{index + 1}"
  puts "Email: user#{index + 1}@gmail.com"
  puts "Password: 123456"
  puts ""
end

 # Creating ecolympians users

 user = User.create!(first_name: "Daan", last_name: "Moens", email: "daan@gmail.com", password: "123456", password_confirmation: "123456")
user.photo.attach(
  io: File.open("app/assets/images/Daan.jpeg"),
  filename: "Daan",
  content_type: "image/jpeg"
)
user.save

user = User.create!(first_name: "Ofer", last_name: "Peled", email: "ofer@gmail.com", password: "123456", password_confirmation: "123456")
user.photo.attach(
  io: File.open("app/assets/images/Ofer.jpeg"),
  filename: "Ofer",
  content_type: "image/jpeg"
)
user.save

user = User.create!(first_name: "Linh", last_name: "Trieu", email: "linh@gmail.com", password: "123456", password_confirmation: "123456")
user.photo.attach(
  io: File.open("app/assets/images/Linh.JPG"),
  filename: "Linh",
  content_type: "image/JPG"
)
user.save

user = User.create!(first_name: "Priya", last_name: "Shankar", email: "priya@gmail.com", password: "123456", password_confirmation: "123456")
user.photo.attach(
  io: File.open("app/assets/images/Priya.jpeg"),
  filename: "Priya",
  content_type: "image/jpeg"
)
user.save


# create groups

puts "Creating 5 groups...\n"
puts ""

5.times do
  Group.create!(
    name: "The #{Faker::Hipster.word.capitalize}s"
  )

  puts "Created group named #{Group.last.name}"
end
# New group with our team
Group.create!(
  name: "OG Ecolympians"
)
puts "Created group named #{Group.last.name}"

our_group = Group.find_by(name: "OG Ecolympians")
user_daan = User.find_by(first_name: "Daan")

# create memberships

# Ecolympians group membership

Membership.create!(
  status: "Accepted",
  role: "Admin",
  user: user_daan,
  group: our_group
)

ecolympians_users = User.where(first_name: ["Priya", "Linh", "Ofer"])
ecolympians_users.each do |user|
  Membership.create!(
    status: "Accepted",
    role: "Member",
    user: user,
    group: our_group
  )
end

puts ""
puts "Assigning group memberships....\n"
puts ""

Group.where.not(name: "OG Ecolympians").each do |group|
#Group.all.each do |group|
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

counter = -15

Group.all.each do |group|
  challenge = Challenge.all.sample

  group.memberships.each do |member|
    group_challenge = GroupChallenge.create!(
      challenge: challenge,
      membership: member,
      start_date: Date.today + counter,
      status: "waiting"
    )

    if group_challenge.start_date <= (Date.today - 7)
      group_challenge.status = "finished"
    elsif group_challenge.start_date > (Date.today - 7) && group_challenge.start_date <= Date.today
      group_challenge.status = "ongoing"
    else
      group_challenge.status = "waiting"
    end

    unless group_challenge.status == "waiting"
      file = URI.open('https://source.unsplash.com/300x300/?earth')
      group_challenge.photo.attach(
        io: file,
        filename: "proof_#{group_challenge.id}.jpg",
        content_type: "image/jpg"
      )

      group_challenge.comment = "Here is a little comment about my proof!"
    end

    if group_challenge.status == "finished"
      group.memberships.excluding(member).each do |voting_member|
        ProofVote.create!(
          user: voting_member.user,
          group_challenge: group_challenge,
          vote: [1, 2].sample == 1
        )
      end
      if group_challenge.proof_votes.select{ |proofvote| proofvote.vote == true }.count >= group_challenge.proof_votes.select{ |proofvote| proofvote.vote == false}.count
        group_challenge.membership.score += group_challenge.challenge.score
        group_challenge.membership.save!
      end

    end

    group_challenge.save!
  end
  counter += 5
  puts "#{group.name} will do the #{GroupChallenge.last.challenge.name} challenge, which starts at #{GroupChallenge.last.start_date} (#{GroupChallenge.last.status})"
end

#group challenges for ecolympians

finished_challenge = Challenge.find_by(name: "Tree Titans")
ongoing_challenge = Challenge.find_by(name: "Trash Trasher")

#finished challenge
i = 0
finished_comments = [
  "Planted a tree in Amsterdam!",
  "Look at my beautiful tree",
  "This one's gonna grow 100 years old",
  "Planted with the FreeTree organisation"
]

ongoing_comments = [
  "OMG this city is so dirrty, look how much trash I picked up!",
  "Feeling refreshed after making this place a little bit cleaner."
]

our_group.memberships.each do |member|
  i += 1
  finished_group_challenge = GroupChallenge.create!(
    challenge: finished_challenge,
    membership: member,
    start_date: Date.today - 16,
    status: "finished",
    comment: finished_comments[i - 1]
  )

  finished_group_challenge.photo.attach(
    io: File.open("app/assets/images/Tree_titans_#{i}.jpeg"),
    filename: "Tree_titans_#{i}",
    content_type: "image/jpeg"
  )

  user = member.user
  users = our_group.memberships.excluding(member).map { |item| item.user }
  users.each do |u|
    proof_v = ProofVote.new(
      vote: [true, false].sample
    )
    proof_v.user = u
    proof_v.group_challenge = finished_group_challenge
    proof_v.save!
  end

  if finished_group_challenge.proof_votes.select{ |proofvote| proofvote.vote == true }.count >= finished_group_challenge.proof_votes.select{ |proofvote| proofvote.vote == false}.count
    finished_group_challenge.membership.score += finished_group_challenge.challenge.score
    finished_group_challenge.membership.save!
  end


  #ongoing challenge
  ongoing_group_challenge = GroupChallenge.create!(
    challenge: ongoing_challenge,
    membership: member,
    start_date: Date.today - 6,
    status: "ongoing"

  )

  if i == 3
    photo_suffix = "accepted"
  else
    photo_suffix = "rejected"
  end

  unless i < 3
    ongoing_group_challenge.photo.attach(
      io: File.open("app/assets/images/Trash_trasher_#{photo_suffix}.jpeg"),
      filename: "Trash_trasher_#{photo_suffix}",
      content_type: "image/jpeg"
    )
    ongoing_group_challenge.comment = ongoing_comments[i - 3]
  end

  finished_group_challenge.save!
  ongoing_group_challenge.save!
end
