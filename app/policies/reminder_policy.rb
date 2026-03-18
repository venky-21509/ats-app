class ReminderPolicy < ApplicationPolicy
  def index? = user.admin? || user.staff?
  def show? = user.admin? || user.staff?
  def create? = user.admin? || user.staff?
  def destroy? = user.admin? || record.creator == user

  class Scope < Scope
    def resolve
      if user.admin? || user.staff?
        scope.all
      else
        scope.none
      end
    end
  end
end
