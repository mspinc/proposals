import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ['proposalType', 'locationSpecificQuestions', 'locationIds']
  static values = { proposalTypeId: Number, proposal: Number }

  connect() {
    this.handleLocationChange(Object.values(this.locationIdsTarget.selectedOptions).map(x => x.value))
  }

  handleLocationChange(locations) {
    if(event && event.type == 'change')
      locations = [...event.target.selectedOptions].map(opt => opt.value)
    fetch(`/proposal_types/${this.proposalTypeIdValue}/location_based_fields?ids=${locations}&proposal_id=${this.proposalValue}`)
      .then(response => response.text())
      .then(html => {
        this.locationSpecificQuestionsTarget.innerHTML = html
      });
    }
}
