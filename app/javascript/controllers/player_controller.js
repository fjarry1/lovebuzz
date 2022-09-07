import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "title", "artist", "artwork"]

  connect() {
      // setInterval(() => {
        const options = {
          method: "GET",
          headers: {
            "Authorization": "Bearer BQB9cHcvJErzCLSJZKCisazmWYelT_e5BsxZLmoQd8csXng13QRkjddOIWzfMxL6yyTAIT-QlYxO5dC_hBUiqc7IwQedU2rWjWBS-UX4zhN-v4Nf6uIBWk5ZYpQKpW3OOCQFqUh4l3R3LyaqVAJIGAF_P0PcSDXI55Ca5MMrAEY3SuSq1A" },
          }

          fetch('https://api.spotify.com/v1/me/player/currently-playing', options)
            .then(response => response.json())
            .then((data) => {
              console.log(data)
              this.titleTarget.innerText = data.item.name
              this.artistTarget.innerText = data.item.artists[0].name
              this.artworkTarget
          })
     // }, 1500);
    }
  }
