import { Controller } from "@hotwired/stimulus"
import Hammer from 'hammerjs';
import { csrfToken } from "@rails/ujs";
import { Modal } from 'bootstrap';

export default class extends Controller {
  static targets = [ "card", "swipeLeftBtn", "swipeRightBtn", "modal", "modalbody", "closeModalBtn", "startConversationBtn" ]

  connect() {
    this._initCards();
    this._initSwipe();

    // navigator.geolocation.getCurrentPosition((data) => {
    //   var locationLatitude = data.coords.latitude;
    //   var locationLongitude = data.coords.longitude;

    //   const formdata = new FormData
    //   formdata.append('latitude', locationLatitude)
    //   formdata.append('longitude', locationLongitude)
    //   this.fetchWithToken("/swipes/geolocation", {
    //   method: "POST",
    //   headers: {"Accept": "application/json" },
    //   body: formdata
    // })
    // });

    this.swipeLeftBtnTarget.addEventListener('click', (e) => {
      this._createButtonListener(false, e)
    });

    this.swipeRightBtnTarget.addEventListener('click', (e) => {
      this._createButtonListener(true, e)
    });

    this.likeEvent = new Event('liked');
    this.dislikeEvent = new Event('disliked');
  }

  liked(elementId) {
    document.dispatchEvent(this.likeEvent);
    console.log(`liked id ${elementId}`)
    const data = new FormData
    data.append('user[id]', elementId)
    this.fetchWithToken("/swipes/swipe_right", {
      method: "POST",
      headers: {"Accept": "application/json" },
      body: data
    })
    .then(response => response.json())
    .then((data) => {
    // //
    // const modal = new Modal(this.modalTarget)
    // this.modalbodyTarget.innerHTML = data.content
    // modal.show();
    // this.closeModalBtnTarget.addEventListener('click', (e) => {
    //   modal.hide()
    // });
    // this.startConversationBtnTarget.addEventListener('click', (e) => {
    //   modal.hide()
    // });
    // //

      if (data.match === true) {
        const modal = new Modal(this.modalTarget)
        this.modalbodyTarget.innerHTML = data.content
        modal.show();
        this.closeModalBtnTarget.addEventListener('click', (e) => {
          modal.hide()
        });
        this.startConversationBtnTarget.addEventListener('click', (e) => {
          modal.hide()
        });
        console.log("It's a match")
      } else {
        console.log("Not a match... yet!")
      }
    })
  }

  disliked(elementId) {
    document.dispatchEvent(this.dislikeEvent);
    console.log(`disliked id ${elementId}`)
    const data = new FormData
    data.append('user[id]', elementId)
    this.fetchWithToken("/swipes/swipe_left", {
      method: "POST",
      headers: {"Accept": "application/json" },
      body: data
    })
    .then(response => response.json())
    .then((data) => {
    })
  }

  _initCards(card, index) {
    const cards = this._activeCards()

    cards.forEach((card, index) => {
      card.style.zIndex = cards.length - index;
      // card.style.transform = 'scale(' + (20 - index) / 20 + ') translateY(-' + 30 * index + 'px)';
      // card.style.opacity = (10 - index) / 10;
    });

    this.element.classList.add('loaded');
  }

  _initSwipe() {
    this.cardTargets.forEach((el) => {
      const hammertime = new Hammer(el);

      this._listenToPan(hammertime, el)
      this._listenToPanEnd(hammertime, el)

    });
  }

  _listenToPan(hammertime, el) {
    hammertime.on('pan', (event) => {
      if (event.deltaX === 0 || event.center.x === 0 && event.center.y === 0) return;

      el.classList.add('moving');
      el.classList.toggle('swiper_swipeRight', event.deltaX > 0);
      el.classList.toggle('swiper_swipeLeft', event.deltaX < 0);

      const rotate = event.deltaX * 0.03 * event.deltaY / 80;
      event.target.style.transform = `translate(${event.deltaX}px, ${event.deltaY}px) rotate(${rotate}deg)`;
    });
  }

  _listenToPanEnd(hammertime, el) {
    hammertime.on('panend', (event) => {
      el.classList.remove('moving', 'swiper_swipeRight', 'swiper_swipeLeft');

      const moveOutWidth = document.body.clientWidth;
      const keep = Math.abs(event.deltaX) < 80;
      // const keep = Math.abs(event.deltaX) < 80 || Math.abs(event.velocityX) < 0.5;

      if (!keep && event.additionalEvent === 'panright') {
        this.liked(event.target.dataset.id)
      } else if (!keep && event.additionalEvent === 'panleft') {
        this.disliked(event.target.dataset.id)
      }

      event.target.classList.toggle('removed', !keep);

      if (keep) {
        event.target.style.transform = '';
      } else {
        const endX = Math.max(Math.abs(event.velocityX) * moveOutWidth, moveOutWidth);
        const toX = event.deltaX > 0 ? endX : -endX;
        const endY = Math.abs(event.velocityY) * moveOutWidth;
        const toY = event.deltaY > 0 ? endY : -endY;
        const xMulti = event.deltaX * 0.03;
        const yMulti = event.deltaY / 80;
        const rotate = xMulti * yMulti;

        event.target.style.transform = `translate(${toX}px, ${toY + event.deltaY}px) rotate(${rotate}deg)`;
        this._initCards();
      }
    });
  }

  _createButtonListener(swipeRight, event) {
    const cards = this._activeCards()
    const moveOutWidth = document.body.clientWidth * 1.5;
    if (!cards.length) return false;


    const card = cards[0];
    const minus = swipeRight ? '' : '-'
    if(swipeRight) {
      this.liked(card.dataset.id)
    } else {
      this.disliked(card.dataset.id)
    }

    card.style.transform = `translate(${minus}${moveOutWidth}px, -100px) rotate(${minus}30deg)`;
    card.classList.add('removed');

    this._initCards();
    event.preventDefault();
  }

  _activeCards() {
    return this.cardTargets.filter(e => !e.classList.contains('removed'));
  }

  fetchWithToken(url, options) {
    options.headers = {
      "X-CSRF-Token": csrfToken(),
      ...options.headers
    };

    return fetch(url, options);
  }
}
