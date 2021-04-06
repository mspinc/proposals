import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ['locationId', 'proposalTypes', 'form']

  connect() {
    this.locationIdTarget.options[0].disabled = true
  }

  handleLocationChange() {
    fetch(`/locations/${this.locationIdTarget.value}/proposal_types.json`)
      .then(response => response.json())
      .then(data => {
        this.proposalTypesTarget.selected = data[0].id
        this.proposalTypesTarget.disabled = false
        const selectBox = this.proposalTypesTarget;
        var _this = this
        selectBox.innerHTML = '';
        data.forEach(item => {
          const opt = document.createElement('option');
          opt.value = item.id;
          opt.innerHTML = item.name;
          selectBox.appendChild(opt);
        });
        this.handlProposalTypeChange();
      });
  }

  handlProposalTypeChange() {
    fetch(`/proposal_types/${this.proposalTypesTarget.value}.html`)
      .then(response => response.text())
      .then(html => {
        this.formTarget.innerHTML = html
      });
  }
}
