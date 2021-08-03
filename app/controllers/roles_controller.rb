class RolesController < ApplicationController
  before_action :set_role, only: %i[show]

  def index
    @roles = Role.all
  end

  def new
    @role = Role.new
    @role.role_privileges.build
  end

  def create
    @role = Role.new(role_params)
    params[:role_privileges].each_value do |role|
      @privilege = @role.role_privileges.new(privilege_params(role))
    end
    if @role.save
      redirect_to roles_path, notice: "Created a new
                              #{@role.name} role!".squish
    else
      redirect_to new_role_path, alert: @role.errors
    end
  end

  def show; end

  private

  def set_role
    @role = Role.find(params[:id])
  end

  def role_params
    params.require(:role).permit(:name)
  end

  def privilege_params(role)
    role.permit(:permission_type, :privilege_name)
  end
end
