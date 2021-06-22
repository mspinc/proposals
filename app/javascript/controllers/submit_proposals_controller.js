import { Controller } from "stimulus"

export default class extends Controller {
  
  static targets = [ 'proposalType', 'locationSpecificQuestions', 'locationIds', 'text', 'tabs' ]
  static values = { proposalTypeId: Number, proposal: Number }
  
  connect() {
    let url = window.location.href.split('/').slice(-3)
    this.autoSaveProposal(url);
    if(this.hasLocationIdsTarget)
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

  SendInvitation (evt) {
    let _this = this 
    let invited_as = evt.currentTarget.id
    let elements = ['firstname', 'lastname', 'email', 'deadline']
    $.each(elements, function(index, el){
      let ele = $('#'+invited_as+'_'+el)
      if(ele.val() == "") {
        if(ele.next().is('span')) return;
        else ele.after($('<span class="field-validation">This is a required field.</span>'))
      }else if (el === "email" && !_this.validateEmail(ele.val())){
        if(ele.next().is('span')) {
          ele.next().remove();
          ele.after($('<span class="field-validation">Invalid Email</span>'));
        }
        else ele.after($('<span class="field-validation">Invalid Email</span>'))
      }else {
        if(ele.next().is('span')) {
          ele.next().remove();
        }
      }
    })
    this.formData(invited_as, evt.currentTarget.dataset.propid)
  }
  validateEmail (email) {
    let re = /^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
    return re.test(email);
  }

  SendInvite (id, firstname, lastname, email, deadline, invited) {
    if(!this.validateEmail(email)) return
    $(`<form action="/proposals/${id}/invites" method="POST" id="send_invite">
      <input type="hidden" name='invite[firstname]' value=${firstname} />
      <input type="hidden" name='invite[lastname]' value=${lastname} />
      <input type="hidden" name='invite[email]' value=${email} />
      <input type="hidden" name='invite[deadline_date]' value=${deadline} />
      <input type="hidden" name='invite[invited_as]' value='${invited}' />
      </form>`).appendTo('body');

    $.post(`/proposals/${id}/invites.js`, $('form#send_invite').serialize(), function(data) {
      if (!data.includes("Save as draft")) {
        $("#email-preview").html(data)
        $("#email-preview").modal('show')
      } else {
        $("#email-preview").html(data)
        setTimeout(function() {
          window.location.reload()
        }, 3000)
      }
    })

    $('#send_invite').remove();
  }

  formData (invited_as, id) {
    let firstname = $(`#${invited_as}_firstname`).val()
    let lastname = $(`#${invited_as}_lastname`).val()
    let email = $(`#${invited_as}_email`).val()
    let deadline = $(`#${invited_as}_deadline`).val()
    let invited = ''
    if(invited_as == 'organizer')
      invited = 'Co Organizer'
    else
      invited =  'Participant'
    if(firstname && lastname && email && deadline) {
      this.SendInvite (id, firstname, lastname, email, deadline, invited)
    }
  }

  autoSaveProposal (url) {
    var interval;
    if(url.includes('proposals') && url.includes('edit')) {
      let id = url[1]
      interval =  setInterval(function() {
        $.post(`/submit_proposals?proposal=${id}`,
          $('form#submit_proposal').serialize(), function(data) {
          console.log('auto saving...')
        })  
      }, 10000);
      localStorage.setItem('interval', interval)
    } else {
      clearInterval(localStorage.getItem('interval'))
      localStorage.removeItem("interval");
    }
  }
}
