import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="razorpay"
export default class extends Controller {
  connect() {
    this.orderId = this.element.getAttribute("razor-order-id");
    this.amount = this.element.getAttribute("razor-amount");
    this.pay();
  }

  // initialize() {
  //   this.element.setAttribute("data-action", "mouseover->razorpay#pay");
  // }

  pay() {
    var options = {
      key: "rzp_test_tmqHaNW5ZHfztJ", // Enter the Key ID generated from the Dashboard
      amount: this.amount, // Amount is in currency subunits. Default currency is INR. Hence, 50000 refers to 50000 paise
      currency: "INR",
      name: "Orange Turtle",
      description: "Transaction to Orange Turtle",
      image: "app/assets/images/orange-turtle.jpeg",
      order_id: this.orderId, //This is a sample Order ID. Pass the `id` obtained in the response of Step 1
      handler: function (response) {
        // alert(response.razorpay_payment_id);
        // alert(response.razorpay_order_id);
        // alert(response.razorpay_signature);
        var paymentData = {
          payment_id: response.razorpay_payment_id,
          order_id: response.razorpay_order_id,
          signature: response.razorpay_signature,
          first_name: document.querySelector("#first_name").value,
          last_name: document.querySelector("#first_name").value,
          phoneNumber: document.querySelector("#phone").value,
          email: document.querySelector("#email").value,
          pinCode: document.querySelector("#pin").value,
          address_1: document.querySelector("#address_1").value,
          address_2: document.querySelector("#address_2").value,
        };

        window.location.href = "http://localhost:3000";

        fetch("http://localhost:3000/order", {
          method: "POST",
          headers: {
            "Content-Type": "application/json",
            "X-CSRF-Token": document.querySelector("meta[name='csrf-token']")
              .content,
          },
          body: JSON.stringify(paymentData),
        })
          .then((response) => response.json())
          .catch((error) => {
            console.error("Error: ", error);
          });
      },
      prefill: {
        name:
          document.querySelector("#first_name").value +
          " " +
          document.querySelector("#last_name").value,
        email: document.querySelector("#email").value,
        contact: document.querySelector("#phone").value,
      },
      notes: {
        address: document.querySelector("#address_1").value,
      },
      theme: {
        color: "#ff5a1f",
      },
    };
    var rzp1 = new Razorpay(options);
    rzp1.on("payment.failed", function (response) {
      alert(response.error.code);
      alert(response.error.description);
      alert(response.error.source);
      alert(response.error.step);
      alert(response.error.reason);
      alert(response.error.metadata.order_id);
      alert(response.error.metadata.payment_id);
    });
    document.getElementById("rzp-button1").onclick = function (e) {
      var indianPhoneNumberPattern = /^[6-9]\d{9}$/;
      const first_name = document.querySelector("#first_name");
      const last_name = document.querySelector("#last_name");
      const phoneNumber = document.querySelector("#phone").value;
      const email = document.querySelector("#email").value;
      const pinCode = document.querySelector("#pin").value;
      const address_1 = document.querySelector("#address_1").value;
      const address_2 = document.querySelector("#address_2");
      const pin_details = document.querySelector("#pin_details");

      var isPhoneValid = indianPhoneNumberPattern.test(phoneNumber);
      var errorPhoneMessage = isPhoneValid ? "" : "Invalid Phone Number";

      var emailPattern = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
      var isEmailValid = emailPattern.test(email);
      var errorMessage = isEmailValid ? "" : "Invalid Email Address";

      var indianPinCodePattern = /^[1-9]\d{5}$/;
      var isPinValid = indianPinCodePattern.test(pinCode);
      var errorPinMessage = isPinValid ? "" : "Invalid PIN Code";

      var isAddressValid = address_1.length >= 20;
      var errorAddressMessage = isAddressValid
        ? ""
        : "Address Line 1 must have a minimum of 20 characters";

      if (!first_name.value) {
        const errorDiv = document.getElementById("errorContainer");
        errorDiv.innerHTML = `please enter first name`;
      } else if (!last_name.value) {
        const errorDiv = document.getElementById("errorContainer");
        errorDiv.innerHTML = `please enter last name`;
      } else if (!isPhoneValid) {
        const errorDiv = document.getElementById("errorContainer");
        errorDiv.innerHTML = errorPhoneMessage;
      } else if (!isEmailValid) {
        const errorDiv = document.getElementById("errorContainer");
        errorDiv.innerHTML = errorMessage;
      } else if (pin_details.innerHTML == "Invalid Pin") {
        const errorDiv = document.getElementById("errorContainer");
        errorDiv.innerHTML = errorPinMessage;
      } else if (!isPinValid) {
        const errorDiv = document.getElementById("errorContainer");
        errorDiv.innerHTML = errorPinMessage;
      } else if (!isAddressValid) {
        const errorDiv = document.getElementById("errorContainer");
        errorDiv.innerHTML = errorAddressMessage;
      } else {
        const errorDiv = document.getElementById("errorContainer");
        errorDiv.innerHTML = ``;
        rzp1.open();
        e.preventDefault();
      }
    };
  }
}
