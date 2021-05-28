import { Controller } from "stimulus"

export default class extends Controller {
  
  static targets = ['citizenship', 'otherCitizenship']
  static values = { visible: Boolean }
  
  // toggleCitizenShipField () {
  //   this.visibleValue = !this.visibleValue
  //   this.otherCitizenshipTarget.classList.toggle("hidden", !this.visibleValue)
  // }
  
  handleCitizenship() {
    console.log(this.citizenshipTarget.innerText)
    if (this.citizenshipTarget.innerText === 'Other')
      this.visibleValue = !this.visibleValue
      this.otherCitizenshipTarget.classList.toggle("hidden", !this.visibleValue)
  }
}

