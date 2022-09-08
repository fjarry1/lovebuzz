import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "title", "artist" ]

  connect() {
      // setInterval(() => {
        const options = {
          method: "GET",
          headers: {
            "Authorization": "Bearer BQB4M9Hx93FijrKPrIdf0lssww7ecf9RXR0NRs_j-78nM0QohLETTfDJyz-GWbeUcZFiPEWQN_KrIgPmRi-uPGEYaqu_sZkGVE4rG2uShmg_GxxPvNC-MneJxnS1zWp3KAeC0aQLRVT_mRElJ3oA0PjR_ooOFL8LOmmOnJBY1BB6wSlW9w" },
          }

          fetch('https://api.spotify.com/v1/me/player/currently-playing', options)
            .then(response => response.json())
            .then((data) => {
              console.log(data)
              this.titleTarget.innerText = data.item.name
              this.artistTarget.innerText = data.item.artists[0].name
              // this.artworkTarget
          })
    //  }, 5000);
    }
  }
