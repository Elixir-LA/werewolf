// NOTE: The contents of this file will only be executed if
// you uncomment its entry in "web/static/js/app.js".

// To use Phoenix channels, the first step is to import Socket
// and connect at the socket path in "lib/my_app/endpoint.ex":
import {Socket, Presence} from "phoenix"

(function () {

  if (!window.userName) { return; }

  let socket = new Socket("/socket", {params: {user: window.userName}})

  socket.connect()

  let channel = socket.channel(`games:${window.gameSlug}`, {})
  let onJoin = (state) => { 
    if (state.game_started) {
      startGameUI();
    }
  };
  
  channel.join()
    .receive("ok", resp => { console.log("Joined successfully", resp); onJoin(resp) })
    .receive("error", resp => { console.log("Unable to join", resp) })

// chat room

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

// starting games

  let startGameUI = () => gameArea.classList.add("active");
  
  let startGameButton = document.getElementById("game-toggle");

  startGameButton.addEventListener('click', ()=> {
     channel.push("game:start", "");
  })

  let gameArea = document.querySelector('.game-area');
  channel.on("game:start", startGameUI);

// user list (w/ presence)

  let presences = {}

  let listBy = (user, {metas: metas}) => {
    return {
      user: user,
      onlineAt: formatTimestamp(metas[0].online_at)
    }
  }

  let userList = document.getElementById("UserList")
  let render = (presences) => {
    userList.innerHTML = Presence.list(presences, listBy)
      .map(presence => `
        <li>
          ${presence.user}
          <br>
          <small>online since ${presence.onlineAt}</small>
        </li>
      `)
      .join("")
  }

  channel.on("presence_state", state => {
    presences = Presence.syncState(presences, state)
    render(presences)
  })

  channel.on("presence_diff", diff => {
    presences = Presence.syncDiff(presences, diff)
    render(presences)
  })

})();
