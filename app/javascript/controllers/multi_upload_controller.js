import { Controller } from "stimulus"
import Rails from '@rails/ujs'
import toastr from 'toastr'

export default class extends Controller {
  static targets = [ "files" , "collector" ]

  uploadFile(event) {
    if(event.target.files) {
      var data = new FormData()
      for (let i = 0; i < event.target.files.length; i++) {
        var f = event.target.files[`${i}`]
        data.append('files[]', f)
      }
      let url = "/proposals/" + event.target.dataset.proposalFormId + "/upload_file"
      Rails.ajax({
        url,
        type: "POST",
        data,
        success() {
            toastr.success("File/s uploaded.")
        },
        error() {
            toastr.error("File/s format not supported.")
        }
      })
    }
  }
}
