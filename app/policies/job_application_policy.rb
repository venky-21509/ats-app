class JobApplicationPolicy < ApplicationPolicy
  def index?   = user.admin? || user.staff?
  def show?    = user.admin? || user.staff? || record.user == user
  def create?  = user.candidate?
  def update?  = user.admin? || user.staff?
  def destroy? = user.admin? || user.staff?

  class Scope < Scope
    def resolve
      if user.admin? || user.staff?
        scope.all
      else
        scope.where(user: user)  # candidates only see their own applications
      end
    end
  end
end