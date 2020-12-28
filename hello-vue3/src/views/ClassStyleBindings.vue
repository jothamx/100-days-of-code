<template>
    <view class="container">
        <view class="row">
            <!-- Object Syntax -->
            <view
                class="static"
                :class="{ active: isActive, 'text-danger': hasError }"
            >
                Object Syntax
            </view>
            <!-- Array Syntax -->
            <view
                class="static"
                :class="['active', hasError ? 'text-danger' : '']"
            >
                Array Syntax
            </view>
        </view>
        <view class="row">
            <!-- Object Syntax -->
            <view
                class="static"
                :style="{
                    color: fontColor,
                    border: borderStyle,
                    fontSize: fontSize + 'px',
                }"
            >
                Object Syntax
            </view>
            <!-- Array Syntax -->
            <view class="static" :style="[baseStyleObject, borderStyleObject]">
                Array Syntax
            </view>
        </view>
    </view>
</template>

<script>
export default {
    data() {
        return {
            isActive: false,
            hasError: true,
            fontColor: "red",
            fontSize: 20,
            borderStyle: "solid 1px #ff9966",
            baseStyleObject: {
                "font-size": "20px",
                color: "#99cc33",
            },
            borderStyleObject: {
                padding: "10px 20px",
                border: "solid 1px #ff9966",
            },
        };
    },
};
</script>

<style>
.container {
    display: flex;
    flex-direction: column;
}

.container .row {
    width: 100%;
    padding: 30px;
}

.static {
    width: 100px;
    height: 30px;
}

.active {
    border: solid 1px #99cc33;
}
.text-danger {
    color: #cc3300;
}
</style>