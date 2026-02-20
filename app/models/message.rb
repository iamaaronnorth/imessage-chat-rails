class Message < ApplicationRecord
  belongs_to :user
  belongs_to :room

  validates :content, presence: true

  scope :recent, -> { order(:created_at) }

  after_create_commit { broadcast_message }

  private

  def broadcast_message
    broadcast_append_later_to(
      room,
      target: "messages",
      partial: "messages/message",
      locals: { message: self, current_user: user }
    )
  end
end
