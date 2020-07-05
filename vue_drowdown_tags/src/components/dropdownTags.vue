<template>
  <div class="container">
    <ul class=" tag-picker-list">
      <li
        class="tag-item"
        :class="'tag-level-' + tag.level"
        :key="index"
        v-for="(tag, index) in tempArr"
      >
        <span>{{ tag.name }}</span>
        <i class="tag-remove el-icon-error" @click="handleClose(tag)"></i>
      </li>
      <li>
        <el-popover placement="bottom-start" width="250" trigger="click">
          <div class="popover">
            <div class="input-div">
              <input
                class="tag-input"
                placeholder="搜索标签"
                v-model="inputValue"
                @keyup.enter="enterSearch"
              />
              <div class="btn-in-input">
                <button class="el-icon-circle-plus" @click="addTag" />
              </div>
            </div>

            <div v-if="searchTags.length">
              <ul class="tag-list">
                <li
                  class="tag-list-item"
                  :key="index"
                  v-for="(tag, index) in searchTags"
                  @mouseover="mouseOver(tag)"
                  @mouseleave="mouseLeave"
                >
                  <div class="tag-circle-wrap">
                    <div class="tag-circle" :class="'level-' + tag.level"></div>
                  </div>
                  <div @click="selectTagItem(tag)" class="tag-name">
                    {{ tag.name }}
                  </div>
                  <span
                    v-if="tag.name == hoverItem"
                    @click="deleteItem(tag)"
                    class="tag-checked el-icon-delete"
                  ></span>
                  <span
                    v-if="tag.check"
                    class="tag-checked el-icon-check"
                  ></span>
                </li>
              </ul>
            </div>
          </div>
          <div class="tag-item" slot="reference">
            <button v-if="tagsEmpty" class="button-new-tag">
              添加标签
            </button>
            <button
              v-else
              class="button-new-tag plus-icon el-icon-circle-plus"
            />
          </div>
        </el-popover>
      </li>
    </ul>
  </div>
</template>

<script>
function findObjectByKey(array, key, value) {
  for (var i = 0; i < array.length; i++) {
    if (array[i][key] === value) {
      return i;
    }
  }
  return -1; //not found
}

export default {
  name: "dropdownTags",
  props: {
    selTagList: Array,
    tagList: Array,
  },
  mounted: function() {
    for (let i = 0; i < this.tagList.length; i++) {
      let lv = 1; //level的取值范围为1-6
      if (this.tagList[i].level <= 6 || this.tagList[i].level > 1) {
        lv = this.tagList[i].level;
      }
      this.dynamicTags.push({
        name: this.tagList[i].name,
        check: false,
        level: lv,
      });
    }

    for (let i = 0; i < this.selTagList.length; i++) {
      let tag = this.getTagInfo(this.selTagList[i]);
      if (tag) {
        this.tempArr.push({ name: tag.name, level: tag.level });
        tag.check = true;
      }
    }
  },
  data() {
    return {
      inputValue: "",
      dynamicTags: [], //{name,check,level}
      hoverItem: "",
      tempArr: [],
    };
  },
  computed: {
    tagsEmpty: function() {
      return this.tempArr.length == 0;
    },
    selectedTags: function() {
      return this.dynamicTags.filter((item) => {
        return item.check == true;
      });
    },
    dynamicTagsWithoutState: function() {
      let arr = [];
      for (let i = 0; i < this.dynamicTags.length; i++) {
        arr.push(this.dynamicTags[i].name);
      }
      return arr;
    },
    searchTags: function() {
      let arr = [];
      for (let i = 0; i < this.dynamicTags.length; i++) {
        for (let key in this.dynamicTags[i]) {
          if (
            key == "name" &&
            this.dynamicTags[i][key].indexOf(this.inputValue) > -1
          ) {
            arr.push(this.dynamicTags[i]);
          }
        }
      }
      return arr;
    },
  },
  watch: {
    tempArr: function() {
      this.$emit("change", this.tempArr, this.dynamicTagsWithoutState);
    },
    dynamicTags: function() {
      this.$emit("change", this.tempArr, this.dynamicTagsWithoutState);
    },
  },
  methods: {
    handleClose(tag) {
      this.tempArr.splice(findObjectByKey(this.tempArr, "name", tag.name), 1);

      for (let i = 0; i < this.dynamicTags.length; i++) {
        if (this.dynamicTags[i].name == tag.name) {
          this.dynamicTags[i].check = false;
        }
      }
    },
    addTag() {
      if (this.inputValue == "" || this.isExist(this.inputValue)) {
        return;
      }
      this.dynamicTags.push({ name: this.inputValue, check: false });
      this.inputValue = "";
    },
    selectTagItem(tag) {
      let i = this.dynamicTags.indexOf(tag);
      this.dynamicTags[i].check = !this.dynamicTags[i].check;
      if (this.dynamicTags[i].check == true) {
        this.tempArr.push({ name: tag.name, level: tag.level });
      } else {
        this.tempArr.splice(findObjectByKey(this.tempArr, "name", tag.name), 1);
      }
    },
    mouseOver(tag) {
      this.hoverItem = tag.name;
    },
    mouseLeave() {
      this.hoverItem = "";
    },
    deleteItem(tag) {
      this.dynamicTags.splice(this.dynamicTags.indexOf(tag), 1);
      this.tempArr.splice(this.tempArr.indexOf(tag.name), 1);
    },
    enterSearch() {
      if (this.searchTags.length > 0) {
        let tag = this.searchTags[0];
        this.selectTagItem(tag);
      }
    },
    isExist(tag_name) {
      for (let i = 0; i < this.dynamicTags.length; i++) {
        if (this.dynamicTags[i].name == tag_name) {
          return true;
        }
      }
      return false;
    },
    getTagInfo(tag_name) {
      for (let i = 0; i < this.dynamicTags.length; i++) {
        if (this.dynamicTags[i].name == tag_name) {
          return this.dynamicTags[i];
        }
      }
    },
  },
};
</script>

