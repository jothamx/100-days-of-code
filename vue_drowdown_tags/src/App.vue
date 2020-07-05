<template>
  <div id="app">
    <img alt="Vue logo" src="./assets/logo.png" />
    <div>
      <dropdownTags
        :selTagList="selTagList"
        :tagList="tagList"
        @change="update"
        class="dropdown"
      />
    </div>
  </div>
</template>

<script>
import dropdownTags from "./components/dropdownTags.vue";
export default {
  name: "App",
  components: {
    dropdownTags,
  },
  data() {
    return {
      selTagList: ["标签三", "标签五", "标签六"],
      tagList: [
        { name: "标签一", level: 1 },
        { name: "标签二", level: 2 },
        { name: "标签三", level: 3 },
        { name: "标签四", level: 4 },
        { name: "标签五", level: 5 },
        { name: "标签六", level: 6 },
      ],
    };
  },
  methods: {
    update: function(a, b) {
      this.selTagList = a;
      this.tagList = b;
    },
  },
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
.dropdown {
  width: 50%;
  margin-left: auto;
  margin-right: auto;
}
</style>
