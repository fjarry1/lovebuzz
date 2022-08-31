import { Controller } from "@hotwired/stimulus"
import Hammer from 'hammerjs';

// Connects to data-controller="swipe"
export default class extends Controller {
  connect() {
    console.log("Controller connected")
  }
}
