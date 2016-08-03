// NOTE: The contents of this file will only be executed if
// you uncomment its entry in "web/static/js/app.js".

// To use Phoenix channels, the first step is to import Socket
// and connect at the socket path in "lib/my_app/endpoint.ex":
import {Socket} from "phoenix"

(function () {

  if (!window.userName) { return; }

  let socket = new Socket("/socket", {params: {user: window.userName}})

  socket.connect()

  let channel = socket.channel(`rooms:${window.gameSlug}`, {})
  channel.join()
    .receive("ok", resp => { console.log("Joined successfully", resp) })
    .receive("error", resp => { console.log("Unable to join", resp) })

  let messageInput = document.getElementById("NewMessage")

  messageInput.addEventListener("keypress", (e) => {
    if (e.keyCode == 13 && messageInput.value != "") {
      channel.push("message:new", messageInput.value)
      messageInput.value = ""
    }
  });
  
  let formatTimestamp = (timestamp) => {
    let date = new Date(timestamp)
    return date.toLocaleTimeString()
  }

  let messageList = document.getElementById("MessageList")
  let renderMessage = (message) => {
    let messageElement = document.createElement("li")
    messageElement.innerHTML = `
      <b>${message.user}</b>
      <i>${formatTimestamp(message.timestamp)}</i>
      <p>${message.body}</p>
    `
    messageList.appendChild(messageElement)
    messageList.scrollTop = messageList.scrollHeight;
  }

  channel.on("message:new", message => renderMessage(message))

})();