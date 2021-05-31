import { Controller } from "stimulus" 

export default class extends Controller {
  static targets = ['proposalFieldsPanel', 'proposalField', 'addOption', 'optionRow', 'contentOfButton']
  static values = { visible: Boolean, field: String, index: Number  }

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

  updateText () {
    if( this.contentOfButtonTarget.innerText === 'Add Form Field' )
      this.contentOfButtonTarget.innerText = 'Back'
    else 
      this.contentOfButtonTarget.innerText = 'Add Form Field'
  }

  fetchField(evt) {
    var dataset = evt.currentTarget.dataset
    fetch(`/proposal_forms/${dataset.id}/proposal_fields/new?field_type=${dataset.field}`)
      .then(response => response.text())
      .then(data => {
        this.proposalFieldTarget.innerHTML = data
      })
  }

  editField(evt) {
    var dataset = evt.currentTarget.dataset
    fetch(`/proposal_forms/${dataset.proposalFormId}/proposal_fields/${dataset.fieldId}/edit`)
      .then(response => response.text())
      .then(data => {
        this.proposalFieldTarget.innerHTML = data
        let action = document.getElementsByClassName('edit_proposal_field')[0].action.split('?')
        document.getElementsByClassName('edit_proposal_field')[0].action = `proposal_fields/${dataset.fieldId}?${action[1]}`
      })
  }

  handleAddOptions (event) {
    this.indexValue += 1
    let clonedOption = this.optionRowTarget.cloneNode(true)
    let child = clonedOption.childNodes[1]
    child.childNodes[1].childNodes[3].name = `proposal_field[options][${this.indexValue}][index]`
    child.childNodes[3].childNodes[3].name = `proposal_field[options][${this.indexValue}][text]`
    child.childNodes[5].childNodes[3].name = `proposal_field[options][${this.indexValue}][value]`
    this.addOptionTarget.append(clonedOption)
    this.clearOptionValues(child)
  }

  clearOptionValues (node) {
    node.childNodes[1].childNodes[3].value = ''
    node.childNodes[3].childNodes[3].value =  ''
    node.childNodes[5].childNodes[3].value = ''
  }

  deleteOption (event) {
    event.currentTarget.parentElement.parentElement.remove()
  }
}
