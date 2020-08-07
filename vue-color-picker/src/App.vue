<template>
  <div id="app">
    <div class="container">
      <div
        class="tag"
        :style="{'background-color':item.value}"
        v-for="(item,index) of colorTags"
        :key="index"
      >
        <span
          class="tag-label"
          :style="{color:isDark(item.value,150)?'#ffffff':'#1f2d3d'}"
        >{{item.name}}</span>
        <i class="tag-remove el-icon-error" :style="{color:isDark(item.value,150)?'#ffffff':'#1f2d3d'}" @click="handleClose(item)"></i>
      </div>
      <el-popover placement="right-start" style="min-height:500px;">
        <color-picker :colorList="color" @change="onChange"></color-picker>
        <el-button class="btn" size="mini" icon="el-icon-circle-plus-outline" slot="reference"></el-button>
      </el-popover>
    </div>
  </div>
</template>

<script>
import ColorPicker from "./components/ColorPicker.vue";

function hexToRgb(hex) {
  // Expand shorthand form (e.g. "03F") to full form (e.g. "0033FF")
  var shorthandRegex = /^#?([a-f\d])([a-f\d])([a-f\d])$/i;
  hex = hex.replace(shorthandRegex, function (m, r, g, b) {
    return r + r + g + g + b + b;
  });

  var result = /^#?([a-f\d]{2})([a-f\d]{2})([a-f\d]{2})$/i.exec(hex);
  return result
    ? {
        r: parseInt(result[1], 16),
        g: parseInt(result[2], 16),
        b: parseInt(result[3], 16),
      }
    : null;
}

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

        { name: "DarkKhaki", value: "#BDB76B", catalog: "w3" },
        { name: "RosyBrown", value: "#BC8F8F", catalog: "w3" },
      ],
      colorTags: [],
    };
  },
  methods: {
    onChange(element) {
      if (this.colorTags.indexOf(element) != -1) {
        console.log(`delete ${element}`);
        this.colorTags.splice(this.colorTags.indexOf(element), 1);
      } else {
        this.colorTags.push(element);
        console.log(`add ${element}`);
      }
    },
    isDark(hex_color, n) {
      let rgb = hexToRgb(hex_color);
      var m = n || 128;
      return (rgb.r * 299 + rgb.g * 587 + rgb.b * 114) / 1000 < m;
    },
    handleClose(item)
    {
      this.colorTags.splice(this.colorTags.indexOf(item), 1);
    }
  },
};
</script>

<style scoped>
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
.container {
  width: 50%;
  display: flex;
  flex-wrap: wrap;
}

.tag {
  margin-right: 20px;
  margin-bottom: 20px;
  padding-left: auto;
  padding-right: auto;
  height: 35px;
  width: 80px;
  display: flex;
  align-items: center;
  position: relative;
}

.tag:hover .tag-remove {
  position: absolute;
  top: 0px;
  right: 0px;
  display: inline;
}

.tag-remove {
  position: absolute;
  display: none;
}

.tag-label {
  margin-left: auto;
  margin-right: auto;
}

.btn {
  font-size: 18px;
  width: 80px;
}
</style>
