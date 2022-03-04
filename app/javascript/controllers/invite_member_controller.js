import { Controller } from "@hotwired/stimulus"

export default class extends Controller {

  static targets = "user"

  connect() {
    console.log("Hello from our first Stimulus controller")
  }

  invite() {
    console.log(this.userTarget)
   // document.querySelector('input').value = this.userTarget.innerHTML

  }
}
