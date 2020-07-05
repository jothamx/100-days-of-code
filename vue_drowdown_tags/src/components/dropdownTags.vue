<template>
  <div class="container">
    <el-tag
      :key="index"
      v-for="(tag, index) in tempArr"
      closable
      :disable-transitions="false"
      @close="handleClose(tag)"
      >{{ tag }}</el-tag
    >

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
                <div
                  class="tag-circle"
                  style="background-color: rgb(27, 154, 238);"
                ></div>
              </div>
              <div @click="selectTagItem(tag)" class="tag-name">
                {{ tag.name }}
              </div>
              <span
                v-if="tag.name == hoverItem"
                @click="deleteItem(tag)"
                class="tag-checked el-icon-delete"
              ></span>
              <span v-if="tag.check" class="tag-checked el-icon-check"></span>
            </li>
          </ul>
        </div>
      </div>
      <button v-if="tagsEmpty" class="button-new-tag" slot="reference">
        添加标签
      </button>
      <button
        v-else
        class="button-new-tag plus-icon el-icon-circle-plus"
        slot="reference"
      />
    </el-popover>
  </div>
</template>

<script>
export default {
  name: "dropdownTags",
  props: ["selTagList", "tagList"],

  mounted: function() {
    for (let i = 0; i < this.selTagList.length; i++) {
      this.tempArr.push(this.selTagList[i]);
    }
    for (let i = 0; i < this.tagList.length; i++) {
      let check = false;
      if (this.selTagList.includes(this.tagList[i])) {
        check = true;
      }
      this.dynamicTags.push({ name: this.tagList[i], check: check });
    }
  },
  data() {
    return {
      inputValue: "",
      dynamicTags: [],
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
      this.tempArr.splice(this.tempArr.indexOf(tag), 1);
      for (let i = 0; i < this.dynamicTags.length; i++) {
        if (this.dynamicTags[i].name == tag) {
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
        this.tempArr.push(tag.name);
      } else {
        this.tempArr.splice(this.tempArr.indexOf(tag.name), 1);
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
  },
};
</script>

<style scoped>
.container {
  display: flex;
  flex-wrap: wrap;
  align-items: left;
}
.el-tag {
  margin-right: 10px;
  margin-bottom: 10px;
}
.button-new-tag {
  position: relative;
  border: none;
  height: 32px;
  line-height: 30px;
  padding-top: 0;
  padding-bottom: 0;
  background-color: Transparent;
  outline: none;
  color: #bfbfbf;
}
.plus-icon {
  font-size: 1.2rem;
}
.button-new-tag:hover {
  color: #1b9aee;
}

.popover {
  margin: 0;
  padding: 0;
  width: 250px;
}

.popover .input-div {
  display: flex;
  border-bottom: 1px solid #e5e5e5;
}

.popover .tag-input {
  border: none;
  padding: 8px 18px;
  height: 30px;
  line-height: 26px;
  outline: none;
}

.popover .btn-in-input {
  width: 48px;
  display: flex;
}

.popover .btn-in-input button {
  background-color: Transparent;
  outline: none;
  border: none;
  font-size: 1.3rem;
  color: #1b9aee;
}

.popover .tag-list {
  list-style: none;
  padding: 4px 0;
  max-height: 208px;
  overflow-y: scroll;
  white-space: nowrap;
}
.popover .tag-list::-webkit-scrollbar-thumb {
  background-color: #8c8c8c;
  border-left: 2px solid transparent;
}

.popover .tag-list::-webkit-scrollbar-track {
  background-color: #e5e5e5;
  border-left: 2px solid transparent;
}
.popover .tag-list::-webkit-scrollbar {
  width: 7px;
}

.popover .tag-list-item {
  margin-left: 0;
  line-height: 40px;
  display: flex;
  cursor: pointer;
  align-items: center;
  padding: 0 16px;
}

.popover .tag-circle-wrap {
  padding-right: 8px;
}

.popover .tag-circle {
  background: #000;
  width: 8px;
  height: 8px;
  border-radius: 50%;
}

.popover .tag-name {
  flex: 1;
  font-size: 14px;
  color: #595959;
  overflow: hidden;
  text-overflow: ellipsis;
  white-space: nowrap;
}

.popover .tag-checked {
  margin-right: 0;
  font-size: 16px;
  color: #8c8c8c;
}
</style>
