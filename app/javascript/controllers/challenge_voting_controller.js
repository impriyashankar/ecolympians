import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ["button"]

  reloadContent(event) {
    event.preventDefault();
    this.buttonTargets.forEach((button) => {
      button.classList.add("d-none");
    });
  }
}
