import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="filter-search"
export default class extends Controller {
  static targets = ["dropdown", "hideButton", "pet", "sex", "species", "size"]
  connect() { console.log("I'm connected") }

  show() {
    const dropdown = document.querySelector('.filter-search-dropdown-form')
    const buttonHide = document.querySelector('.btn')
    dropdown.classList.remove("d-none")
    buttonHide.classList.add("d-none")
  }

  hide() {
    const dropdown = document.querySelector('.filter-search-dropdown-form')
    const buttonHide = document.querySelector('.btn')
    dropdown.classList.add("d-none")
    buttonHide.classList.remove("d-none")
  }


}
