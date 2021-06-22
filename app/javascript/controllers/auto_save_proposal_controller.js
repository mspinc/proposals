import { Controller } from "stimulus"

export default class extends Controller {
  
  connect() {
    let url = window.location.href.split('/').slice(-3)
    this.autoSaveProposal(url);
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

  disconnect() {
    clearInterval(localStorage.getItem('interval'))
    localStorage.removeItem("interval");
  }
}
