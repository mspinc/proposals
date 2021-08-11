import { Controller } from "stimulus"
import Rails from '@rails/ujs'

export default class extends Controller {

  editFlow() {
    var array = [];
    $("input:checked").each(function() {
      array.push(this.dataset.value);
    });
    let data = new FormData()
    data.append("ids", array)
    var url = `/submitted_proposals/edit_flow`
    Rails.ajax({
      url,
      type: "POST",
      data
    })
  }
}
