# Clear existing data
RoomMembership.delete_all
Message.delete_all
Room.delete_all
User.delete_all

puts "Creating sample users..."

# Create sample users
alice = User.create!(
  email: 'alice@example.com',
  password: 'password123'
)

bob = User.create!(
  email: 'bob@example.com',
  password: 'password123'
)

charlie = User.create!(
  email: 'charlie@example.com',
  password: 'password123'
)

puts "Creating sample chat rooms..."

# Create sample rooms
general_room = Room.create!(
  name: 'General Chat',
  description: 'A place for general discussion',
  user: alice
)

tech_room = Room.create!(
  name: 'Tech Talk',
  description: 'Discussing the latest in technology',
  user: bob
)

random_room = Room.create!(
  name: 'Random',
  description: 'Random conversations and fun',
  user: charlie
)

puts "Adding users to rooms..."

# Add users to rooms
[alice, bob, charlie].each do |user|
  [general_room, tech_room, random_room].each do |room|
    RoomMembership.create!(user: user, room: room)
  end
end

puts "Creating sample messages..."

# Create sample messages
sample_messages = [
  { room: general_room, user: alice, content: "Hey everyone! Welcome to the general chat 👋" },
  { room: general_room, user: bob, content: "Thanks Alice! Great to be here." },
  { room: general_room, user: charlie, content: "This chat app looks amazing!" },
  { room: general_room, user: alice, content: "I know right? It's got that iMessage feel to it." },
  
  { room: tech_room, user: bob, content: "What do you all think about Rails 8?" },
  { room: tech_room, user: alice, content: "I love the new Solid libraries! So much cleaner than Redis." },
  { room: tech_room, user: charlie, content: "The built-in authentication is pretty sweet too" },
  { room: tech_room, user: bob, content: "Agreed! And Action Cable integration is seamless." },
  
  { room: random_room, user: charlie, content: "Anyone seen any good movies lately?" },
  { room: random_room, user: alice, content: "Just watched Dune Part 2 - absolutely incredible!" },
  { room: random_room, user: bob, content: "Oh nice! I've been meaning to watch that." },
  { room: random_room, user: charlie, content: "You should! The visuals are stunning 🎬" }
]

sample_messages.each_with_index do |msg_data, index|
  message = Message.create!(
    room: msg_data[:room],
    user: msg_data[:user],
    content: msg_data[:content]
  )
  
  # Update message timestamps to make them look realistic
  message.update_column(:created_at, index.minutes.ago)
end

puts "Seed data created successfully!"
puts "Sample users:"
puts "  alice@example.com (password: password123)"
puts "  bob@example.com (password: password123)"
puts "  charlie@example.com (password: password123)"
puts ""
puts "Sample rooms: General Chat, Tech Talk, Random"