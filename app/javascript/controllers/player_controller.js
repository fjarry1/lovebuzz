import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "title", "artist" ]

  connect() {
      // setInterval(() => {
        const options = {
          method: "GET",
          headers: {
            "Authorization": "Bearer BQAmJ32AbWsQeOG9uOOPVTU0zrWJYe10PE7g0jiGCH7YqANpAPR2gCuJwkgmBzQsOPouqf4WmWyjKpqpc9kfqmr8PWqClhJmzBOSHCcbsGAbU8Fu_eRBMwRJdufH947Av0jkSUcHWP_rrGFjai1l-gMPObC2zLcGrxViKNfgsICx8N800g" },
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
