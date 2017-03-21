class Owner < ApplicationRecord
  belongs_to :community
  belongs_to :user

  validates :user_id,
    uniqueness: {
      scope: [:community_id]
    }
end
