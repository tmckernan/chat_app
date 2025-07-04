import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="scroll-bottom"
export default class extends Controller {
  connect() {
    this.scroll()
  }

  scroll() {
    this.element.scrollTop = this.element.scrollHeight
  }
}
