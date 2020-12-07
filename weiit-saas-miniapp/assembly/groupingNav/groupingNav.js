const app = getApp();
const util = require('../../utils/util.js');
const requ = require('../../utils/request.js');
const api = require('../../utils/api.js');
Component({
  options: {
    multipleSlots: true // 在组件定义时的选项中启用多slot支持
  },
  behaviors: [],

  properties: {
    pageParam: Object,
  },
  data: {
    navbar: [],
    currentTab: 0, //默认顶部导航下标
    leftIndex: 0, //默认左侧导航下标
    scrollTop: 0, //右侧滚动距离顶部距离
    isMask:false,
    productImg:'',
    productName:'',
    productPrice:0,
    product_id:'',
    buy_num:1,
    max_limit:0,
    spec_info:[],
    item_id:'',
    spec_config:0,
    get_btnValue: '', //是购买按钮还是加入购物车按钮
    message: '', //提示语
    Stock: 0, //商品库存
    complete: false, //选择尺码接口是否执行完成
    spe_con: [], //商品规格信息文字版
    infor:'',
    commodity: [], //选择的商品的信息
  },

  created: function(e) {
  },
  attached: function() {
    this.setData({
      navPos: this.data.pageParam.navPos,
      navShow:this.data.pageParam.navShow
    })
    var that = this;
    requ.request({
      url: api.api.getProductByGroupIds,
      data: {
        group_ids: that.data.pageParam.group_ids,
        sortOrder: that.data.pageParam.sortOrder
      },
      success: function(res) {
        console.log(res, '上')
        that.setData({
          list_item: res.data
        })
      }
    })
  },

  methods: {
    navbarTap: function(e) {
      this.setData({
        currentTab: e.currentTarget.dataset.index
      })
    },
    // 点击事件
    go_detail: function(e) {
      console.log(e, 'emm')
      var formId = e.detail.formId;
      var product_id = e.detail.target.dataset.id;
      wx.navigateTo({
        url: '../detail/detail?shop_id=' + product_id,
      })
    },
    leftIndex: function(e) {
      var index = e.detail.target.dataset.leftindex;
      var lengths = 0;
      if (index >= 2) {
        for (var i = 0; i < index; i++) {
          lengths += this.data.list_item[i].productInfo.length
        }
      } else if (index == 1) {
        lengths = this.data.list_item[0].productInfo.length
      } else {
        lengths = 0
      }
      var top = 0;
      top = index * 35 + (81 * lengths)
      if (index == 0) {
        top = 0;
      };
      this.setData({
        leftIndex: index,
        scrollTop: top
      })
    },
    // 添加购物车
    addProduct(e){
      const id = e.currentTarget.dataset.id;
      var that = this;
      requ.request({
        url: api.api.productDetail,
        data:{
          product_id: id
        },
        success:function(res){
          console.log(res);
          if(res.code == '0'){
            var spec_info = res.data.product_info.spec_info;
            console.log(spec_info)
            if (spec_info){
              spec_info.forEach((item) => {
                item.values.forEach((ele) => {
                  ele.choice = false
                })
              })
            }else{
              spec_info=[]
            }
            that.setData({
              productImg: res.data.product_info.product_img,
              productName: res.data.product_info.product_name,
              productPrice: res.data.product_info.sale_price,
              max_limit: res.data.product_info.max_limit,
              spec_info: spec_info,
              infor: res.data.product_info,
              spec_config: res.data.product_info.spec_config,
              product_id: res.data.product_info.product_id,
              Stock: res.data.product_info.stock,
              isMask:true
            })
          }
        }
      })
    },
    // 减少数量
    reduce_num(){
      if (this.data.buy_num > 1) {
        this.setData({
          buy_num: this.data.buy_num - 1
        })
      } else {
        wx.showToast({
          title: '最少选择1件商品',
          icon: 'none',
          duration: 1000
        })
      }
    },
    // 添加数量
    add_num(){
      if (this.data.max_limit > 0) {
        if (this.data.buy_num < this.data.max_limit) {
          this.setData({
            buy_num: this.data.buy_num + 1
          })
        } else {
          wx.showToast({
            title: '该商品限购' + this.data.max_limit + '件',
            icon: 'none',
            duration: 1000
          })
        }
      } else {
        if (this.data.buy_num < this.data.Stock) {
          this.setData({
            buy_num: this.data.buy_num + 1
          })
        } else {
          wx.showToast({
            title: '最多选择' + this.data.Stock + '件商品',
            icon: 'none',
            duration: 1000
          })
        }
      }
    },
    // 关闭弹窗
    close(){
      // 隐藏遮罩层
      if (this.data.spec_info) {
        for (var i = 0; i < this.data.spec_info.length; i++) {
          for (var j = 0; j < this.data.spec_info[i].values.length; j++) {
            this.data.spec_info[i].values[j].Choice = false
          }
        };
      }
      this.setData({
        infor: this.data.infor,
        spe_con: [],
        choice: '',
        isMask: false,
        buy_num:1
      })
    },
    // 选择规格
    choiceSpec(e){
      this.setData({
        complete: false
      });
      var attr_index = e.currentTarget.dataset.index;
      var attr_value = e.currentTarget.dataset.value;
      var attr_id = e.currentTarget.dataset.id
      var row;
      var flag = true;
      for (var i = 0; i < this.data.spec_info.length; i++) {
        for (var j = 0; j < this.data.spec_info[i].values.length; j++) {
          if (this.data.spec_info[i].values[j].spec_value == attr_value) {
            row = i;
            break;
          }
        }
      }
      this.get_null(row)
      var str = 'spec_info[' + row + '].values[' + attr_index + '].choice';
      this.setData({
        [str]: true
      })
      var flag = this.checkSize()
      if (flag) {
        
        var is_choice = [];
        var spe_content = [];
        for (var m = 0; m < this.data.spec_info.length; m++) {
          for (var u = 0; u < this.data.spec_info[m].values.length; u++) {
            if (this.data.spec_info[m].values[u].choice == true) {
              is_choice.push(this.data.spec_info[m].values[u].spec_value_id);
              spe_content.push(this.data.spec_info[m].values[u].spec_value)
            }
          }
        }
        var that = this;
        requ.request({
          url: api.api.productSpecCheck,
          data: {
            product_id: that.data.product_id,
            spec_custom: is_choice.join(';')
          },
          success: function (res) {
            console.log(res);
            if (res.code == '0') {
              console.log(res);
              // 如果选择尺码前选择的商品数量大于选择尺码后剩余库存数量，那么选中的数量将改编为剩余库存数量
              if (that.data.buy_num > res.data.stock) {
                that.setData({
                  buy_num: res.data.stock
                })
              }
              that.setData({
                commodity: res.data,
                Stock: res.data.stock,
                productPrice: res.data.sale_price,
                spe_con: spe_content,
                complete: true, //选择尺码执行完，可以提交到购物车
              })
            } else {
              that.setData({
                message: res.message
              })
            }
          }
        })
      }
    },
    get_null: function (row) {
      for (var i = 0; i < this.data.spec_info[row].values.length; i++) {
        var nulls = 'spec_info[' + row + '].values[' + i + '].choice';
        this.setData({
          [nulls]: false
        })
      }
    },
    checkSize: function () {
      //如果返回true。那么说明都选中
      let flag = true;
      for (let i of this.data.spec_info) {
        let item = i;
        let arr = item.values;
        let index = arr.findIndex((ele) => {
          return ele.choice
        })
        if (index <= -1) {
          flag = false;
          break;
        }
      }
      return flag;
    },
    // 确认加入购物车
    confirm: function (e) {
      var that = this;
      this.setData({
        get_btnValue: e.currentTarget.dataset.value
      })
      if (that.data.message) {
        wx.showToast({
          title: that.data.message,
          icon: 'none'
        })
      } else {
        if (that.data.spec_config == 0) {
          that.setData({
            spe_con: ''
          });
          requ.request({
            url: api.api.addUserCart,
            data: {
              product_id: that.data.product_id,
              item_id: that.data.infor.item_id,
              spec_content: that.data.spe_con,
              count: that.data.buy_num
            },
            success: function (res) {
              console.log(res, '777')
              that.close()
              that.setData({
                choice: ''
              })
              if (res.code == 0) {
                if (that.data.get_btnValue == 'add_car') {
                  if (res.code == '1008') {
                    wx.showToast({
                      title: res.message,
                      icon: 'none'
                    })
                  } else {
                    wx.showToast({
                      title: res.message,
                      icon: 'none'
                    })
                  }
                } else {
                  wx.navigateTo({
                    url: '../car/car'
                  })
                }
              } else {
                wx.showToast({
                  title: '操作失败!' + res.message,
                  icon: 'none'
                })
              }
            }
          })
        } else {
          if (that.data.complete) {
            // if (that.data.spe_con == '') {
            //   wx.showToast({
            //     title: '请选择规格参数',
            //     icon: 'none'
            //   })
            // } else {
            requ.request({
              url: api.api.addUserCart,
              data: {
                product_id: that.data.product_id,
                item_id: that.data.commodity.item_id,
                spec_content: that.data.spe_con.join(';'),
                count: that.data.buy_num
              },
              success: function (res) {
                that.close()
                let spec_info = that.data.spec_info;
                
                spec_info.forEach((item) => {
                  item.values.forEach((ele) => {
                    ele.Choice = false
                    ele.choice = false
                  })
                })
                console.log(spec_info)
                that.setData({
                  choice: '',
                  spec_info: spec_info,
                  complete: false
                });
                if (that.data.get_btnValue == 'add_car') {
                  wx.showToast({
                    title: '加入购物车成功',
                    icon: 'none'
                  })
                } else {
                  wx.navigateTo({
                    url: '../car/car'
                  })
                }
              }
            })
            // }
          } else {
            wx.showToast({
              title: '请选择规格参数',
              icon: 'none'
            })
          }
        }
      }
    }
  }
  
})