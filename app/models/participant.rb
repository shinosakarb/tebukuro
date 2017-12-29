class Participant < ApplicationRecord
  belongs_to :event

  validates :name, presence: true

  def admitted
    event.participants.take(event.quota).include?(self)
  end
end
