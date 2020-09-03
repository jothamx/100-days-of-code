<template>
	<view class="HMfilterDropdown" :class="{'setDropdownBottom':maskVisibility}" :style="{'top':menuTop+'rpx'}"
	 @touchmove.stop.prevent="discard" @tap.stop="discard">
		<view class="nav">
			<block v-for="(item,index) in menu" :key="index">
				<view class="first-menu" :class="{'on':showPage==index}" @tap="togglePage(index)">
					<text class="name">{{item.name}}</text>
					<text class="iconfont triangle" :style="'transform:rotate('+triangleDeg[index]+'deg);'"></text>
				</view>
			</block>
		</view>
		<view class="mask" :class="{'show':isShowMask,'hide':maskVisibility!=true}" @tap="togglePage(showPage)"></view>
		<block v-for="(page,page_index) in subData" :key="page_index">
			<view class="sub-menu-class" :class="{'show':showPage==page_index,'hide':pageState[page_index]!=true}">
				<block v-if="page.type=='hierarchy'&& page.submenu.length>0">
					<scroll-view class="sub-menu-list alone" :scroll-y="true">
						<block v-for="(sub,index) in page.submenu" :key="index">
							<view class="sub-menu" :id="'first_id'+index" :class="{'on':activeMenuArr[page_index][0]==index}" @tap="selectHierarchyMenu(page_index,index)">
								<view class="menu-name">
									<text>{{sub.name}}</text>
									<text class="iconfont selected"></text>
								</view>
							</view>
						</block>
					</scroll-view>
				</block>
				<block v-if="page.type=='tag'">
					<scroll-view class="sub-menu-list alone" :scroll-y="true">
						<block v-for="(sub,index) in page.submenu" :key="index">
							<view v-if="sub.submenu.length===0" class="sub-menu" :class="{'on':activeMenuArr[page_index][0]===index}" :id="'first_id'+index"
							 @tap="selectTagLabel(page_index,index,null)">
								<view class="menu-name">
									<text>{{sub.name}}</text>
									<text class="iconfont selected"></text>
								</view>
							</view>
							<view v-else class="sub-menu" :class="{'on':activeMenuArr[page_index][0]===index}" :id="'first_id'+index">
								<view class="menu-name">
									<text>{{sub.name}}</text>
									<text class="iconfont selected"></text>
								</view>
							</view>
							<view style="display: flex;flex-direction: column;padding-left:20px;">
								<view class="sub-menu" :class="{'on':activeMenuArr[page_index][index][0]===second_index}" v-for="(label,second_index) in sub.submenu"
								 :key="second_index" @tap="selectTagLabel(page_index,index,second_index)">
									<view class="menu-name">
										<text>{{label.name}}</text>
										<text class="iconfont selected"></text>
									</view>
								</view>
							</view>
						</block>
					</scroll-view>
				</block>
			</view>
		</block>
	</view>
