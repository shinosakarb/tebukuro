class CommunityPolicy < ApplicationPolicy
  def update?
    user.owner?(record)
  end

  def destroy?
    user.owner?(record)
  end
end
