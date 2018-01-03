class Participant < ApplicationRecord
  belongs_to :event

  validates :name, presence: true

  def admitted
    event.admitted_participant?(id)
  end
end
