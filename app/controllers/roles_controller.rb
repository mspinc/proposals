class RolesController < ApplicationController
  before_action :set_role, only: %i[show]
  def index
    @roles = Role.all
  end

  def show; end

  private

  def set_role
    @role = Role.find(params[:id])
  end
end
