import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ["select1", "select2", "select3"]
  connect(){
    console.log("works right");
  }

  showDesc1(event) {
    const a = event.currentTarget.selectedOptions[0].dataset.challengeType;
    let toolTip=''
    toolTip = "<p>"+a+"</p>"
    this.select1Target.innerHTML = toolTip

  }
  showDesc2(event) {
    const a = event.currentTarget.selectedOptions[0].dataset.challengeType;
    let toolTip=''
    toolTip = "<p>"+a+"</p>"
    this.select2Target.innerHTML = toolTip

  }
  showDesc3(event) {
    const a = event.currentTarget.selectedOptions[0].dataset.challengeType;
    let toolTip=''
    toolTip = "<p>"+a+"</p>"
    this.select3Target.innerHTML = toolTip

  }
}
