import { Controller } from "@hotwired/stimulus"
import Hammer from 'hammerjs'
import Swal from 'sweetalert2'

export default class extends Controller {
  static targets = [ "card", "nopeBtn", "likeBtn", "modalContainer" ]

  connect() {
    this.csrf = document.querySelector("[name='csrf-token']").content

    this._initCards();
    this._initSwipe();

    this.nopeBtnTarget.addEventListener('click', (e) => {
      this._createButtonListener(false, e)
    });

    this.likeBtnTarget.addEventListener('click', (e) => {
      this._createButtonListener(true, e)
    });

    this.likeEvent = new Event('liked');
    this.dislikeEvent = new Event('disliked');
  }

  liked(elementId) {
    document.dispatchEvent(this.likeEvent);
    console.log(`liked id ${elementId}`)

    const options = {
      method: "POST",
      headers: { "Accept": "application/json", "X-CSRF-TOKEN": this.csrf },
    }

    fetch(`/matches?user_id=${elementId}&like=true`, options)
      .then(response => response.json())
      .then((data) => {
        if (data.match){
            this.modalContainerTarget.innerHTML = data.modal_html
/*           Swal.fire({
            icon: 'success',
            title: 'It\'s a match! 🍆💦🍑',
            text: `You were listening ${data.track_name} - ${data.artist_name} at the same time with ${data.username}`,
            footer: '<a href="">Keep swiping or chat?</a>'
          }) */
        }
        // this._noCardsLeft()
      })
  }

  disliked(elementId) {
    document.dispatchEvent(this.dislikeEvent);
    console.log(`disliked id ${elementId}`)

    const options = {
      method: "POST",
      headers: { "Accept": "application/json", "X-CSRF-TOKEN": this.csrf },
    }

    fetch(`/matches?user_id=${elementId}&like=false`, options)
      .then(response => response.json())
      .then((data) => {
        // this._noCardsLeft()
      })
  }

  _initCards(card, index) {
    const cards = this._activeCards()

    cards.forEach((card, index) => {
      card.style.zIndex = cards.length - index;
      card.style.transform = 'scale(' + (20 - index) / 20 + ') translateY(-' + 25 * index + 'px)';
      card.style.opacity = (10 - index) / 10;
    });

    this.element.classList.add('loaded');
  }

  // _noCardsLeft() {
  //   setTimeout(() => {
  //     if (this._activeCards().length === 0) {
  //       Swal.fire({
  //         icon: 'warning',
  //         title: 'You don’t have any matches yet ☹️',
  //         text: `Maybe you should listen to some other song and let the magic happen !!`,
  //       })
  //     }
  //   }, 300);
  // }

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
      el.classList.toggle('tinder_love', event.deltaX > 0);
      el.classList.toggle('tinder_nope', event.deltaX < 0);

      const rotate = event.deltaX * 0.03 * event.deltaY / 80;
      event.target.style.transform = `translate(${event.deltaX}px, ${event.deltaY}px) rotate(${rotate}deg)`;
    });
  }

  _listenToPanEnd(hammertime, el) {
    hammertime.on('panend', (event) => {
      el.classList.remove('moving', 'tinder_love', 'tinder_nope');

      const moveOutWidth = document.body.clientWidth;
      const keep = Math.abs(event.deltaX) < 80 || Math.abs(event.velocityX) < 0.5;

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

  _createButtonListener(love, event) {
    const cards = this._activeCards()
    const moveOutWidth = document.body.clientWidth * 1.5;
    if (!cards.length) return false;

    const card = cards[0];
    const minus = love ? '' : '-'

    card.style.transform = `translate(${minus}${moveOutWidth}px, -100px) rotate(${minus}30deg)`;
    card.classList.add('removed');
    if (love) {
      this.liked(card.dataset.id)
    } else {
      this.disliked(card.dataset.id)
    }
    this._initCards();
    event.preventDefault();
  }

  _activeCards() {
    return this.cardTargets.filter(e => !e.classList.contains('removed'));
  }

  closeModal() {
    console.log('close modal frere')
    const modal = this.modalContainerTarget.firstElementChild
    modal.classList.add('fade-out')
    setTimeout(() => {
      modal.remove()
    }, 350);
  }
}
