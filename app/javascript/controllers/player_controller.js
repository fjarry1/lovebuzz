import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "title", "artist", "artwork"]

  connect() {
      // setInterval(() => {
        const options = {
          method: "GET",
          headers: {
            "Authorization": "Bearer BQDJojKiuek-2zm5RQ0d3ZMK_iwOf8u4bJFVZW2zdacghMWydPG8v75_sIUSglWvYhShRBo-CdxfAx6HezC7Oej7eXzEE3U_DmuU6xAOMSpZAH1TF7tJicMMRnkCw8xnt-ni8qIeWiXWyi7MojsOxPVIbIcL7NZqZNnMA4biMFGAE89vXw" },
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
