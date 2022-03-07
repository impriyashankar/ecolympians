import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ["button", "votes"]
  static values = {total: Number}

  reloadContent(event) {
    event.preventDefault();

    this.buttonTargets.forEach((button) => {
      button.classList.add("d-none");
    });

    this.votesTargets.forEach((votes) => {
      votes.classList.remove("d-none");
      votes.innerText = "Voted!";
    });

    setTimeout(() => { location.reload() }, 2000);

  }
}
