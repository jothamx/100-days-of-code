<template>
  <div id="app">
    <UploadSortable style="width:100%"/>
  </div>
</template>

<script>
import UploadSortable from "./components/uploadSortable.vue";

export default {
  name: "App",
  components: {
    UploadSortable
  }
};
</script>

<style lang="scss">
#app {
  font-family: Avenir, Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
  margin-top: 60px;
}
</style>
