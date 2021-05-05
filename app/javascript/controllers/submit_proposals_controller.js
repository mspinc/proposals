import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ['locationId', 'proposalTypes', 'locationSpecificQuestions', 'typeSpecificQuestions']

  connect() {
    this.handlProposalTypeChange()
  }

  handleLocationChange() {
    if(this.proposalTypesTarget.value) {
      let locations = [...event.target.selectedOptions].map(opt => opt.value)
      fetch(`/proposal_types/${this.proposalTypesTarget.value}/location_based_fields?ids=${locations}`)
        .then(response => response.text())
        .then(html => {
          this.locationSpecificQuestionsTarget.innerHTML = html
        });
    }
  }

  handlProposalTypeChange() {
    if(this.proposalTypesTarget.value) {
      fetch(`/proposal_types/${this.proposalTypesTarget.value}.html`)
        .then(response => response.text())
        .then(html => {
          this.typeSpecificQuestionsTarget.innerHTML = html
        });
    }
  }
}
