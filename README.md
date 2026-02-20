# iMessage Chat - Rails Application

A modern, real-time chat application built with Rails 8.1.2, featuring an iMessage-style interface with beautiful UI and seamless user experience.

![iMessage Chat Screenshot](https://img.shields.io/badge/Rails-8.1.2-red?style=flat-square&logo=ruby-on-rails)
![PostgreSQL](https://img.shields.io/badge/PostgreSQL-Database-blue?style=flat-square&logo=postgresql)
![Tailwind CSS](https://img.shields.io/badge/TailwindCSS-Styling-38B2AC?style=flat-square&logo=tailwind-css)
![Real-time](https://img.shields.io/badge/Real--time-Messaging-green?style=flat-square)

## 🚀 Features

### 💬 Real-time Chat
- **Instant messaging** with Turbo Streams and Action Cable
- **iMessage-style UI** with blue bubbles for sent messages and white bubbles for received messages
- **Message timestamps** and sender information
- **Auto-scrolling** to latest messages
- **Real-time message delivery** without page refresh

### 👥 User Management  
- **User authentication** with Devise
- **Room membership system** for group chats
- **User display names** extracted from email addresses
- **Room ownership** with creator privileges

### 🏠 Chat Rooms
- **Create and join** multiple chat rooms
- **Room descriptions** and member counts
- **Recent activity** sorting
- **Room-based conversations** with persistent message history

### 🎨 Modern UI/UX
- **iMessage-inspired design** with rounded message bubbles
- **Responsive layout** with sidebar navigation
- **Smooth animations** and transitions  
- **Clean, modern interface** built with Tailwind CSS
- **Mobile-friendly** responsive design

### ⚡ Performance & Real-time
- **Rails 8.1.2** with latest features
- **Solid Cable** for WebSocket connections (Action Cable replacement)
- **PostgreSQL** database for reliability
- **Optimized queries** with includes for N+1 prevention

## 🛠 Technology Stack

- **Backend**: Ruby on Rails 8.1.2
- **Database**: PostgreSQL
- **Authentication**: Devise
- **Styling**: Tailwind CSS v4
- **JavaScript**: Turbo & Stimulus (Hotwire)
- **Real-time**: Turbo Streams + Solid Cable
- **Deployment**: Docker + Kamal ready

## 📋 Prerequisites

Before you begin, ensure you have the following installed:

- **Ruby 3.2.2** (recommended via rbenv)
- **PostgreSQL** (running and accessible)
- **Node.js** (for asset pipeline)
- **Git** (for version control)

## ⚙️ Installation & Setup

### 1. Clone the Repository
```bash
git clone https://github.com/iamaaronnorth/imessage-chat-rails.git
cd imessage-chat-rails
```

### 2. Install Ruby Dependencies
```bash
bundle install
```

### 3. Database Setup
```bash
# Create and setup the database
rails db:create
rails db:migrate

# Load sample data (optional but recommended)
rails db:seed
```

### 4. Build Assets
```bash
# Build Tailwind CSS
rails tailwindcss:build
```

### 5. Start the Server
```bash
# Start the Rails server
rails server

# Or use the dev command (includes Tailwind watching)
bin/dev
```

Visit `http://localhost:3000` to see the application!

## 👤 Sample Users (from seed data)

After running `rails db:seed`, you can sign in with these test accounts:

- **alice@example.com** / `password123`
- **bob@example.com** / `password123`
- **charlie@example.com** / `password123`

Each user has access to sample chat rooms: "General Chat", "Tech Talk", and "Random"

## 🎯 How to Use

### Getting Started
1. **Sign up** for a new account or **sign in** with sample credentials
2. **Browse chat rooms** in the sidebar
3. **Click on a room** to start chatting
4. **Type your message** and press Enter or click Send
5. **Create new rooms** using the form at the top of the sidebar

### Chat Features
- **Send messages**: Type and press Enter for quick sending
- **Real-time delivery**: Messages appear instantly for all users
- **Delete messages**: Click the × button on your own messages
- **View members**: See who's in each chat room
- **Message history**: Scroll up to see older messages

### Creating Rooms
1. Enter a room name in the "New chat room name" field
2. Click "Create" to make the room
3. You'll automatically be added as the room creator
4. Other users can join by being added by existing members

## 🏗 Architecture & Code Structure

### Models
- **User**: Devise-powered authentication with display names
- **Room**: Chat rooms with owners and descriptions  
- **Message**: Individual messages with content and timestamps
- **RoomMembership**: Join table managing user-room relationships

### Controllers
- **RoomsController**: Handles room listing, creation, and chat views
- **MessagesController**: Manages message creation and deletion
- **ApplicationController**: Devise configuration and base functionality

### Real-time Features
- **Turbo Streams**: For instant UI updates
- **Solid Cable**: WebSocket connections (Rails 8's Action Cable replacement)
- **Message broadcasting**: Automatic real-time message delivery
- **Optimistic UI**: Fast, responsive interface updates

### Styling
- **Tailwind CSS v4**: Modern, utility-first CSS framework
- **Custom iMessage styling**: Blue/white message bubbles with tails
- **Responsive design**: Works on desktop and mobile
- **Smooth animations**: CSS transitions for polished feel

## 🔧 Development

### Running Tests
```bash
rails test
```

### Code Quality
```bash
# Run RuboCop for style checking
bundle exec rubocop

# Run Brakeman for security analysis  
bundle exec brakeman

# Run bundle audit for dependency security
bundle audit
```

### Adding Features
The application is structured to easily extend:

1. **New message types**: Extend the Message model
2. **File attachments**: Add Active Storage integration
3. **Push notifications**: Integrate browser notifications
4. **Message reactions**: Add emoji reactions to messages
5. **User profiles**: Extend User model with profile pictures

## 🚀 Deployment

The application includes Docker and Kamal configuration for easy deployment:

### Using Kamal (recommended)
```bash
# Configure your deploy.yml
kamal setup

# Deploy to production
kamal deploy
```

### Using Docker
```bash
# Build the image
docker build -t imessage-chat .

# Run with docker-compose (create docker-compose.yml)
docker-compose up
```

## 📊 Database Schema

```
Users
├── id (primary key)
├── email (string, unique)
├── encrypted_password (string)
└── timestamps

Rooms  
├── id (primary key)
├── name (string)
├── description (text)
├── user_id (foreign key → Users)
└── timestamps

Messages
├── id (primary key) 
├── content (text)
├── user_id (foreign key → Users)
├── room_id (foreign key → Rooms)
└── timestamps

RoomMemberships
├── id (primary key)
├── user_id (foreign key → Users)
├── room_id (foreign key → Rooms)
└── timestamps
```

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## 📝 License

This project is open source and available under the [MIT License](LICENSE).

## 💡 Future Enhancements

Potential features to add:
- [ ] **File uploads** and image sharing
- [ ] **Message reactions** with emojis
- [ ] **User profiles** with avatars
- [ ] **Push notifications** for new messages
- [ ] **Message search** functionality
- [ ] **Private messaging** between users
- [ ] **Message encryption** for security
- [ ] **Voice messages** and video calls
- [ ] **Mobile app** with React Native
- [ ] **Admin panel** for user management

## 📞 Support

If you encounter any issues or have questions:

1. Check the [GitHub Issues](https://github.com/iamaaronnorth/imessage-chat-rails/issues)
2. Create a new issue if your problem isn't already reported
3. Provide detailed information about your environment and the issue

---

**Built with ❤️ using Rails 8.1.2 and modern web technologies**

⭐ Star this repository if you found it helpful!