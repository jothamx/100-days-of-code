<template>
  <div>
    <!-- v-on:submit.prevent提交事件不再重载页面 -->
    <form v-on:submit.prevent="onSubmit">
      <input type="text" v-model="text" placeholder="Add todo..." required/>
      <input type="submit" value="Submit" />
    </form>
  </div>
</template>

<script>
import { v4 as uuidv4 } from 'uuid';

export default {
  name: "AddTodo",
  data() {
    return {
      text: "",
    };
  },
  methods: {
    onSubmit() {
      console.log("submit");
      const newTodo = {
        id: uuidv4(),
        title: this.text,
        completed: false,
      };
      this.$emit("add-todo", newTodo);
      this.text = "";
    },
  },
};
</script>

<style scoped>
form {
  display: flex;
}

input[type="text"] {
  flex: 10;
  padding: 5px;
}

input[type="submit"] {
  flex: 2;
}
</style>
