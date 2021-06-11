import { Controller } from "stimulus" 

export default class extends Controller {
  static targets = [ 'proposalFieldsPanel', 'proposalField', 'addOption', 'optionRow', 'contentOfButton',
                     'textField', 'proposalId' ]
  static values = { visible: Boolean, field: String }

  toggleProposalFieldsPanel () {
    if( this.contentOfButtonTarget.innerText === 'Back' ){
      this.visibleValue = !this.visibleValue
      this.proposalFieldsPanelTarget.classList.toggle("hidden", !this.visibleValue)
      this.updateText();
    }

    this.visibleValue = !this.visibleValue
    this.proposalFieldsPanelTarget.classList.toggle("hidden", !this.visibleValue)
    var dataset = event.currentTarget.dataset
    if( dataset.field )
      this.updateText()
  }

  handleValidationChange (event) {
    let id = event.currentTarget.id.split('_')[4]
    let node = document.getElementById(`proposal_field_validations_attributes_${id}_value`)
    if(event.currentTarget.value == 'mandatory') {
      node.style.display = 'none'
      node.previousElementSibling.style.display = 'none'
    } else {
      node.parentElement.classList.remove('hidden')
      node.style.display = 'block'
      node.previousElementSibling.style.display = 'block'
    }
  }

  updateText () {
    if( this.contentOfButtonTarget.innerText === 'Add Form Field' )
      this.contentOfButtonTarget.innerText = 'Back'
    else 
      this.contentOfButtonTarget.innerText = 'Add Form Field'
  }

  fetchField(evt) {
    var dataset = evt.currentTarget.dataset
    fetch(`/proposal_types/${dataset.typeId}/proposal_forms/${dataset.id}/proposal_fields/new?field_type=${dataset.field}`)
      .then(response => response.text())
      .then(data => {
        this.proposalFieldTarget.innerHTML = data
      })
  }

  editField(evt) {
    var dataset = evt.currentTarget.dataset
    fetch(`/proposal_types/${dataset.typeId}/proposal_forms/${dataset.proposalFormId}/proposal_fields/${dataset.fieldId}/edit`)
      .then(response => response.text())
      .then(data => {
        this.proposalFieldTarget.innerHTML = data
        let action = document.getElementsByClassName('edit_proposal_field')[0].action.split('?')
        document.getElementsByClassName('edit_proposal_field')[0].action = `proposal_fields/${dataset.fieldId}?${action[1]}`
      })
  }

  latex () {
    let data = event.target.dataset

    for (var i = 0; i < this.textFieldTargets.length; i++) {
      if(this.textFieldTargets[i].dataset.value === data.value) {
        $.post("/proposals/" + data.propid + "/latex",
          { latex: this.textFieldTargets[i].value },
          function(data, status) {
            window.open(`/proposals/rendered_proposal.pdf`)
        });
      }
    }
  }
}
