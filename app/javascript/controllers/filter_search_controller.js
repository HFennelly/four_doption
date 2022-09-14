import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="filter-search"
export default class extends Controller {
  static values = {
    dictionary: Object

  }
  static targets = ["dropdown", "hideButton", "pet", "sex", "species", "size", "breed"]
  connect() {

    console.log("I'm connected")
    console.log(this.dictionaryValue)
    console.log(this.speciesTarget)
  }


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

  selectBreedBySpecies (e) {
    console.log(e.target.options[e.target.selectedIndex].value)
    const species = e.target.options[e.target.selectedIndex].value
    const breeds = this.dictionaryValue[species]
    console.log(breeds)
    let options = ""
    breeds.forEach((b) => {
      options += `<option value="${b}">${b}</option>`
    })
    this.breedTarget.innerHTML = options
  }

}
