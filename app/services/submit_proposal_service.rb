class SubmitProposalService
  attr_reader :params, :proposal, :proposal_form

  def initialize(proposal, params)
    @proposal = proposal
    @proposal_form = ProposalForm.active_form(proposal.proposal_type.id)
    @params = params
  end

  def save_answers    
    ids = proposal_form.proposal_fields.pluck(:id)
    ids.each do |id|
      value = params[id.to_s]
      next if value.blank?

      create_or_update(id, value)
    end
    proposal_locations
    proposal.update(status: :active) if params[:commit] == 'Publish'
  end

  def create_or_update(id, value)
    answer = Answer.find_by(proposal_field_id: id, proposal: proposal)
    if answer
      answer.update(answer: value)
    else
      Answer.create(answer: value, proposal: proposal, proposal_field_id: id)
    end
  end

  def proposal_locations
    proposal.locations = Location.where(id: params[:location_ids])
  end
end
