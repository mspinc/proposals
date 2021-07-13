import { Controller } from 'stimulus'

export default class extends Controller {

  static targets = ['target', 'template', 'targetOne', 'templateOne']
  static values = {
    wrapperSelector: String,
    maxOrganizer: Number,
    maxParticipant: Number,
    organizer: Number,
    participant: Number
  }

  initialize () {
    this.wrapperSelector = this.wrapperSelectorValue || '.nested-invites-wrapper'
  }

  addCoOrganizers (e) {
    e.preventDefault()

    let content = this.templateTarget.innerHTML.replace(/NEW_RECORD/g, new Date().getTime().toString())
    if(this.organizerValue < this.maxOrganizerValue) {
      this.targetTarget.insertAdjacentHTML('beforebegin', content)
      this.organizerValue += 1
    }

    else
      toastr.error("You can't add more because the maximum number of Co Organizer invitations has been sent.")
  }

  addParticipants (e) {
    e.preventDefault()

    let contentOne = this.templateOneTarget.innerHTML.replace(/NEW_RECORD/g, new Date().getTime().toString())
    if (this.participantValue < this.maxParticipantValue) {
      this.targetOneTarget.insertAdjacentHTML('beforebegin', contentOne)
      this.participantValue += 1
    }
    else
      toastr.error("You can't add more because the maximum number of Participant invitations has been sent.")
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

  sendInvite ()  {
    event.preventDefault()

    let id = event.currentTarget.dataset.id;
    $.post(`/submit_proposals?proposal=${id}.js`,
      $('form#submit_proposal').serialize(), function(data) {
        $("#exampleModal").modal('show')
    }) 
    .fail(function(response) {
      let errors = response.responseJSON
      $.each(errors, function(index, error) {
        toastr.error(error)
      })
    });
  }
}
