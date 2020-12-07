//获取应用实例
const app = getApp();
const util = require('../../utils/util.js');
const requ = require('../../utils/request.js');
const api = require('../../utils/api.js');
// assembly/audio/audio.js

const innerAudioContext = wx.createInnerAudioContext();
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
    plays: false,
    duration: 0, //音频总时长
    second: 0,
    progress: 0,
    seeks: 0, //进度条进度
  },
  attached: function() {},
  /**
   * 组件的方法列表
   */
  methods: {
    // 播放按钮
    play: function(e) {
      this.setData({
        plays: !this.data.plays,
      })
      innerAudioContext.src = 'http://wstore-1255653546.image.myqcloud.com' + e.currentTarget.dataset.url;
      innerAudioContext.onPlay(() => {
        innerAudioContext.onTimeUpdate(() => {
          this.setData({
            duration: innerAudioContext.duration,
            second: parseInt(innerAudioContext.duration - Math.round(innerAudioContext.currentTime)),
            progress: 100 / (parseInt(innerAudioContext.duration) / parseInt(innerAudioContext.currentTime))
          })
        })
      });
      if (this.data.pageParam.AfterStop == "continue") {
        this.data.plays ? innerAudioContext.play() : innerAudioContext.pause();
      } else {
        this.data.plays ? innerAudioContext.play() : innerAudioContext.stop();
      }
      innerAudioContext.onStop(() => {
        this.setData({
          duration: 0,
          plays: false,
          progress: 0,
          second: 0
        })
      });
      innerAudioContext.onEnded(() => {
        this.setData({
          duration: 0,
          plays: false,
          progress: 0,
          second: 0
        })
      })
    },
    // 进度条拖动
    sliders: function(e) {
      var seeks = this.data.duration / (100 / e.detail.value)
      this.setData({
        seeks: seeks
      })
      innerAudioContext.seek(seeks)
    }
  }
})