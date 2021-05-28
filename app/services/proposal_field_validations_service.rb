class ProposalFieldValidationsService
  attr_reader :proposal, :field

  def initialize(field, proposal)
    @proposal = proposal
    @field = field
    @errors = []
  end

  def validations
    return unless proposal

    @answer = Answer.find_by(proposal_field_id: field.id, proposal_id: proposal.id)&.answer

    check_validations(field.validations)
    @errors
  end

  def check_validations(validations)
    validations.each do |val|
      case val.validation_type
      when 'mandatory'
        @errors << val.error_message if @answer == ""
        @errors << val.error_message unless @answer
      when 'greater'
        @errors << val.error_message unless @answer > val.value
      when 'less'
        @errors << val.error_message unless @answer < val.value
      when 'equal'
        @errors << val.error_message unless @answer == val.value
      when 'include'
        @errors << val.error_message unless @answer.include?(val.value)
      end
    end
  end
end
