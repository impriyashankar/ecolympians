import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ["buttons", "votestatus"]

  showUpVoted() {
    this.buttonsTarget.innerHTML = "<h4>You have approved this!</h4>"
    this.buttonsTarget.style.width = "90%"
    this.buttonsTarget.style.justifyContent = "center"
  }

  showDownVoted() {
    this.buttonsTarget.innerHTML = "<h4>You have rejected this!</h4>"
    this.buttonsTarget.style.width = "90%"
    this.buttonsTarget.style.justifyContent = "center"
  }
}
