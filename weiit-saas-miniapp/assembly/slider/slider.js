// assembly/slider/slider.js
Component({
  /**
   * 组件的属性列表
   */
  properties: {

  },

  /**
   * 组件的初始数据
   */
  data: {
    isShow: false,
    arrowImg: '/images/arrow.png'
  },

  /**
   * 组件的方法列表
   */
  methods: {
    // 展现出侧边栏导航
    showSlider() {
      this.setData({
        isShow: !this.data.isShow
      }, () => {
        if (this.data.isShow) {
          this.setData({
            arrowImg: '/images/arrow-bottom.png'
          })
        } else {
          this.setData({
            arrowImg: '/images/arrow.png'
          })
        }
      })
    }
  }
})
