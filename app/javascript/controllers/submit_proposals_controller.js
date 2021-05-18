import { Controller } from "stimulus"

export default class extends Controller {
  
  static targets = ['proposalType', 'locationSpecificQuestions', 'locationIds', 'text', 'latexText']
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
  print () {
    let selectedButtonId = event.target.dataset.value
    let _this = this;
    for (var i = 0; i < this.textTargets.length; i++) {
      if(this.textTargets[i].dataset.value === selectedButtonId) {
        let index = i
        fetch(`/proposal_forms/1/proposal_fields/latex_text.pdf`)
        .then(response => response.text())
        .then(html => {
          _this.latexTextTargets[index].innerHTML = html
        });
      }
    }
  }
}
