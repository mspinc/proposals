module ProposalFormsHelper
  def proposal_form_statuses
    ProposalForm.statuses.map { |k, _v| [k.capitalize, k] }
  end

  def validation_types
  	Validation.validation_types.map { |k,_v| [k.capitalize, k]  }
  end

  def proposal_type_name(id)
  	 ProposalType.find_by(id: id)&.name
  end
end
