import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ["select"]
  connect(){
    console.log("works right");
  }

  showDesc1(event) {
    const a = event.currentTarget.selectedOptions[0].dataset.challengeType;
    let toolTip=''
    toolTip = "<p>"+a+"</p>"
    this.selectTarget.innerHTML = toolTip

  }
  showDesc2(event) {
    const a = event.currentTarget.selectedOptions[0].dataset.challengeType;
    let toolTip=''
    toolTip = "<p>"+a+"</p>"
    this.selectTarget.innerHTML = toolTip

  }
  showDesc3(event) {
    const a = event.currentTarget.selectedOptions[0].dataset.challengeType;
    let toolTip=''
    toolTip = "<p>"+a+"</p>"
    this.selectTarget.innerHTML = toolTip

  }
}
