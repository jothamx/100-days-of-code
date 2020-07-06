<template>
  <div id="app">
    <vue-qr :logoSrc="imageUrl" text="url" :size="200"></vue-qr>
  </div>
</template>

<script>
import VueQr from "vue-qr";

export default {
  name: "App",
  components: {
    VueQr
  },
  data() {
    return {
      imageUrl: require("@/assets/logo.png"),
      url:"Hello world!"
    };
  },
  methods: {
    test(url, id) {
      console.log(url, id);
    }
  }
};
</script>

<style>
#app {
  font-family: Avenir, Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
  margin-top: 60px;
}
</style>
