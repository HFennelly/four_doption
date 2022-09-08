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

  refine(e) {
    // console.log(this.speciesTarget.value)
    // console.log(this.sexTarget.value)
    // console.log(e.target.attributes.id === 'Species')
    // console.log(e.target.attributes.id.value === 'Species')
    const species = this.speciesTarget.value.toLowerCase()
    const sex = this.sexTarget.value.toLowerCase()
    console.log(sex);
    console.log(species);
    const size = this.sizeTarget.value.toLowerCase()
    // console.log(size)
    // console.log(species)


    this.petTargets.forEach((pet) => {
      console.log(pet)
      console.log(pet.dataset.sex === sex)
      console.log(pet.dataset.sex)

          if ((pet.dataset.sex === sex) || (pet.classList.contains("d-none") && pet.dataset.sex === sex)) {
            pet.classList.remove("d-none")
            if (pet.dataset.species === species || pet.classList.contains("d-none") && pet.dataset.species === species) {
              pet.classList.remove("d-none")
            } else if (pet.dataset.species !== species && pet.dataset.sex !== sex) {
              pet.classList.add("d-none")
            } else { pet.classList.add("d-none")}
          } else {
            pet.classList.add("d-none")
          }
        })

  }
}




      //   if (pet.dataset.sex == sex && pet.dataset.species == species) {
      //         pet.parentElement.remove('d-none')
      //    } else if (pet.dataset.sex == sex) {
      //   pet.classList.remove('d-none')
      //   } else if (pet.dataset.species != species) {
      //     pet.classList.add('d-none')
      //   } else if (pet.dataset.sex != sex) {
      //   pet.classList.add('d-none') }
      //   else {

      //   }


      // })
      // }
