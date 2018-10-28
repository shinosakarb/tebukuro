# frozen_string_literal: true

class AttendancePolicy < ApplicationPolicy
  def update?
    user.organizer?(record.event)
  end
end
