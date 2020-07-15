<template>
  <div class="upload-queue">
    <draggable
      v-model="imgList"
      @start="drag=true"
      @end="drag=false"
      class="el-upload-list el-upload-list--picture-card"
    >
      <div class="el-upload-list__item" v-for="(item, index) in imgList" :key="index">
        <img :src="item" class="el-upload-list__item-thumbnail" />
        <span class="el-upload-list__item-actions">
          <span class="el-upload-list__item-preview" @click="handlePreview(item)">
            <i class="el-icon-zoom-in"></i>
          </span>
          <span class="el-upload-list__item-delete" @click="handleRemove(item, index)">
            <i class="el-icon-delete"></i>
          </span>
        </span>
      </div>
    </draggable>
    <el-upload
      :multiple="true"
      ref="upload"
      class="el-upload el-upload--picture-card"
      action="#"
      accept="image/*, video/*"
      :auto-upload="false"
      :show-file-list="false"
      :on-change="change"
    >
      <i class="el-icon-plus"></i>
    </el-upload>

    <el-dialog :visible.sync="dialogVisible">
      <img width="100%" :src="dialogImageUrl" />
    </el-dialog>
    <button @click="deleteOne">111</button>
  </div>
</template>

<script>
import draggable from "vuedraggable";
export default {
  name: "UploadSortable",
  components: { draggable },
  props: {
    list: {
      type: Array,
      default: () => []
    }
  },
  computed: {
    imgList: {
      get() {
        return this.list;
      },
      set(val) {
        this.list.splice(0, this.list.length, ...val);
      }
    }
  },
  data() {
    return {
      drag: false,
      dialogImageUrl: "",
      dialogVisible: false
    };
  },

  methods: {
    deleteOne() {
      //https://github.com/natee/el-upload-sortable
      //操作控件内的文件列表实现
      this.$refs.upload.uploadFiles.splice(0, 1);
    },
    beforeUpload(file) {
      const isValidFormat = ["image/jpeg", "image/png"].indexOf(file.type) > -1;
      const isLt2M = file.size / 1024 / 1024 < 2; // 2M
      if (!isValidFormat) {
        this.$message.error("图片只能是 JPG或PNG 格式!");
      } else if (!isLt2M) {
        this.$message.error("图片大小不能超过 2MB!");
      }
      const maxLt = this.max === 1 && this.imgList.length > 0;
      if (maxLt) {
        this.$message.error("只能上传一张图片，请删除后再上传!");
      }

      return isValidFormat && isLt2M && !maxLt;
    },
    change(file, fileList) {
      console.log(this.$refs.upload.uploadFiles);

      console.log(fileList);
      this.imgList.push(URL.createObjectURL(file.raw));
      //this.$refs.upload.clearFiles();
    },
    handleSuccess(res, file) {
      const params = this.param.split(".");
      let url = res;
      params.forEach(item => {
        url = url[item];
      });
      this.imgList.push(url ? url : URL.createObjectURL(file.raw));
      this.$emit("change", this.imgList);
    },
    handleError(err) {
      this.$message.error(`上传失败!${err}`);
    },
    handleRemove(file, index) {
      this.imgList.splice(index, 1);
      this.$emit("change", this.imgList);
    },
    handlePreview(url) {
      this.dialogImageUrl = url;
      this.dialogVisible = true;
    }
  }
};
</script>

<style lang="scss" scoped>
.upload-queue {
  .el-upload-list__item:hover {
    .el-upload-list__item-actions {
      display: block;
      opacity: 1;
    }
  }
  .el-upload--picture-card .el-upload--text {
    width: 100%;
  }
}
</style>