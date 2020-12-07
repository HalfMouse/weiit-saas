// assembly/notice/notice.js
Component({
  /**
   * 组件的属性列表
   */
  properties: {
    pageParam: Object
  },

  /**
   * 组件的初始数据
   */
  data: {

  },
  attached: function() {
    console.log(this.data.pageParam,'公告')
  },
  /**
   * 组件的方法列表
   */
  methods: {

  }
})