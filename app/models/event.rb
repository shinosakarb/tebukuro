class Event < ApplicationRecord
  belongs_to :community

  validates :name, presence: true
  validates :description, presence: true
  validates :invitation_starts_at, presence:true
  validates :invitation_ends_at, presence:true
  validates :event_starts_at, presence:true
  validates :event_ends_at, presence:true
  validates :number_of_accepted_participants, presence: true
  validates :cost, presence: true

<<<<<<< HEAD
<<<<<<< HEAD
=======
=begin

  # TODO: date_validatorのgemを使うなら以下が有効になる

  validates :invitation_starts_at, presence: true, date:{
      after_or_equal_to: Date.today.to_time,
      allow_blank: false
  }

  validates :invitation_ends_at, presence: true, date:{
      after: :invitation_started_at,
      allow_blank: true
  }

  validates :event_starts_at, presence: true, date:{
      after: :invitation_ended_at,
      allow_blank:false
  }

  validates :event_ends_at, presence: true, date:{
      after: event_started_at,
      allow_blank:false
  }

=end

>>>>>>> e9aec92... ADD event_detail_information
=======
>>>>>>> 1c72a1e... FIX add event_detail_information
end
