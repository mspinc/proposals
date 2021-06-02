module InvitesHelper
  def invite_statuses
    Invite.statuses.map { |k, _v| [k.capitalize, k] }
  end

  def invite_responses
    Invite.responses.map { |k, _v| [k.capitalize, k] }
  end
end