<style lang="scss" scoped>
.container {
  display: flex;
  flex-wrap: wrap;
  align-items: center;

  .tag-picker-list {
    list-style: none;
    margin-right: 10px;
    margin-bottom: 10px;
    display: flex;
    align-items: center;
    flex-wrap: wrap;

    .tag-item {
      margin-right: 10px;
      margin-bottom: 10px;
      display: flex;
      align-items: center;
      height: 28px;
      border: none;
      border-radius: 28px;
      padding: 0 12px;

      &:hover {
        .tag-remove {
          display: inline;
        }
      }

      .tag-remove {
        margin-left: 3px;
        display: none;
      }
    }
    .tag-level-1 {
      color: #0171c2;
      background-color: #f2fbff;
      .tag-remove {
        color: #004f8a;
      }
    }

    .tag-level-2 {
      color: #038a24;
      background-color: #edffed;
      .tag-remove {
        color: #006d1f;
      }
    }
    .tag-level-3 {
      color: #008074;
      background-color: #e5f5f2;
      .tag-remove {
        color: #006a67;
      }
    }
    .tag-level-4 {
      color: #3d3c9d;
      background-color: #f5f6ff;
      .tag-remove {
        color: #2e2a75;
      }
    }
    .tag-level-5 {
      color: #d46b08;
      background-color: #fff7e6;
      .tag-remove {
        color: #ad4e01;
      }
    }
    .tag-level-6 {
      color: #c21c07;
      background-color: #ffeded;
      .tag-remove {
        color: #9a1604;
      }
    }
  }

  .button-new-tag {
    position: relative;
    border: none;
    display: flex;
    align-items: center;
    height: 68px;
    line-height: 30px;
    padding-top: 0;
    padding-bottom: 0;
    background-color: Transparent;
    outline: none;
    color: #bfbfbf;

    &:hover {
      color: #1b9aee;
    }
  }

  .plus-icon {
    font-size: 1.2rem;
  }
}

.popover {
  margin: 0;
  padding: 0;
  width: 250px;
  .input-div {
    display: flex;
    border-bottom: 1px solid #e5e5e5;
    justify-content: space-between;
    .tag-input {
      border: none;
      padding: 8px 18px;
      height: 30px;
      line-height: 26px;
      outline: none;
    }

    .btn-in-input {
      width: 28px;
      // padding-right: 0;
      // display: flex;
      button {
        background-color: Transparent;
        outline: none;
        border: none;
        font-size: 1.3rem;
        color: #1b9aee;
      }
    }
  }

  .tag-list {
    list-style: none;
    padding: 4px 0;
    max-height: 208px;
    overflow-y: scroll;
    white-space: nowrap;

    &::-webkit-scrollbar-thumb {
      background-color: #8c8c8c;
      border-left: 2px solid transparent;
    }

    &::-webkit-scrollbar-track {
      background-color: #e5e5e5;
      border-left: 2px solid transparent;
    }

    &::-webkit-scrollbar {
      width: 7px;
    }

    .tag-circle-wrap {
      padding-right: 8px;
    }

    .tag-circle {
      width: 8px;
      height: 8px;
      border-radius: 50%;
    }

    .tag-name {
      flex: 1;
      font-size: 14px;
      color: #595959;
      overflow: hidden;
      text-overflow: ellipsis;
      white-space: nowrap;
    }

    .tag-checked {
      margin-right: 0;
      font-size: 16px;
      color: #8c8c8c;
    }
  }

  .tag-list-item {
    margin-left: 0;
    line-height: 40px;
    display: flex;
    cursor: pointer;
    align-items: center;
    padding: 0 16px;

    &:hover {
      background-color: #f7f7f7;
    }

    .level-1 {
      background-color: rgb(27, 154, 238);
    }

    .level-2 {
      background-color: rgb(21, 173, 49);
    }

    .level-3 {
      background-color: rgb(0, 156, 149);
    }

    .level-4 {
      background-color: rgb(106, 112, 184);
    }

    .level-5 {
      background-color: rgb(250, 140, 21);
    }

    .level-6 {
      background-color: rgb(230, 36, 18);
    }
  }
}
</style>
