import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "title", "artist", "artwork"]

  connect() {
      // setInterval(() => {
        const options = {
          method: "GET",
          headers: {
            "Authorization": "Bearer BQCMLaelaKhg36Q9Ycy8tPELWKo-ywSDB1gfOWtvCpaiHpt4LZy0gpAchc8E_FkaXimI74gthdr5Ny39QdOkxBYDQhdp-fKGIYWic3wCryqPdAucKq0-6lbFtgiOKyTWtqy_HFqigRuuTT7iLH-62rao5QpV6tLb2QpAf1gF68QwrZvR-g" },
          }

          fetch('https://api.spotify.com/v1/me/player/currently-playing', options)
            .then(response => response.json())
            .then((data) => {
              console.log(data)
              this.titleTarget.innerText = data.item.name
              this.artistTarget.innerText = data.item.artists[0].name
              this.artworkTarget
          })
    //  }, 5000);
    }
  }
