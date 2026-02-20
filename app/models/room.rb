class Room < ApplicationRecord
  belongs_to :user
  has_many :room_memberships, dependent: :destroy
  has_many :members, through: :room_memberships, source: :user
  has_many :messages, dependent: :destroy

  validates :name, presence: true
  
  scope :recent, -> { order(updated_at: :desc) }

  def last_message
    messages.order(:created_at).last
  end

  def last_message_time
    last_message&.created_at
  end
end
