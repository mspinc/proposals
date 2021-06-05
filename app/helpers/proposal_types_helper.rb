module ProposalTypesHelper
  def active_form?(id)
    proposal_type = ProposalType.find(id)
    proposal_type.proposal_forms.where(status: :active).present?
  end
end
