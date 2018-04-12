# frozen_string_literal: true

class ParticipantPolicy < ApplicationPolicy
  def destroy?
    user.id == record.user_id
  end

  class Scope < Scope
    def resolve
      scope.where(user_id: user.id)
    end
  end
end
