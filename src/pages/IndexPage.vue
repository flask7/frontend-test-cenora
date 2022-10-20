<template>
  <div class="q-pa-md row justify-center">
    <div class="chat-box">
      <div class="container-messages">
        <div v-for="(msg, i) in messages" :key="i">
          <q-chat-message v-if="msg.user === user" sent>
            <p>{{ msg.message }}</p>
          </q-chat-message>
          <q-chat-message v-else>
            <p>{{ msg.message }}</p>
          </q-chat-message>
        </div>
      </div>
      <div class="message-field">
        <q-input
          filled
          v-model="message"
          label="Message *"
          hint="Type your message..."
          lazy-rules
          :rules="[(val) => (val && val.length > 0) || 'Please type something']"
        />
        <br />
        <q-btn
          color="primary"
          :disabled="message.length < 1"
          label="Send message"
          icon-right="send"
          class="full-width"
          @click="sendMessage()"
        />
      </div>
    </div>
  </div>
</template>

<script>
import { defineComponent } from "vue";
import { nanoid } from "nanoid";

export default defineComponent({
  name: "IndexPage",
  data() {
    return {
      message: "",
      messages: [],
      record: null,
      user: nanoid(),
    };
  },
  mounted() {
    const { DeepstreamClient } = window?.DeepstreamClient;
    const client = new DeepstreamClient("localhost:6020");

    client.login({ username: this.user });

    this.record = client?.record?.getRecord("receive");
    let context = this;

    this.record.subscribe("message", function (value, t = context) {
      t.messages.push(value);
    });
  },
  updated() {
    const box = document.querySelector(".container-messages");
    box.scrollTop = box.scrollHeight;
  },
  methods: {
    sendMessage() {
      this.record?.set("message", { message: this.message, user: this.user });
      this.message = "";
    },
  },
});
</script>

<style>
.chat-box {
  width: 100%;
  max-width: 400px;
  max-height: 600px;
  height: 500px;
  border: 3px solid #0084ff;
  padding: 1rem;
  border-radius: 10px;
}

.container-messages {
  max-height: 70%;
  height: 70%;
  overflow-x: hidden;
  overflow-y: scroll;
}

.message-field {
  position: relative;
  bottom: 0;
}
</style>
