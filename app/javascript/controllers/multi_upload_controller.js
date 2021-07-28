import { Controller } from "stimulus"
import Rails from '@rails/ujs'

export default class extends Controller {
  static targets = [ "files" , "collector" ]

  uploadFile(event) {
    if(event.target.files) {
      var data = new FormData()
      for (let i = 0; i < event.target.files.length; i++) {
        data.append('files[]', event.target.files[i])
      }
      let url = "/proposals/" + event.target.dataset.proposalFormId + "/upload_file"
      Rails.ajax({
        url,
        type: "POST",
        data,
        success: function(data) {
            toastr.success("File/s uploaded.")
        },
        error: function(data) {
            toastr.error("File/s format not supported.")
        }
      })
    }
  }
}
