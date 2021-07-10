import { Controller } from 'stimulus'

export default class extends Controller {

  static targets = ['target', 'template', 'targetOne', 'templateOne', 'firstForm', 'formParticipant']
  static values = {
    wrapperSelector: String
  }

  initialize () {
    this.wrapperSelector = this.wrapperSelectorValue || '.nested-invites-wrapper'
    this.firstFormTarget.innerHTML = this.firstFormTarget.innerHTML.replace(/NEW_RECORD/g, new Date().getTime().toString())
    this.formParticipantTarget.innerHTML = this.formParticipantTarget.innerHTML.replace(/NEW_RECORD/g, new Date().getTime().toString())
  }

  addCoOrganizers (e) {
    e.preventDefault()
    
    let content = this.templateTarget.innerHTML.replace(/NEW_RECORD/g, new Date().getTime().toString())
    this.targetTarget.insertAdjacentHTML('beforebegin', content)
  }

  addParticipants (e) {
    e.preventDefault()

    let contentOne = this.templateOneTarget.innerHTML.replace(/NEW_RECORD/g, new Date().getTime().toString())
    this.targetOneTarget.insertAdjacentHTML('beforebegin', contentOne)
  }

  remove (e) {
    e.preventDefault()

    let wrapper = e.target.closest(this.wrapperSelector)
    if (wrapper.dataset.newRecord === 'true') {
      wrapper.remove()
    } else {
      wrapper.style.display = 'none'

      let input = wrapper.querySelector("input[name*='_destroy']")
      input.value = '1'
    }
  }
}
