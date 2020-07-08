<template>
  <div class="container">
    <ul class="vehicles">
      <li v-for="(url,index) in urls" :key="index">
        <div class="img-wrap">
          <img
            class="img"
            draggable="true"
            @dragstart="onDragStart($event,index)"
            @dragend="onDragEnd"
            @drop="onDrop($event,index)"
            @dragover="onDragOver"
            :src="url"
          />
        </div>
      </li>
    </ul>
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
      urls: [
        "https://cdn.glitch.com/20f985bd-431d-4807-857b-e966e015c91b%2Ftruck-clip-art-fire-truck4.png?1519011787956",
        "https://cdn.glitch.com/20f985bd-431d-4807-857b-e966e015c91b%2Fambulance5.png?1519011787610",
        "https://cdn.glitch.com/20f985bd-431d-4807-857b-e966e015c91b%2Fcar-20clip-20art-1311497037_Vector_Clipart.png?1519011788408",
        "https://cdn.glitch.com/20f985bd-431d-4807-857b-e966e015c91b%2Fbicycle-20clip-20art-bicycle3.png?1519011787816"
      ],
      drag_s: 0
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
    },
    onDragOver: function(event) {
      event.preventDefault();
    }
  }
};
</script>

<style scoped>
.container {
  width: 80%;
  margin: auto;
}
.vehicles {
  list-style-type: none;
  display: flex;
  align-items: center;
  justify-content: space-evenly;
}
.img-wrap {
  height: 200px;
  width: 200px;
  display: flex;
  align-items: center;
  justify-content: space-evenly;
  border: 1px dashed #9abe36;
  padding: 10px;
}

.img {
  cursor: pointer;
}
</style>
