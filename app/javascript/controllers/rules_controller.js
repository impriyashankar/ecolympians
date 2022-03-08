import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ["button"]

  connect() {
    const showRules = document.querySelector(".show-rules")
    if (showRules) {
      if (showRules.innerText === "true") {
        this.buttonTarget.click()
      }
    }
  }
}
