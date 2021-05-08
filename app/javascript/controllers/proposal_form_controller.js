import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ['proposalFieldsPanel', 'proposalField', 'addOption', 'optionRow']
  static values = { visible: Boolean, field: String, index: Number  }

  connect () {
    console.log('Hello')
  }

  toggleProposalFieldsPanel () {
    this.visibleValue = !this.visibleValue
    this.proposalFieldsPanelTarget.classList.toggle("hidden", !this.visibleValue)
  }

  fetchField(evt) {
    var dataset = evt.currentTarget.dataset
    fetch(`/proposal_forms/${dataset.id}/proposal_fields/new?field_type=${dataset.field}`)
      .then(response => response.text())
      .then(data => {
        this.proposalFieldTarget.innerHTML = data
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
