class SubmitProposalService
  attr_reader :params, :proposal, :proposal_form

  def initialize(proposal, params)
    @proposal = proposal
    @proposal_form = proposal.proposal_type.proposal_forms&.where(status: :active)&.last
    @params = params
    @errors = []
  end

  def save_answers
    ids = proposal_form.proposal_fields.pluck(:id)
    ids.each do |id|
      value = params[id.to_s]

      create_or_update(id, value)
    end
    proposal_locations
    proposal.update(status: :active) if @errors.flatten.count.zero? && params[:commit] == 'Publish'
  end

  def create_or_update(id, value)
    if @errors.flatten.count.zero?
      field = ProposalField.find(id)
      @errors << ProposalFieldValidationsService.new(field, proposal).validations
    end

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
