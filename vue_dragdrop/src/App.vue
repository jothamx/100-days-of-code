<template>
  <div id="app">
    <DragDrop style=" width: 330px;min-height: 400px;margin: auto;border:solid 1px red"/>
  </div>
</template>

<script>
import DragDrop from './components/DragDrop.vue'

export default {
  name: 'App',
  components: {
    DragDrop
  }
}
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
