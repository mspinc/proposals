import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ['proposalFieldsPanel', 'proposalField']
  static values = { visible: Boolean, field: String }

  connect () {
    console.log('Hello')
  }

  toggleProposalFieldsPanel () {
    this.visibleValue = !this.visibleValue
    this.proposalFieldsPanelTarget.classList.toggle("hidden", !this.visibleValue)
  }

  fetchField(evt) {
    var dataset = evt.currentTarget.dataset
    fetch(`/proposal_forms/${dataset.id}/proposal_fields/field_type?field_type=${dataset.field}`)
      .then(response => response.text())
      .then(data => {
        this.proposalFieldTarget.innerHTML = data
      })
  }
}
