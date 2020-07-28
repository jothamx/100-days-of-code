<template>
  <div id="app">
    
    <el-tag class="tag" v-for="(item,index) of colorTags" :key="index">{{item}}</el-tag>
    
    <el-popover placement="right-start" style="min-height:500px;">
      <color-picker :colorList="color" @change="onChange"></color-picker>
      <el-button slot="reference">选择颜色</el-button>
    </el-popover>
  </div>
</template>

<script>
import ColorPicker from "./components/ColorPicker.vue";

export default {
  name: "App",
  components: {
    ColorPicker,
  },
  data: function () {
    return {
      color: [
        { name: "栗色", value: "#800000", catalog: "红色" },
        { name: "暗红", value: "#8B0000", catalog: "红色" },
        { name: "火砖色", value: "#B22222", catalog: "红色" },
        { name: "深红", value: "#DC143C", catalog: "红色" },
        { name: "大红", value: "#FF0000", catalog: "红色" },

        { name: "深粉", value: "#FF1493", catalog: "桃红" },
        { name: "紫红", value: "#FF00FF", catalog: "桃红" },
        { name: "粉红", value: "#FFC0CB", catalog: "桃红" },
        { name: "浅粉色", value: "#FFB6C1", catalog: "桃红" },
        { name: "浅紫粉", value: "#D87093", catalog: "桃红" },

        { name: "墨绿", value: "#2F4F4F", catalog: "黄绿" },
        { name: "深橄榄绿", value: "#556B2F", catalog: "黄绿" },
        { name: "橄榄色", value: "#808000", catalog: "黄绿" },
        { name: "森林绿", value: "#228B22", catalog: "黄绿" },
        { name: "黄绿", value: "#9ACD32", catalog: "黄绿" },
      ],
      colorTags: [],
    };
  },
  methods: {
    onChange: function (element) {
      if (this.colorTags.indexOf(element.name)!=-1) {
        console.log(`delete ${element.name}`);
       this.colorTags.splice(this.colorTags.indexOf(element.name),1);
      } else {
         this.colorTags.push(element.name);
        console.log(`add ${element.name}`);
      }
    },
  },
};
</script>

<style>
#app {
  font-family: Avenir, Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: left;
  color: #2c3e50;
  width: 80%;
  margin-top: 60px;
  margin-left: 100px;
  display: flex;
}
.tag{
  margin-right: 20px;
}
</style>
