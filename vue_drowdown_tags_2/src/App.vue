<template>
  <div id="app">
    <section class="thin-scroll">
      <section class="tags-panel-list">
        <div class="tags-unit" v-for="(item,index) of category" :key="index">
          <div class="tags-unit-name">
            <span>{{item}}</span>
          </div>
          <div class="tags-unit-body">
            <dropdownTags
              class="droptag"
              :selTagList="goodsTags[item]"
              :tagList="userTags[item]"
              :catalog="item"
              :disabled="true"
              @addTag="addTag"
              @removeTag="removeTag"
              @removeGoodsTag="removeGoodsTag"
              @selectTag="selectGoodsTag"
            ></dropdownTags>
          </div>
        </div>
      </section>
    </section>
  </div>
</template>

<script>
import DropdownTags from "./components/dropdownTags.vue";

export default {
  name: "App",
  components: {
    DropdownTags
  },
  computed: {
    allSelectTags: function() {
      let data = [];
      for (let item of this.category) {
        if (this.goodsTags[item]) {
          for (let t of this.goodsTags[item]) {
            data.push({ tag: t, catalog: item });
          }
        }
      }
      return data;
    }
  },
  data() {
    return {
      goodsTags: {
        分类一: ["tag1", "tag2", "tag3"],
        分类二: ["tag11", "tag55", "tag66"],
        分类三: ["tag21", "tag25", "tag26"]
      },
      userTags: {
        分类一: ["tag1", "tag2", "tag3", "tag4", "tag5", "tag6"],
        分类二: ["tag11", "tag22", "tag33", "tag44", "tag55", "tag66"],
        分类三: []
      },
      category: ["分类一", "分类二", "分类三"],
      input: ""
    };
  },
  methods: {
    addCatalog() {
      if (this.input == "") {
        return;
      }
      this.category.push(this.input);
      this.$set(this.userTags, this.input, []);
      this.$set(this.goodsTags, this.input, []);
      this.input = "";
    },
    addTag(tag, catalog) {
      let data = this.userTags[catalog];
      data.push(tag);
      this.$set(this.userTags, catalog, data);
    },
    addGoodsTag(tag, catalog) {
      let data = this.goodsTags[catalog];
      data.push(tag);
      this.$set(this.goodsTags, catalog, data);
    },
    removeTag(tag, catalog) {
      let data = this.userTags[catalog];
      data.splice(data.indexOf(tag), 1);
      this.$set(this.userTags, catalog, data);
    },
    removeGoodsTag(tag, catalog) {
      let data = this.goodsTags[catalog];
      data.splice(data.indexOf(tag), 1);
      this.$set(this.goodsTags, catalog, data);
    },
    selectGoodsTag(tag, catalog) {
      let data = this.goodsTags[catalog];

      if (data.indexOf(tag) != -1) {
        this.removeGoodsTag(tag, catalog);
      } else {
        this.addGoodsTag(tag, catalog);
      }
    }
  }
};
</script>

<style scoped>
#app {
  font-family: Avenir, Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
  margin-left: auto;
  margin-right: auto;
  margin-top: 60px;
  display: flex;
  width: 80%;
}

.thin-scroll {
  max-height: 488px;
  overflow-y: auto;
}

.tags-panel-list {
  padding: 0 16px 8px;
}
.tags-unit {
  display: flex;
  margin-top: 0;
}

.tags-unit-name {
  margin-right: 20px;
  margin-bottom: 0;
  flex: none;
  width: 82px;
  position: relative;
  line-height: 38px;
  cursor: default;
}

.tags-unit-body {
  display: flex;
  justify-content: space-between;
}


.tags {
  background-color: #d8e7f7;
  width: 50%;
  padding: 50px;
}

.tags-list {
  list-style-type: none;
  display: flex;
}
.tags-list-item {
  margin-right: 10px;
  margin-bottom: 10px;
}

.catalog {
  width: 50%;
  background-color: #dad2d2ab;
}
.catalog-items {
  display: flex;
}

.catalog-item {
  margin-right: 10px;
  margin-bottom: 10px;
}

.list-item {
  list-style-type: none;
}

.list-item-row {
  display: flex;
  height: 100px;
}
.droptag {
  margin-left: 10px;
  width: 180;
}
</style>>
