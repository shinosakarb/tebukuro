class Participant < ApplicationRecord
  belongs_to :event

  validates :name, presence: true

  def admitted
    event.admitted_participant_ids.include?(id)
  end
end
