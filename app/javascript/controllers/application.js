import { Application } from "@hotwired/stimulus"

const application = Application.start()

// Configure Stimulus development experience
application.debug = false
window.Stimulus   = application

// var Spotify = require('spotify-web-api-js');
// var s = new Spotify();

export { application }
