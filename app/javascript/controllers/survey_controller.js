import { Controller } from "stimulus"

export default class extends Controller {
  
  static targets = ['citizenship', 'otherCitizenship', 'ethnicity', 'otherEthnicity',
                   'gender', 'otherGender', 'indigenous', 'indigenousYes']
  
  handleCitizenshipOptions() {
    if (this.citizenshipTarget.value === 'Other') {
      this.otherCitizenshipTarget.classList.remove("hidden")
    } else {
      this.otherCitizenshipTarget.classList.add("hidden")
    }
  }

  handleEthnicityOptions() {
    if (this.ethnicityTarget.value === 'Prefer Other') {
      this.otherEthnicityTarget.classList.remove("hidden")
    } else {
      this.otherEthnicityTarget.classList.add("hidden")
    }
  }

  handleGenderOptions() {
    if (this.genderTarget.value === 'Other') {
      this.otherGenderTarget.classList.remove("hidden")
    } else {
      this.otherGenderTarget.classList.add("hidden")
    }
  }

  handleIndigenousOptions() {
    if (this.indigenousTarget.value === 'Yes') {
      this.indigenousYesTarget.classList.remove("hidden")
    } else {
      this.indigenousYesTarget.classList.add("hidden")
    }
  }
}

