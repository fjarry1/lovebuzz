import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "playerSongName", "playerArtist", 'playerCoverImg']
  static values = { token: String, songId: String }

  connect() {
    window.onSpotifyWebPlaybackSDKReady = () => {
      const token = this.tokenValue;
      this.player = new Spotify.Player({
        name: 'lovebuzz',
        getOAuthToken: cb => { cb(token); },
        volume: 0.5
      });
      if (window.localStorage.cover) {
        this.playerCoverImgTarget.src = window.localStorage.cover
        this.playerSongNameTarget.innerHTML = '<h2>' + window.localStorage.title + '</h2>'
        this.playerArtistTarget.innerText = window.localStorage.artist
      } else {
        this.playerCoverImgTarget.src = ""
        this.playerSongNameTarget.innerText = ""
        this.playerArtistTarget.innerText = ""
      }
    }
  }
}

// unfi
