import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ['locationId', 'proposalTypes', 'locationSpecificQuestions', 'typeSpecificQuestions']

  connect() {
    this.handlProposalTypeChange()
    this.fetchProposalTypeLocations()
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
          this.fetchProposalTypeLocations()
        });
    }
  }

  fetchProposalTypeLocations () {
    if(this.proposalTypesTarget.value) {
      fetch(`/proposal_types/${this.proposalTypesTarget.value}/proposal_type_locations.json`)
        .then(res => res.json())
        .then(data => {
          const selectBox = this.locationIdTarget;
          var _this = this
          selectBox.innerHTML = '';
          data.forEach(item => {
            const opt = document.createElement('option');
            opt.value = item.id;
            opt.innerHTML = item.name;
            selectBox.appendChild(opt);
          });
        })
    }
  }
}
