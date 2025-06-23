import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="reset-form"
export default class extends Controller {
  connect() {
  }

  static targets = ["input"]

  reset() {
    this.element.reset()
    const event = new CustomEvent("message:sent", { bubbles: true, cancelable: true });
    this.element.dispatchEvent(event);
  }

  submitOnEnter(event) {
    if (event.key === "Enter" && !event.shiftKey) {
      event.preventDefault(); // Prevent new line
      this.element.requestSubmit(); // Submit the form
    }
  }
}
