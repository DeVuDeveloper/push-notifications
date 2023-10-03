import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["passwordInput", "toggleIcon"];

  connect() {
    this.passwordStrengthMeter = document.getElementById("password-strength");
    this.passwordStrengthLabel = document.getElementById("password-strength-label");

    this.element.addEventListener("input", this.updatePasswordStrength.bind(this));
  }

  togglePassword() {
    const passwordInput = this.passwordInputTarget;
    const toggleIcon = this.toggleIconTarget;

    if (passwordInput.type === "password") {
      passwordInput.type = "text";
      toggleIcon.classList.remove("fa-lock");
      toggleIcon.classList.add("fa-unlock");
    } else {
      passwordInput.type = "password";
      toggleIcon.classList.remove("fa-unlock");
      toggleIcon.classList.add("fa-lock");
    }
  }

  updatePasswordStrength() {
    const password = this.passwordInputTarget.value;
    const result = zxcvbn(password);

    this.passwordStrengthMeter.value = result.score * 25;

    switch (result.score) {
      case 0:
        this.passwordStrengthLabel.textContent = "Very Weak";
        break;
      case 1:
        this.passwordStrengthLabel.textContent = "Weak";
        break;
      case 2:
        this.passwordStrengthLabel.textContent = "Moderate";
        break;
      case 3:
        this.passwordStrengthLabel.textContent = "Strong";
        break;
      case 4:
        this.passwordStrengthLabel.textContent = "Very Strong";
        break;
      default:
        this.passwordStrengthLabel.textContent = "";
    }
  }
}
