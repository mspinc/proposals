class SubmitProposalService
  attr_reader :params, :proposal, :proposal_form, :errors

  def initialize(proposal, params)
    @proposal = proposal
    @proposal_form = proposal.proposal_form
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

    proposal.update(status: :active) if able_to_active?
    proposal.active?
  end

  def create_or_update(id, value)
    if @errors.flatten.count.zero?
      field = ProposalField.find(id)
      if field.location_id
        return unless @proposal.locations.include?(field.location)
      end

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

  def able_to_active?
    @errors.flatten.count.zero? && params[:commit] == 'Submit Proposal' && proposal.title.present? && proposal.subject && proposal.ams_subjects.find_by(code: 'code1') && proposal.ams_subjects.find_by(code: 'code2')
  end
end