</template>
<script>
	export default {
		data() {
			return {
				subData: [], //菜单数据
				menu: [], //顶部横条数据
				showPage: -1, //菜单页面显示/隐藏动画控制
				pageState: [], //页面的状态
				activeMenuArr: [], //UI状态
				shadowActiveMenuArr: [], //记录选中
				defaultActive: [],
				triangleDeg: [], //小三角形的翻转动画控制
				isShowMask: false, //遮罩层显示/隐藏动画控制
				maskVisibility: false, //遮罩层显示/隐藏状态
				//滚动区域定位
				firstScrollInto: 0,
				secondScrollInto: 0,
				componentTop: 0, //组件top
				isReadNewSelect: false,
			};
		},
		props: {
			menuTop: {
				value: Number,
				default: false,
			},
			filterData: {
				value: Array,
				default: [],
			},
			defaultSelected: {
				value: Array,
				default: [],
			},
			updateMenuName: {
				value: Boolean,
				default: true,
			},
			dataFormat: {
				value: String,
				default: "Array",
			},
			defaultSelected:{
				value: Array,
				default: []
			}
		},
		watch: {
			filterData: {
				handler() {
					this.initMenu(); //filterData重新赋值初始化菜单
				},
				immediate: true,
			},
			defaultSelected(newVal) {
				if (newVal.length == 0) {
					return;
				}
				this.defaultActive = JSON.parse(JSON.stringify(newVal));
				this.activeMenuArr = JSON.parse(JSON.stringify(newVal));
				this.shadowActiveMenuArr = JSON.parse(JSON.stringify(newVal));
				if (this.updateMenuName) {
					this.setMenuName();
				}
			},
		},
		methods: {
			initMenu() {
				let tmpMenuActiveArr = [];
				let tmpMenu = [];
				for (let i = 0; i < this.filterData.length; i++) {
					let tmpitem = this.filterData[i];
					tmpMenu.push({
						//如果没有设置name，则取第一个菜单作为menu.name
						name: tmpitem.name || tmpitem.submenu[0].name,
						type: tmpitem.type,
					});
					//初始化选中项数组-ui状态
					tmpMenuActiveArr.push(this.processActive(tmpitem));
					//初始化角度数组
					this.triangleDeg.push(0);
					//初始化控制显示状态数组
					this.pageState.push(false);
					//递归处理子菜单数据
					tmpitem = this.processSubMenu(tmpitem);
					this.filterData[i] = tmpitem;
				}
				this.menu = tmpMenu;
				//初始化选中项数组
				tmpMenuActiveArr =
					this.defaultActive.length > 0 ?
					this.defaultActive :
					this.activeMenuArr.length > 0 ?
					this.activeMenuArr :
					tmpMenuActiveArr;
				this.defaultActive = [];
				this.activeMenuArr = JSON.parse(JSON.stringify(tmpMenuActiveArr));
				this.shadowActiveMenuArr = JSON.parse(JSON.stringify(tmpMenuActiveArr));
				//加载菜单数据
				this.subData = this.filterData;
				//设定顶部菜单名字
				if (this.updateMenuName) {
					this.setMenuName();
				}
			},
			setMenuName() {
				for (var i = 0; i < this.activeMenuArr.length; i++) {
					let row = this.activeMenuArr[i];
					if (this.subData[i].type == "hierarchy") {
						if (typeof row[0] == "number") {
							let tmpsub = this.subData[i].submenu[row[0]];
							if (row.length > 1) {
								tmpsub = tmpsub.submenu[row[1]];
								if (row.length > 2) {
									tmpsub = tmpsub.submenu[row[2]];
								}
							}
							this.menu[i].name = tmpsub.name;
						} else {
							this.menu[i].name = this.subData[i].name;
						}
					}
				}
			},

			selectHierarchyMenu(page_index, level1_index) {
				this.activeMenuArr[page_index][0] = level1_index;
				if (this.updateMenuName) {
					this.menu[page_index].name = this.subData[page_index].submenu[level1_index].name;
				}

				this.shadowActiveMenuArr[page_index] = JSON.parse(
					JSON.stringify(this.activeMenuArr[page_index])
				);
				this.togglePage(this.showPage);
			},
			selectTagLabel(page_index, index, second_index) {
				for (let i = 0; i < this.activeMenuArr[page_index].length; ++i) {
					this.activeMenuArr[page_index][i] = [];
				}
				if (second_index === null) {
					this.activeMenuArr[page_index][0] = index;
					if (this.updateMenuName) {
						this.menu[page_index].name = this.subData[page_index].submenu[index].name;
					}
				} else {
					this.activeMenuArr[page_index][index][0] = second_index;
					if (this.updateMenuName) {
						this.menu[page_index].name = this.subData[page_index].submenu[index].submenu[second_index].name;
					}
				}
				this.shadowActiveMenuArr[page_index] = JSON.parse(
					JSON.stringify(this.activeMenuArr[page_index])
				);
				this.togglePage(this.showPage);
				this.$forceUpdate();
			},
			//菜单开关
			togglePage(index) {
				if (index == this.showPage) {
					this.hidePageLayer(true);
					this.hideMask();
					this.showPage = -1;
				} else {
					if (this.showPage > -1) {
						this.hidePageLayer(false);
					}
					this.showPageLayer(index);
					this.showMask();
				}
			},
			//hide遮罩层
			hideMask() {
				this.isShowMask = false;
				setTimeout(() => {
					this.maskVisibility = false;
				}, 200);
			},
			//show遮罩层
			showMask() {
				this.maskVisibility = true;
				this.$nextTick(() => {
					setTimeout(() => {
						this.isShowMask = true;
					}, 0);
				});
			},
			//hide菜单页
			hidePageLayer(isAnimation) {
				this.triangleDeg[this.showPage] = 0;
				let tmpIndex = this.showPage;
				if (isAnimation) {
					setTimeout(() => {
						this.pageState.splice(tmpIndex, 1, false);
					}, 200);
					this.confirm();
				} else {
					this.pageState.splice(tmpIndex, 1, false);
				}
				this.firstScrollInto = null;
				this.secondScrollInto = null;
			},
			confirm() {
				let index = JSON.parse(JSON.stringify(this.shadowActiveMenuArr));
				let value = JSON.parse(JSON.stringify(this.shadowActiveMenuArr));

				//对结果做一下处理
				index.forEach((item, i) => {
					if (typeof item[0] == "object") {
						//针对筛选结果过一个排序
						item.forEach((s, j) => {
							if (s != null) {
								s.sort((val1, val2) => {
									return val1 - val2;
								});
								item[j] = s;
								s.forEach((v, k) => {
									value[i][j][k] =
										v == null || v >= this.subData[i].submenu[j].submenu.length ?
										null :
										this.subData[i].submenu[j].submenu[v].value;
									if (this.subData[i].type == "radio" && value[i][j][k] == null) {
										value[i][j] = [];
										index[i][j] = [];
									}
								});
							}
						});
					} else {
						let submenu = this.subData[i].submenu[item[0]];
						value[i][0] = submenu.value;
						if (value[i].length >= 2 && item[1] != null) {
							if (submenu.submenu.length > 0) {
								submenu = submenu.submenu[item[1]];
								value[i][1] = submenu.hasOwnProperty("value") ?
									submenu.value :
									null;
							} else {
								value[i][1] = null;
							}
							if (value[i].length >= 3 && item[2] != null) {
								if (submenu.submenu.length > 0) {
									submenu = submenu.submenu[item[2]];
									value[i][2] = submenu.hasOwnProperty("value") ?
										submenu.value :
										null;
								} else {
									value[i][2] = null;
								}
							}
						}
					}
					index[i] = item;
				});
				// 输出
				this.$emit("confirm", {
					index: index,
					value: value,
				});
			},
			//show菜单页
			showPageLayer(index) {
				this.processPage(index);
				this.pageState.splice(index, 1, true);
				this.$nextTick(() => {
					setTimeout(() => {
						this.showPage = index;
					}, 0);
				});
				this.triangleDeg[index] = 180;
			},
			reloadActiveMenuArr() {
				for (let i = 0; i < this.filterData.length; i++) {
					let tmpitem = this.filterData[i];
					let tmpArr = this.processActive(tmpitem);
					tmpitem = this.processSubMenu(tmpitem);
					if (this.activeMenuArr[i].length != tmpArr.length) {
						this.filterData[i] = tmpitem;
						this.activeMenuArr.splice(i, 1, JSON.parse(JSON.stringify(tmpArr)));
						this.shadowActiveMenuArr.splice(
							i,
							1,
							JSON.parse(JSON.stringify(tmpArr))
						);
					}
				}
				this.subData = this.filterData;
				this.$forceUpdate();
			},
			processPage(index) {
				//check UI控制数组，结果数组,防止传入数据层级和UI控制数组不同步
				this.reloadActiveMenuArr();
				//重置UI控制数组
				this.activeMenuArr.splice(
					index,
					1,
					JSON.parse(JSON.stringify(this.shadowActiveMenuArr[index]))
				);
				if (this.menu[index].type == "hierarchy") {
					this.$nextTick(() => {
						setTimeout(() => {
							//滚动到选中项
							this.firstScrollInto = parseInt(this.activeMenuArr[index][0]);
							this.secondScrollInto = parseInt(this.activeMenuArr[index][1]);
						}, 0);
					});
				} else if (this.menu[index].type == "tag") {
					//重载筛选页选中状态
					let level = this.shadowActiveMenuArr[index].length;
					for (let i = 0; i < level; i++) {
						let box = this.subData[index].submenu[i].submenu;
						for (let j = 0; j < box.length; j++) {
							if (this.shadowActiveMenuArr[index][i].indexOf(j) > -1) {
								this.subData[index].submenu[i].submenu[j].selected = true;
							} else {
								this.subData[index].submenu[i].submenu[j].selected = false;
							}
						}
					}
				}
			},
			processActive(tmpitem) {
				let tmpArr = [];
				if (
					tmpitem.type == "hierarchy" &&
					tmpitem.hasOwnProperty("submenu") &&
					tmpitem.submenu.length > 0
				) {
					let level = this.getMaxFloor(tmpitem.submenu);
					while (level > 0) {
						tmpArr.push(null);
						level--;
					}
				} else if (tmpitem.type == "tag") {
					let level = tmpitem.submenu.length;
					while (level > 0) {
						tmpArr.push([]);
						level--;
					}
				}
				return tmpArr;
			},
			processSubMenu(menu) {
				if (menu.hasOwnProperty("submenu") && menu.submenu.length > 0) {
					for (let i = 0; i < menu.submenu.length; i++) {
						menu.submenu[i] = this.processSubMenu(menu.submenu[i]);
					}
				} else {
					menu.submenu = [];
				}
				return menu;
			},
			//计算菜单层级
			getMaxFloor(treeData) {
				let floor = 0;
				let max = 0;

				function each(data, floor) {
					data.forEach((e) => {
						max = floor > max ? floor : max;
						if (e.hasOwnProperty("submenu") && e.submenu.length > 0) {
							each(e.submenu, floor + 1);
						}
					});
				}
				each(treeData, 1);
				return max;
			},
			discard() {},
		},
	};
