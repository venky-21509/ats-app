class JobPolicy < ApplicationPolicy
 
  def index? = true
  def show? = true
  def create? =user.admin? || user.staff?
  def update? = user.admin? || user.staff?
  def destroy? = user.admin?

  class Scope < Scope
    def resolve
      if user.admin? || user.staff?
        scope.all
      else
        scope.where(status: :open)
      end
    end
    
  end
end
