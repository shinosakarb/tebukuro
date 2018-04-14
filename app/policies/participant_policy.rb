# frozen_string_literal: true

class ParticipantPolicy < ApplicationPolicy
  def destroy?
    user.id == record.user_id
  end

  class Scope < Scope
    def resolve(query = {})
      scope.find_by(query.merge(user_id: user.id))
    end
  end
end
