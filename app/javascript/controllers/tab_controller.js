import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ "memberTab", "nextTab", "challengeTab" ]

  connect() {
    let activeTab = localStorage.getItem("activeTab");
    if (activeTab === "memberTab") {

      this.memberTabTarget.click();

    } else if (activeTab === "nextTab") {

      this.nextTabTarget.click();

    } else if (activeTab === "challengeTab") {

      this.challengeTabTarget.click();
    }
  }

  setActiveTab(e) {
    localStorage.setItem("activeTab", e.currentTarget.dataset.tabTarget);
  }

  disconnect() {
    localStorage.removeItem("activeTab");
  }
}
