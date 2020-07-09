<template>
  <div class="container">
    <div class="top">
      <img v-if="currentUrl" class="preview" :src="currentUrl" />
    </div>
    <div class="bottom">
      <ul class="list">
        <li class="list-item" v-for="(url, index) in urls" :key="index">
          <div class="img-wrap">
            <img
              class="img"
              draggable="true"
              @dragstart="onDragStart($event, index)"
              @dragend="onDragEnd"
              @drop="onDrop($event, index)"
              @dragover="onDragOver"
              @click="onSwitch(index)"
              :src="url"
            />
            <i class="image-del el-icon-close" @click="delImg(index)"></i>
          </div>
        </li>
        <li class="list-item">
          <div class="img-wrap">
            <button class="upload-img el-icon-plus" @click="$refs.fileInput.click()"></button>
          </div>
        </li>
      </ul>
    </div>
    <input style="display: none;" type="file" ref="fileInput" @change="onFileChanged" />
  </div>
</template>

<script>

function swap(arr, i, j) {
  let temp = arr[i];
  arr[i] = arr[j];
  arr[j] = temp;
}
export default {
  name: "DragDrop",
  props: {},
  data: function() {
    return {
      urls: [],
      drag_s: 0,
      currentUrl: ""
    };
  },
  methods: {
    onDragStart: function(event, index) {
      this.drag_s = index;
      // Make it half transparent
      event.target.style.opacity = 0.5;
    },
    onDragEnd: function(event) {
      event.target.style.opacity = "";
    },
    onDrop: function(event, index) {
      let tempArr = [...this.urls];
      swap(tempArr, this.drag_s, index);
      this.urls = tempArr;
      this.onSwitch(index);
      this.OnUpdate();
    },
    onDragOver: function(event) {
      event.preventDefault();
    },
    onFileChanged: function(event) {
      let file = event.target.files[0];
      let url = URL.createObjectURL(file);
      if (url) {
        this.currentUrl = url;
        this.urls.push(url);
        this.OnUpdate();
      }
    },
    delImg(index) {
      this.urls.splice(index, 1);
      this.OnUpdate();
    },
    onSwitch(index) {
      this.currentUrl = this.urls[index];
    },
    OnUpdate() {
      this.$emit("update", this.urls);
    }
  }
};
</script>

<style scoped>
.container {
  width: 100%;
  height: 100%;
  text-align: center;
  box-sizing: border-box;
}
.top {
  width: 100%;
  height: 300px;
  box-sizing: border-box;
  border: solid 1px rgb(204, 204, 204);
  margin-bottom: 10px;
  margin-left: auto;
  margin-right: auto;
  padding: 3px;
}

.bottom {
  width: 100%;
  height: 20%;
}

.list {
  list-style-type: none;
  display: flex;
  align-items: center;
  flex-wrap: wrap;
  padding-inline-start: 0px;
  margin-block-start: 0px;
  height: 100%;
}

.list .list-item {
  padding: 5px;
}

.list .upload-img {
  width: 100%;
  height: 100%;
  background: transparent;
  outline: none;
  border: none;
  font-size: 3em;
  color: darkgray;
}

.img-wrap {
  height: 62px;
  width: 62px;
  display: flex;
  align-items: center;
  justify-content: space-around;
  border: 1px dashed #d0d3c9;
  padding: 3px;
  position: relative;
}

.image-del {
  position: absolute;
  top: 5px;
  right: 5px;
  cursor: pointer;
  opacity: 0.75;
  color: #606266;
  display: none;
}

.img-wrap:hover > .image-del {
  display: inline;
}

.preview {
  width: 100%;
  height: 100%;
  object-fit: scale-down;
}

.img {
  width: 100%;
  height: 100%;
  object-fit: contain;
  cursor: pointer;
}
</style>
