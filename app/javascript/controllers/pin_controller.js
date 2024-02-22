import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="pin"
export default class extends Controller {
  // submit_and_get_pin() {
  // }

  static targets = ["details"];

  submit_and_get_pin() {
    clearTimeout(this.timeout);
    let form = this.element;

    fetch(form.action, {
      method: form.method,
      body: new FormData(form),
    })
      .then((response) => response.json())
      .then((data) => {
        if (data) {
          this.displayDetails(data);
        } else {
          this.detailsTarget.innerHTML = `Invalid PIN Code`;
          const errorDiv = document.getElementById("errorContainer");
          errorDiv.innerHTML = `Invalid PIN Code`;
        }
      })
      .catch((error) => {
        console.error("Error:", error);
      });
  }

  displayDetails(details) {
    // Assuming you have an element with the "data-pin-target='details'" attribute
    this.detailsTarget.innerHTML = `<p>City: ${details.city}</p><p>District: ${details.district}</p><p>State: ${details.state}</p>`;
    const errorDiv = document.getElementById("errorContainer");
    errorDiv.innerHTML = ``;
  }
}
