class NotePolicy < ApplicationPolicy
  def index?   = user.admin? || user.staff?
  def show?    = user.admin? || user.staff?
  def create?  = user.admin? || user.staff?
  def destroy? = user.admin? || record.author == user

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
