import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ['proposalType', 'locationSpecificQuestions']

  handleLocationChange() {
    var id = event.currentTarget.dataset.proposalType
    let locations = [...event.target.selectedOptions].map(opt => opt.value)
    fetch(`/proposal_types/${id}/location_based_fields?ids=${locations}`)
      .then(response => response.text())
      .then(html => {
        this.locationSpecificQuestionsTarget.innerHTML = html
      });
    }
}
