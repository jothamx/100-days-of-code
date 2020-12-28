<template>
    <view>{{ count }}</view>
    <button @click="debouncedClick">click me</button>
</template>

<script>
import _ from "lodash";
export default {
    created() {
        this.debouncedClick = _.debounce(this.click, 500);
    },
    unmounted() {
        this.debouncedClick.cancel();
    },
    data() {
        return {
            count: 1,
        };
    },
    methods: {
        click() {
            this.count++;
        },
    },
};
</script>

<style>
</style>