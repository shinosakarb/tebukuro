class User < ActiveRecord::Base
  # Include default devise modules.
  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :trackable, :validatable,
          :confirmable, :omniauthable
  include DeviseTokenAuth::Concerns::User

  has_many :ticket_subscriptions
  has_many :tickets, through: :ticket_subscriptions

  def purchases(ticket)
    ticket_subscriptions.build(ticket: ticket, quantity: 1)
  end

  def owner?(community)
    community.owners.exists?(user: self)
  end

  def organizer?(event)
    event.organizer_id == id
  end
end
