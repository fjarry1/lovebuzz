import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "title", "artist" ]

  connect() {
      // setInterval(() => {
        const options = {
          method: "GET",
          headers: {
            "Authorization": "Bearer BQB7815JN5HRLeJ1wcyihpD3ycF4T1bKVCzae81mkTlFxaNX7R0fZy4XRif270z67vZ_YVPzMVJvEmZ8zPvHW6wT-sW2QaUN0GFJYXYIC0pQbw7HXqCKkSyGXsECNfqU7YAR4kUw1kD15t_e2JB2uJNh-bHs5gqARSli08wTr4Ot7sFiwg" },
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
