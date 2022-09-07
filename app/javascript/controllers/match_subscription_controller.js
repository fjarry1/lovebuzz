import { Controller } from "@hotwired/stimulus"
import { createConsumer } from "@rails/actioncable"


// Connects to data-controller="match-subscription"
export default class extends Controller {
  static values = {
    matchId: Number,
    userId: Number
  }
  static targets = [ 'messages' ]

  connect() {
    this.channel = createConsumer().subscriptions.create(
      { channel: 'MatchChannel', id: this.matchIdValue },
      { received: this.#processMessage.bind(this) }
    )
    this.#scrollToBottom()

  };

  disconnect() {
    this.channel.unsubscribe()
  }

  resetForm(event) {
    event.target.reset()
  }

  #processMessage(data) {
    const sender = this.userIdValue == data.user_id
    const msgElement = this.#buildHTML(data.html)

    if (!sender) msgElement.classList.remove('sender')
    if (!sender) msgElement.querySelector('.message-infos span').innerText = data.user_name
    this.#insertMessage(msgElement)
    console.log(msgElement)
    this.#scrollToBottom()
  }

  #buildHTML(string) {
    const tmpDiv = document.createElement('div')
    tmpDiv.innerHTML = string
    return tmpDiv.firstElementChild
  }

  #insertMessage(element) {
    this.messagesTarget.appendChild(element)
  }

  #scrollToBottom() {
    this.messagesTarget.scrollIntoView({ behavior: 'smooth', block: 'end'});
  }
}
