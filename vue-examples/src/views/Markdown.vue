<template>
  <div class="editor">
    <textarea class="col_1" :value="input" @input="update"></textarea>
    <div class="col_2" v-html="compiledMarkdown"></div>
  </div>
</template>

<script>
import _ from "lodash";
import marked from "marked";

export default {
  name: "Markdown",
  components: {},
  data() {
    return {
      input: "# hello",
    };
  },
  computed: {
    /*
    计算属性是基于它们的响应式依赖进行缓存的
    如果计算属性getter没有响应式依赖，计算属性就不会更新
    */
    compiledMarkdown: function() {
      return marked(this.input, { sanitize: true });
    },
  },
  methods: {
    // 300ms 刷新一次，从input事件获得目标控件的值
    update: _.debounce(function(e) {
      this.input = e.target.value;
    }, 300),
  },
};
</script>

<style scoped>
.editor {
  display: flex;
  width: 100%;
  height: 600px;
}
.col_1 {
  width: 49%;
  resize: vertical;
}
.col_2 {
  width: 50%;
}
</style>
