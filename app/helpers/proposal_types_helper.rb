module ProposalTypesHelper
  def active_or_draft_form?(id)
    proposal_type = ProposalType.find(id)
    proposal_type.proposal_forms.where(status: [:active, :draft]).present?
  end
end
