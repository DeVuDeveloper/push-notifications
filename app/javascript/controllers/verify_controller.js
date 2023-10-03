import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["codeInput"];

  connect() {
    this.codeInputTargets.forEach((input, index) => {
      input.addEventListener("input", (e) => {
        if (e.target.value.length === 1) {
          if (index < this.codeInputTargets.length - 1) {
            this.codeInputTargets[index + 1].focus();
          } else {
            e.target.closest("form").submit();
          }
        }
      });
    });
  }
}