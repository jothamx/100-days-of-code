<template>
    <view>
        <view>{{ fullName }}</view>
        <button @click="randomName">Random Name</button>
    </view>
    <view>
        <p>
            Ask a yes/no question:
            <input v-model="question" />
        </p>
        <p>{{ answer }}</p>
    </view>
</template>

<script>
import axios from "axios";
export default {
    computed: {
        fullName: {
            get() {
                return this.firstName + " " + this.lastName;
            },
            set(newValue) {
                const names = newValue.split(" ");
                this.firstName = names[0];
                this.lastName = names[names.length - 1];
            },
        },
    },
    watch: {
        question(newQuestion, oldQuestion) {
            if (newQuestion.indexOf("?") > -1) {
                this.getAnswer();
            }
        },
    },
    data() {
        return {
            firstName: "Foo",
            lastName: "Bar",
            question: "",
            answer: "Questions usually contain a question mark. ;-)",
        };
    },
    methods: {
        randomName() {
            const names = ["Bill Gates", "Jack Jones", "Kim Jim"];
            this.fullName =
                names[Math.floor(Math.random() * (names.length - 1))];
        },
        getAnswer() {
            this.answer = "Thinking...";
            axios
                .get("https://yesno.wtf/api")
                .then((response) => {
                    this.answer = response.data.answer;
                })
                .catch((error) => {
                    this.answer = "Error! Could not reach the API. " + error;
                });
        },
    },
};
</script>

<style>
</style>