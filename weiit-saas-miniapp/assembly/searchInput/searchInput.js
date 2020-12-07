Component({

  behaviors: [],

  properties: {
    types: String,
    backColor:Object
  },
  data: {},

  created: function(e) {
    // console.log(this.data, '这是搜索')
  },

  methods: {
    go_serach: function() {
      wx.navigateTo({
        url: '../search/search',
      })
    }
  }

})