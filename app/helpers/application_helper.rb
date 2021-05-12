module ApplicationHelper
  def active_menu(target_path)
    return 'active' if request.path == target_path

    ''
  end

  def dashboard_menu
    return 'show' if request.path.in?(['/proposal_types', '/locations', '/proposal_forms'])
  end

  def dashboard_list
    return 'active' if request.path.in?(['/proposal_types', '/locations', '/proposal_forms'])
  end

  def proposal_menu
    return 'show' if request.path.in?(['/proposal_forms/new', '/submit_proposals/new'])
  end

  def proposal_list
    return 'active' if request.path.in?(['/proposal_forms/new', '/submit_proposals/new'])
  end

  def pages_menu
    return 'show' if request.path.in?(['/guidelines'])
  end

  def pages_list
    return 'active' if request.path.in?(['/guidelines'])
  end
end
