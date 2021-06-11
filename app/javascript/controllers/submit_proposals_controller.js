import { Controller } from "stimulus"

export default class extends Controller {
  
  static targets = [ 'proposalType', 'locationSpecificQuestions', 'locationIds', 'text', 'tabs' ]
  static values = { proposalTypeId: Number, proposal: Number }
  
  connect() {
    if (this.haslocationIdsTarget) {
      this.handleLocationChange(Object.values(this.locationIdsTarget.selectedOptions).map(x => x.value))
    }
  }

  handleLocationChange(locations) {
    var publish = window.location.href.includes("publish")
    if(event && event.type == 'change')
      locations = [...event.target.selectedOptions].map(opt => opt.value)
    fetch(`/proposal_types/${this.proposalTypeIdValue}/location_based_fields?ids=${locations}&proposal_id=${this.proposalValue},&publish=${publish}`)
      .then(response => response.text())
      .then(html => {
        this.locationSpecificQuestionsTarget.innerHTML = html
      });
  }
  
  nextTab() {
  event.preventDefault();
  let current_tab
  for (var i = 0; i < this.tabsTargets.length; i++) {
    if (this.tabsTargets[i].classList.contains('active')) {
      current_tab = this.tabsTargets[i]
    }
  }
  let next = current_tab.parentElement.nextElementSibling
  if (next) {
    next.firstElementChild.click()
  }
}

  previousTab() {
  event.preventDefault();
  let current_tab
  for (var i = 0; i < this.tabsTargets.length; i++) {
    if (this.tabsTargets[i].classList.contains('active')) {
      current_tab = this.tabsTargets[i]
    }
  }
  let previous = current_tab.parentElement.previousElementSibling
  if (previous) {
    previous.firstElementChild.click()
  }
}
}
