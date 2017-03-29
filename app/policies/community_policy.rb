class CommunityPolicy < ApplicationPolicy
  def update?
    owner?
  end

  def destroy?
    owner?
  end

  private
  def owner?
    record.owners.exists?(user: user)
  end
end
