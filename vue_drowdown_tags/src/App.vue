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
      tagList: ["标签一", "标签二", "标签三", "标签四", "标签五", "标签六"],
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
  text-align: left;
}
</style>
