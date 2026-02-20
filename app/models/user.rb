class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :owned_rooms, class_name: 'Room', foreign_key: 'user_id', dependent: :destroy
  has_many :room_memberships, dependent: :destroy
  has_many :rooms, through: :room_memberships
  has_many :messages, dependent: :destroy

  validates :email, presence: true, uniqueness: true

  def display_name
    email.split('@').first.capitalize
  end
end
