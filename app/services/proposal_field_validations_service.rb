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
      when 'less than (integer matcher)'
        @errors << val.error_message unless @answer.to_i < val.value.to_i
      when 'less than (float matcher)'
        @errors << val.error_message unless @answer.to_f < val.value.to_f
      when 'greater than (integer matcher)'
        @errors << val.error_message unless @answer.to_i > val.value.to_i
      when 'greater than (float matcher)'
        @errors << val.error_message unless @answer.to_f > val.value.to_f
      when 'equal (string matcher)'
        @errors << val.error_message unless @answer == val.value
      when 'equal (integer matcher)'
        @errors << val.error_message unless @answer.to_i == val.value.to_i
      when 'equal (float matcher)'
        @errors << val.error_message unless @answer.to_f == val.value.to_f
      end
    end
  end
end