</script>
<style lang="scss">
	.HMfilterDropdown {
		flex-shrink: 0;
		width: 100%;
		position: fixed;
		// position: sticky;
		z-index: 997;
		flex-wrap: nowrap;
		display: flex;
		flex-direction: row;
		top: var(--window-top);
		left: 0;
		// top:100px;
		overflow-y: hidden;

		&.setDropdownBottom {
			// height: 345px;
			bottom: 0;
		}

		view {
			display: flex;
			flex-wrap: nowrap;
		}
	}

	.region {
		flex: 1;
		height: 44px;
	}

	.nav {
		width: 100%;
		height: 44px;
		border-bottom: solid 1rpx #eee;
		z-index: 12;
		background-color: #ffffff;
		flex-direction: row;

		.first-menu {
			width: 100%;
			font-size: 13px;
			color: #757575;
			flex-direction: row;
			align-items: center;
			justify-content: center;
			transition: color 0.2s linear;

			&.on {
				color: #ec652b;

				.iconfont {
					color: #ec652b;
				}
			}

			.name {
				height: 20px;
				text-align: center;
				text-overflow: clip;
				overflow: hidden;
			}

			.iconfont {
				width: 13px;
				height: 13px;
				align-items: center;
				justify-content: center;
				transition: transform 0.2s linear, color 0.2s linear;
			}
		}
	}

	.sub-menu-class {
		width: 100%;
		position: absolute;
		left: 0;
		transform: translate3d(0, -100%, 0);
		max-height: 345px;
		background-color: #ffffff;
		z-index: 11;
		box-shadow: 0 5px 5px rgba(0, 0, 0, 0.1);
		overflow: hidden;
		flex-direction: row;
		transition: transform 0.15s linear;

		&.hide {
			display: none;
		}

		&.show {
			transform: translate3d(0, calc(44px + 1rpx), 0);
		}
	}

	.sub-menu-list {
		width: 100%;
		height: 345px;
		flex-direction: column;

		.sub-menu {
			min-height: 44px;
			font-size: 13px;
			flex-direction: column;
			padding-right: 15px;

			>.menu-name {
				height: 44px;
				flex-direction: row;
				align-items: center;
				justify-content: space-between;

				>.iconfont {
					display: none;
					font-size: 18px;
					color: #ec652b;
				}
			}
		}

		&.first {
			flex-shrink: 0;
			width: 236rpx;
			background-color: #f0f0f0;

			.sub-menu {
				padding-left: 15px;

				&.on {
					background-color: #fff;
				}
			}
		}

		&.alone {
			max-height: 345px;
			min-height: 170px;
			height: auto;

			.sub-menu {
				min-height: calc(44px - 1rpx);
				margin-left: 15px;
				border-bottom: solid 1rpx #e5e5e5;

				&.on {
					color: #ec652b;

					>.menu-name {
						>.iconfont {
							display: block;
						}
					}
				}
			}
		}

		&.not-first {
			.sub-menu {
				min-height: calc(44px - 1rpx);
				margin-left: 15px;
				border-bottom: solid 1rpx #e5e5e5;

				>.menu-name {
					height: calc(44px - 1rpx);

					>.iconfont {
						display: none;
						font-size: 18px;
						color: #ec652b;
					}
				}

				&.on {
					color: #ec652b;

					>.menu-name {
						>.iconfont {
							display: block;
						}
					}
				}

				.more-sub-menu {
					flex-direction: row;
					flex-wrap: wrap;
					padding-bottom: 9px;

					>text {
						height: 30px;
						border-radius: 3px;
						background-color: #f5f5f5;
						color: #9b9b9b;
						margin-bottom: 6px;
						margin-right: 6px;
						text-align: center;
						line-height: 30px;
						border: solid #f5f5f5 1rpx;
						flex: 0 0 calc(33.33% - 6px);
						overflow: hidden;
						font-size: 12px;

						&:nth-child(3n) {
							margin-right: 0;
						}

						&.on {
							border-color: #f6c8ac;
							color: #ec652b;
						}

						.iconfont {
							color: #9b9b9b;
						}
					}
				}
			}
		}
	}

	.filter {
		width: 100%;
		height: 345px;
		display: flex;
		flex-direction: column;
		justify-content: space-between;
		align-items: center;

		.menu-box {
			width: 698rpx;
			height: calc(345px - 75px);
			flex-shrink: 1;

			.box {
				width: 100%;
				margin-top: 16px;
				flex-direction: column;

				.title {
					width: 100%;
					font-size: 13px;
					color: #888;
				}

				.labels {
					flex-direction: row;
					flex-wrap: wrap;

					.on {
						border-color: #ec652b;
						background-color: #ec652b;
						color: #fff;
					}

					>view {
						width: 148rpx;
						height: 30px;
						border: solid 1rpx #adadad;
						border-radius: 2px;
						margin-right: 15px;
						margin-top: 8px;
						font-size: 12px;
						flex-direction: row;
						justify-content: center;
						align-items: center;

						&:nth-child(4n) {
							margin-right: 0;
						}
					}
				}
			}
		}

		.btn-box {
			flex-shrink: 0;
			width: 698rpx;
			height: 75px;
			flex-direction: row !important;
			align-items: center;
			justify-content: space-between;

			>view {
				width: 320rpx;
				height: 40px;
				border-radius: 40px;
				border: solid 1rpx #ec652b;
				align-items: center;
				justify-content: center;
			}

			.reset {
				color: #ec652b;
			}

			.submit {
				color: #fff;
				background-color: #ec652b;
			}
		}
	}

	.mask {
		z-index: 10;
		position: fixed;
		top: 0;
		left: 0;
		right: 0;
		bottom: 0;
		background-color: rgba(0, 0, 0, 0);
		transition: background-color 0.15s linear;

		&.show {
			background-color: rgba(0, 0, 0, 0.5);
		}

		&.hide {
			display: none;
		}
	}

	/* 字体图标 */
	@font-face {
		font-family: "HM-FD-font";
		src: url("data:application/x-font-woff2;charset=utf-8;base64,d09GMgABAAAAAALAAAsAAAAABpQAAAJzAAEAAAAAAAAAAAAAAAAAAAAAAAAAAAAAHEIGVgCDBgp4gQIBNgIkAwwLCAAEIAWEbQc5G8sFERWMIbIfCbbzqA4hp7InSBibVsYGb4J42o82b3e/nJlHMw/NHbGOlwKJRCRpwzPtpAECCOZubdqxjYpQLMlVg+70/08edrgQOtx2ukpVyApZn+dyehPoQObHo3O85rYx9vOjXoBxQIHugW2yIkqIW2QXcScu4jwE8CSWbKSmrqUHFwOaJoCsLM5P4haSGIxRcRHshrUGucLCVcfqI3AZfV/+USguKCwNmtsxVztDxU/n55C+3W0Z4QQpEOTNFqCBbMCAjDUWB9CIwWk87aa70cYgqLkyd3dEmm+18R8eKATEBrV7A5CulBT8dKiWOYZk412XNcDdKSEKSGODnyKIDl+dmVt9/Dx4pu/xyeutkMlHISGPTsPCnoTNP9nOT6wTtDdlO6dPr47efvj942lkYuQzrhMKEjq9N6y98P3340gmlJ/RStUD6F31CAEEPtUW94/7rf+7XgaAz57X0ZHXAGsFFwVgw38yALuMb0IBbVyNamFYEw4oKMDTj3AHRQP5Pt4dci9VwSVkRNQh5r7CLskZadhsWHhRDBsXczk8ZYk3ewnCxmQeQKa3BOHvA8XXO2j+vqRhf7CE+sPmn4anvoL29JLa4qqaUQkmoK+QG2osCckq7txi2leK86aIPyJ3eQZ8xytXYmyQ51jQndJAxIJlqiGSLsOqImiZCjTiZCJt6Lq26U2OoXqwUo0hRaAE0K5AziANy/uLVeXzWyjVqyjcoeupjxDr5MMDn8MDkLG9Aenu5ZrOSSoghAUsRmogkkahSoWAtnlUARnCkY3It0Iu7mWhdmd9Z/19BwBP6GidEi0G56opckXTGZVSPxgAAAA=");
	}

	.iconfont {
		font-family: "HM-FD-font" !important;
		font-size: 13px;
		font-style: normal;
		color: #757575;

		&.triangle {
			&:before {
				content: "\e65a";
			}
		}

		&.selected {
			&:before {
				content: "\e607";
			}
		}
	}
</style>
