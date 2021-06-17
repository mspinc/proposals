import { Controller } from "stimulus"

export default class extends Controller {
  
  static targets = ['citizenship', 'otherCitizenship', 'ethnicity', 'otherEthnicity',
                   'gender', 'otherGender', 'indigenous', 'indigenousYes', 'disability']
  
  handleCitizenshipOptions() {
    if (this.citizenshipTarget.value === 'Other') {
      this.otherCitizenshipTarget.classList.remove("hidden")
    } else {
      this.otherCitizenshipTarget.classList.add("hidden")
    }
  }

  handleEthnicityOptions() {
    if (this.ethnicityTarget.value === 'Other') {
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

  handleDisabilityOptions() {
    if(this.disabilityTarget.value === 'Yes' || this.disabilityTarget.value === 'Prefer') {
      alert('BIRS is committed to providing an experience that is accessible to all attendees. If you would like to discuss accommodations that could enhance your time with BIRS, please contact the BIRS Program Coordinator at birs@birs.ca.')
    }
  }
}

