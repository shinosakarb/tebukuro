class EventPolicy < ApplicationPolicy
  def create?
    user.owner?(record.community)
  end

  def update?
    user.owner?(record.community)
  end

  def destroy?
    user.owner?(record.community)
  end
end
