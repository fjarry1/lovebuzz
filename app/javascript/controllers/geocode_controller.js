import { Controller } from "@hotwired/stimulus"
// import mapboxgl from "mapbox-gl";

// mapboxgl.accessToken = "pk.eyJ1IjoibWFraWhkZ28iLCJhIjoiY2w2Z2NieTB6MTYxYjNqbjJnNXpxNTQ0ZiJ9.ZPJrHBSMoV9kkWv7zRBw4A";

export default class extends Controller {

  connect() {
    console.log("The 'geocode' controller is now loaded!");
    navigator.geolocation.getCurrentPosition((data) => {
      fetch("geolocalize", {
        method: "PATCH",
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
          "X-CSRF-Token": document.querySelector("[name='csrf-token']").content,
        },
        body: JSON.stringify({ latitude: data.coords.latitude, longitude: data.coords.longitude }),
      })
      console.log(data)
    })
  }

  disconnect() {
    navigator.geolocation.getCurrentPosition((data) => {
      fetch("geolocalize", {
        method: "PATCH",
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
          "X-CSRF-Token": document.querySelector("[name='csrf-token']").content,
        },
        body: JSON.stringify({ latitude: data.coords.latitude, longitude: data.coords.longitude }),
      })
      console.log(data)
    })
    console.log("the 'geocode' controller is now disconnected")
  }
}
