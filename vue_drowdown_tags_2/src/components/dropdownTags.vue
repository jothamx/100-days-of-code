<template>
  <div class="container">
    <ul class="tag-picker-list">
      <li
        class="tag-item tag-level-1"
        v-show="show"
        :key="index"
        v-for="(tag, index) in selTagList"
      >
        <span>{{ tag }}</span>
        <i class="tag-remove el-icon-error" v-show="!disabled" @click="handleClose(tag)"></i>
      </li>

      <li>
        <el-popover placement="bottom-start" width="250" trigger="click" :disabled="!display">
          <div v-if="state === 'addTag'" class="popover">
            <div class="popup-menu-header">
              <el-button
                v-if="tagList.length!=0"
                icon="el-icon-arrow-left"
                class="icon-left"
                @click="goBack"
              />
              <span>新建标签</span>
              <el-button icon="el-icon-close" class="icon-right" @click="shutPopup" />
            </div>
            <div class="tag-input-div">
              <el-input class="tag-input-new" placeholder="标签名称" v-model="inputValue" />
            </div>
            <div class="create-tag-btn-wrap">
              <button
                class="create-tag-btn"
                :class="inputValue == '' ? 'create-tag-btn-disabled' : 'create-tag-btn-normal'"
                @click="addTag"
              >
                <span>创建</span>
              </button>
            </div>
          </div>
          <div v-else class="popover">
            <div class="input-div">
              <input
                class="tag-input"
                placeholder="搜索标签"
                v-model="inputValue"
                @confirm="enterSearch"
              />
              <div class="btn-in-input">
                <button class="el-icon-circle-plus" @click="addTag" />
              </div>
            </div>

            <!-- <div v-if="searchTags.length"> -->
            <div v-if="state === 'search'">
              <ul class="tag-list tag-list-scroll">
                <li
                  class="tag-list-item"
                  :key="index"
                  v-for="(tag, index) in searchTags"
                  @mouseover="mouseOver(tag)"
                  @mouseleave="mouseLeave"
                >
                  <div class="tag-circle-wrap">
                    <div class="tag-circle level-1"></div>
                  </div>
                  <div @click="selectTagItem(tag)" class="tag-name">{{ tag }}</div>
                  <span
                    v-if="tag == hoverItem"
                    @click="deleteItem(tag)"
                    class="tag-checked el-icon-delete"
                  ></span>
                  <span v-if="isChecked(tag)" class="tag-checked el-icon-check"></span>
                </li>
              </ul>
            </div>
            <div v-if="state === 'add'">
              <div class="create-tag-btn-wrap">
                <button
                  class="create-tag-btn"
                  :class="inputValue == '' ? 'create-tag-btn-disabled' : 'create-tag-btn-normal'"
                  @click="addTag"
                >
                  <span>创建</span>
                </button>
              </div>
            </div>
          </div>
          <div class="tag-item tag-item-add" slot="reference">
            <slot name="button">
              <button
                v-if="tagsEmpty"
                :disabled="disabled"
                class="button-new-tag"
                @click="display = true"
              >添加标签</button>
              <button
                v-else
                :disabled="disabled"
                class="button-new-tag plus-icon el-icon-circle-plus"
                @click="display = true"
              />
            </slot>
          </div>
        </el-popover>
      </li>
    </ul>
  </div>
</template>

