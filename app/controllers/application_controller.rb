class ApplicationController < ActionController::Base
  before_action :assign_ability

  def assign_ability
    @ability = Ability.new(current_user)
  end
end
