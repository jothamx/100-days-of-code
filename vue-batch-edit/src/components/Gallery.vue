<template>
  <div class="gallery">
    <template v-for="(item,index) in images">
      <div class="card" :key="index" @click="onClick(item)">
        <img class="card-img" :src="item" />
        <i v-if="isEdit" class="card-circle" :class="{'card-circle-checked':isChecked(item)}"></i>
        <i v-if="isEdit" class="card-checked" :class="{ 'el-icon-success':isChecked(item)}"></i>
      </div>
    </template>
  </div>
</template>

<script>
export default {
  name: "Gallery",
  props: ["images", "isEdit", "select"],
  data: function () {
    return {};
  },
  watch: {
    isEdit: function (newVal) {
      if (!newVal) {
        this.select.splice(0, this.select.length);
      }
    },
  },
  methods: {
    onClick: function (item) {
      let i = this.select.indexOf(item);
      if (i != -1) {
        this.select.splice(i, 1);
      } else {
        this.select.push(item);
      }
    },
    isChecked: function (item) {
      return this.select.indexOf(item) != -1;
    },
  },
};
</script>

<style scoped>
.gallery {
  margin-top: 30px;
  display: flex;
  flex-wrap: wrap;
}
.card {
  width: 150px;
  height: 150px;
  margin: 0 20px 40px;
  position: relative;
}
.card-img {
  width: 100%;
  height: 100%;
}
.card-circle {
  position: absolute;
  right: 5px;
  bottom: 5px;
  height: 25px;
  width: 25px;
  border-radius: 50%;
  background-color: rgba(228, 228, 228, 0.1);
  border: 1px solid rgba(255, 255, 255, 0.5);
  box-sizing: border-box;
}
.card-circle-checked {
  background-color: rgba(255, 255, 255);
  border: none;
}

.card-checked {
  position: absolute;
  right: 7px;
  bottom: 6px;
  height: 25px;
  width: 25px;
  border-radius: 50%;
  font-size: 28px;
  line-height: 28px;
  text-align: center;
  color: rgb(0, 160, 255);
  box-sizing: border-box;
}
</style>>
