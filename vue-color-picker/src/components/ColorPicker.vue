<template>
  <div class="wrapper">
    <el-tabs class="tabs" type="border-card" tab-position="left">
      <el-tab-pane :label="item" :key="index" v-for="(item,index) of catalog">
        <div class="container">
          <div class="content">
            <div class="cell" v-for="(element,i) of getColors(item)" :key="i">
              <span class="color-preview" :style="{background:element.value}" @click="onClick(element)"></span>
              <span class="color-preview-label">{{element.name}}</span>
            </div>
          </div>
        </div>
      </el-tab-pane>
    </el-tabs>
  </div>
</template>

<script>
export default {
  name: "color-picker",
  props: {
    colorList: {
      type: Array,
      default: () => {
        return [];
      },
    },
  },
  computed: {
    catalog: function () {
      let data = new Set();
      this.colorList.forEach((element) => {
        data.add(element.catalog);
      });
      return data;
    },
  },
  methods: {
    getColors: function (catalog) {
      return this.colorList.filter((item) => {
        return item.catalog == catalog;
      });
    },
    onClick:function(element)
    {
      this.$emit("change",element);
    }
  },
};
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
.wrapper {
  width: 420px;
  height: 300px;
}

.tabs {
  height: 100%;
}

.container {
  height: 280px;
}
.content {
  height: 280px;
  overflow: auto;
  display: flex;
  align-content: start;
  flex-wrap: wrap;
}
.content::-webkit-scrollbar-thumb {
  background-color: #8c8c8c;
  border-left: 2px solid transparent;
}

.content::-webkit-scrollbar-track {
  background-color: #e5e5e5;
  border-left: 2px solid transparent;
}

.content::-webkit-scrollbar {
  width: 7px;
}

.cell {
  margin: 0px 5px 10px;
  display: flex;
  flex-direction: column;
}
.color-preview {
  display: inline-block;
  width: 65px;
  height: 30px;
}
.color-preview-label {
  height: 15px;
  font-size: 12px;
  margin-top: 0px;
  text-align: center;
}
</style>