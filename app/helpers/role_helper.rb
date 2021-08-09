module RoleHelper
  def user_role(role)
    users = User.all
    user = role.users.ids
    user&.each do |id|
      users = users.where.not(id: id)
    end
    users
  end
end
