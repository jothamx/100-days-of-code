<template>
    <view>
        <view class="uni-padding-wrap uni-common-mt">
            <view class="uni-title uni-common-mt">
                Vertical Scroll
                <text>\n纵向滚动</text>
            </view>
            <view>
                <scroll-view
                    :scroll-into-view="scrollId"
                    scroll-y="true"
                    class="scroll-Y"
                >
                    <view
                        v-for="(item, index) in list"
                        :key="index"
                        :id="'id' + index"
                        class="scroll-view-item"
                        :class="index % 2 == 0 ? 'uni-bg-red' : 'uni-bg-green'"
                    >
                        {{ item }}
                    </view>
                </scroll-view>
            </view>
            <view @tap="grow" class="uni-link uni-center uni-common-mt">
                增加
            </view>
            <view class="uni-common-pb"></view>
        </view>
    </view>
</template>
<script>
export default {
    data() {
        return {
            scrollId: "id0",
            list: [],
        };
    },
    methods: {
        scrollBottom: function (e) {
            this.$nextTick(function () {
                this.scrollId = "id" + (this.list.length - 1);
            });
        },
        grow: function () {
            let arr = [
                "A",
                "B",
                "C",
                "D",
                "E",
                "F",
                "G",
                "H",
                "I",
                "J",
                "K",
                "L",
                "M",
                "N",
                "O",
                "P",
                "Q",
                "R",
                "S",
                "T",
                "U",
                "V",
                "W",
                "X",
                "Y",
                "Z",
            ];
            let idx = Math.floor(Math.random() * 26);

            this.list.push(arr[idx]);
            this.scrollBottom();
        },
    },
};
</script>

<style>
.scroll-Y {
    height: calc(100vh - 150rpx - env(safe-area-inset-bottom));
}
.scroll-view_H {
    white-space: nowrap;
    width: 100%;
}
.scroll-view-item {
    height: 300rpx;
    line-height: 300rpx;
    text-align: center;
    font-size: 36rpx;
}
.scroll-view-item_H {
    display: inline-block;
    width: 100%;
    height: 300rpx;
    line-height: 300rpx;
    text-align: center;
    font-size: 36rpx;
}
</style>