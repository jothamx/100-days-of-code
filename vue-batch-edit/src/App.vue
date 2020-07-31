<template>
  <div id="app">
    <button @click="onClick">批量编辑</button>
    <button @click="delSelect">删除所有</button>
    <Gallery :images="images" :isEdit="isEdit" :select="select"></Gallery>
  </div>
</template>

<script>
import Gallery from "./components/Gallery";

export default {
  name: "App",
  components: {
    Gallery,
  },
  data: function () {
    return {
      images: [
        "https://via.placeholder.com/600/92c952",
        "https://via.placeholder.com/600/771796",
        "https://via.placeholder.com/600/24f355",
        "https://via.placeholder.com/600/d32776",
        "https://via.placeholder.com/600/f66b97",
        "https://via.placeholder.com/600/56a8c2",
        "https://via.placeholder.com/600/b0f7cc",
        "https://via.placeholder.com/600/54176f",
        "https://via.placeholder.com/600/51aa97",
        "https://via.placeholder.com/600/810b14",
        "https://via.placeholder.com/600/1ee8a4",
        "https://via.placeholder.com/600/66b7d2",
      ],
      isEdit: false,
      select: [],
    };
  },
  methods: {
    onClick: function () {
      this.isEdit = !this.isEdit;
    },
    delSelect: function () {
      for (let item of this.select) {
        this.images.splice(this.images.indexOf(item), 1);
      }
      this.select.splice(0, this.select.length);
    },
  },
};
</script>

<style scoped>
#app {
  font-family: Avenir, Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
  margin: 60px auto auto;
  text-align: left;
  width: 80%;
}
</style>
