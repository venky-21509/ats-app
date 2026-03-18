class CompanyPolicy < ApplicationPolicy
  def index?   = user.admin? || user.staff?
  def show?    = user.admin? || user.staff?
  def create?  = user.admin?
  def update?  = user.admin?
  def destroy? = user.admin?

  class Scope < Scope
    def resolve
      if user.admin?
        scope.all
      elsif user.staff?
        scope.where(id: user.company_id)
      else
        scope.none
      end
    end
  end
end