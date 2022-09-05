// import { Controller } from "@hotwired/stimulus"

// export default class extends Controller {
//   static targets = [ "playerSongName", "playerArtist", 'playerCoverImg']
//   static values = { token: String, songId: String }

//   connect() {
//     window.onSpotifyWebPlaybackSDKReady = () => {
//       const token = this.tokenValue;
//       this.player = new Spotify.Player({
//         name: 'lovebuzz',
//         getOAuthToken: cb => { cb(token); },
//         volume: 0.5
//       });
//       if (window.localStorage.cover) {
//         this.playerCoverImgTarget.src = window.localStorage.cover
//         this.playerSongNameTarget.innerHTML = '<h2>' + window.localStorage.title + '</h2>'
//         this.playerArtistTarget.innerText = window.localStorage.artist
//       } else {
//         this.playerCoverImgTarget.src = ""
//         this.playerSongNameTarget.innerText = ""
//         this.playerArtistTarget.innerText = ""
//       }

//         // Ready
//         this.player.addListener('ready', ({ device_id }) => {
//         console.log('Ready with Device ID', device_id);
//         this.id = device_id
//       });

//       player.getCurrentState().then(state => {
//         if (!state) {
//           console.error('User is not playing music through the Web Playback SDK');
//           return;
//         }

//         var current_track = state.track_window.current_track;
//         var next_track = state.track_window.next_tracks[0];

//         console.log('Currently Playing', current_track);
//         console.log('Playing Next', next_track);
//       });
//     }
//   }
// }
