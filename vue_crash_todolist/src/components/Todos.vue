<template>
  <div>
      <div v-for="todo in todos" v-bind:key="todo">
          <p><input type="checkbox" v-model="todo.completed"/>{{todo.title}}</p>    
      </div>
  </div>
</template>

<script>
export default {
    name:"Todos",
    props:{
        todos:Array
    }
}
</script>

<style scoped>

</style>>