<script>
export default {
  name: "DropdownTags",
  props: {
    selTagList: Array,
    tagList: Array,
    catalog: {
      type: String,
      default: ""
    },
    show: {
      type: Boolean,
      default: true
    },
    disabled: {
      type: Boolean,
      default: false
    }
  },
  data() {
    return {
      inputValue: "",
      hoverItem: "",
      isPlus: false,
      display: true
    };
  },
  computed: {
    tagsEmpty: function() {
      return this.selTagList.length == 0;
    },
    searchTags: function() {
      let arr = [];
      for (let i = 0; i < this.tagList.length; i++) {
        if (this.tagList[i].indexOf(this.inputValue) > -1) {
          arr.push(this.tagList[i]);
        }
      }
      return arr;
    },
    state: function() {
      if (this.isPlus || this.tagList.length == 0) {
        return "addTag";
      } else if (this.searchTags.length == 0) {
        return "add";
      } else {
        return "search";
      }
    }
  },
  methods: {
    handleClose(tag) {
      this.$emit("removeGoodsTag", tag, this.catalog);
    },
    addTag() {
      if (this.state == "search") {
        this.isPlus = true;
      } else {
        if (this.inputValue == "") {
          return;
        }
        this.$emit("addTag", this.inputValue, this.catalog);
        this.inputValue = "";
        this.isPlus = false;
      }
    },
    selectTagItem(tag) {
      this.$emit("selectTag", tag, this.catalog);
    },
    mouseOver(tag) {
      this.hoverItem = tag;
    },
    mouseLeave() {
      this.hoverItem = "";
    },
    deleteItem(tag) {
      this.$emit("removeTag", tag, this.catalog);
    },
    enterSearch() {
      if (this.state == "add") {
        this.addTag();
      } else if (this.searchTags.length > 0) {
        let tag = this.searchTags[0];
        this.selectTagItem(tag);
      }
    },
    isChecked(tag) {
      for (let i = 0; i < this.selTagList.length; i++) {
        if (this.selTagList[i] == tag) {
          return true;
        }
      }
      return false;
    },
    goBack() {
      this.isPlus = false;
    },
    shutPopup() {
      this.isPlus = false;
      this.display = false;
    }
  }
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
    margin-bottom: 5px;
    margin-top: 5px;
    display: flex;
    align-items: center;
    flex-wrap: wrap;
    padding-inline-start: 0px;

    .tag-item {
      margin-right: 10px;
      margin-bottom: 10px;
      display: flex;
      align-items: center;
      height: 28px;
      border: none;
      border-radius: 28px;
      padding: 0 12px;
      position: relative;

      &:hover {
        .tag-remove {
          position: absolute;
          top: 0px;
          right: 0px;
          display: inline;
        }
      }

      .tag-remove {
        position: absolute;
        display: none;
      }
    }

    .tag-item-add {
      padding: 0;
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
    padding: 0;
    font-size: inherit;
    &:disabled {
      &:hover {
        color: #bfbfbf;
      }
    }
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
      padding-right: 0;
      display: flex;
      align-items: center;
      align-content: center;

      button {
        background-color: Transparent;
        outline: none;
        border: none;
        font-size: 1.3rem;
        color: #1b9aee;
      }
    }
  }

  .tag-list-scroll {
    max-height: 208px;
    overflow-y: scroll;

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
  }

  .tag-list {
    list-style: none;
    padding: 4px 0;
    white-space: nowrap;

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
  }

  .color-picker {
    padding: 20px 16px;
    display: flex;
    justify-content: space-between;

    .color-circle {
      line-height: 20px;
      list-style: none;
    }
  }

  .color-disc {
    display: flex;
    cursor: pointer;
    align-items: center;
    width: 24px;
    height: 24px;
    border-radius: 24px;

    .icon-tick {
      width: 24px;
      height: 24px;
      font-size: 14px;
      color: #fff;
      line-height: 24px;
      text-align: center;
    }
  }

  .create-tag-btn-wrap {
    margin-left: 16px;
    margin-right: 16px;
    margin-top: 16px;

    .create-tag-btn {
      color: #fff;
      width: 100%;
      height: 36px;
      padding: 0 16px;
      border-radius: 4px;
      outline: none;
      font-size: 14px;
      border: none;
    }
    .create-tag-btn-normal {
      background-color: rgb(27, 154, 238);
    }
    .create-tag-btn-disabled {
      cursor: not-allowed;
      background-color: #bfbfbf !important;
    }
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

.popup-menu-header {
  font-size: 14px;
  font-weight: 700;
  padding-top: 10px;
  padding-bottom: 10px;
  margin: 0 11px -4px;
  color: #262626;
  text-align: center;
  padding: 12px 20px;
  position: relative;
  display: flex;

  span {
    width: 100%;
    padding-left: auto;
    padding-right: auto;
  }
  .icon-right {
    position: absolute;
    display: flex;
    align-items: center;
    align-content: center;
    right: 0;
    height: 20px;
    width: 20px;
    padding: 0;
    line-height: 14px;
  }

  .icon-left {
    position: absolute;
    display: flex;
    align-items: center;
    align-content: center;
    left: 0;
    height: 20px;
    width: 20px;
    padding: 0;
    line-height: 14px;
  }
}
.tag-input-div {
  display: flex;
  margin-top: 10px;
  margin-left: 16px;
  margin-right: 16px;
}
.tag-input-new {
  border-color: #e5e5e5;
  height: 40px;
  line-height: 26px;
}
</style>
