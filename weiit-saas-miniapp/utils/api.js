const api = {
  pageInfo: '/api/page/pageInfo', //首页所有数据接口
  formID:'/api/collectFormIds',//formID
  tehuimai: '/api/page/tehuimai', //特惠页面
  getProductListByIds: '/api/product/getProductListByIds', //首页商品列表
  getProductByGroupIds: '/api/product/getProductByGroupIds', //首页商品分组
  grouponListByIds: '/api/groupon/grouponListByIds', //首页我的拼团
  getProductByBargainIds: '/api/bargain/getProductByBargainIds', //首页的砍价
  couponListByIds: '/api/activity/couponListByIds', //优惠券
  selectBargainList: '/api/bargain/selectBargainList', //砍价列表
  userBargain: '/api/bargain/userBargain', //我的砍价列表
  getShopAllGroupon: '/api/groupon/getShopAllGroupon', //拼团列表
  getMyGroupon: '/api/groupon/getMyGroupon', //我的拼团列表
  startGroupon: '/api/groupon/startGroupon', //发起拼团
  calcExpressPriceForActivity: '/api/product/calcExpressPriceForActivity', //拼团运费计算
  grouponSuccessPage: '/api/groupon/grouponSuccessPage', //拼团成功
  getJoinGrouponInfo: '/api/groupon/getJoinGrouponInfo', //某个拼单的详情
  joinGroupon: '/api/groupon/joinGroupon', //参与别人的拼团(支付)
  grouponOrderPay: '/api/groupon/grouponOrderPay', //拼团订单继续支付
  orderPay: '/api/order/orderPay', //订单继续支付
  myAddressList: '/api/user/myAddressList', // 获取收货地址
  myAddressSetDefault: '/api/user/myAddressSetDefault', //设置默认地址
  myAddressDelete: '/api/user/myAddressDelete', //删除地址
  bargainOrder: '/api/bargain/bargainOrder', //选择地址
  bargainPage: '/api/bargain/bargainPage', //砍价页面
  share_user_id: '/api/bargain//helpBargain', //帮忙砍价
  bargainMessage: '/api/bargain/bargainMessage', //砍价页面轮播公告
  isBargain: '/api/bargain/isBargain', //是否已经砍过价
  bargainPay: '/api/bargain/bargainPay', //砍价支付
  grouponProduct: '/api/groupon/grouponProduct', //拼团商品详情
  productDetail: '/api/product/productDetail', //商品详情
  addProductCollection: '/api/product/addProductCollection', //收藏
  myCollectionDelete: '/api/user/myCollectionDelete', //取消收藏
  productSpecCheck: '/api/product/productSpecCheck', //选择尺码参数(详情)
  grouponProductSpecCheck: '/api/groupon/productSpecCheck', //选择尺码(拼团)
  addUserCart: '/api/product/addUserCart', //添加购物车
  myCollectionList: '/api/user/myCollectionList', //收藏列表
  myCollectionDelete: '/api/user/myCollectionDelete', //删除收藏
  myCoupons: '/api/user/myCoupons', //我的优惠券
  addSuggest: '/api/user/addSuggest', //提见
  orderList: '/api/order/orderList', //订单列表
  updateOrderState: '/api/order/updateOrderState', //确认收货
  userInfo: '/api/user/userInfo', //用户信息
  couponList: '/api/activity/couponList', //优惠券列表
  couponGet: '/api/activity/couponGet', //领取优惠券
  myBalanceLog: '/api/user/myBalanceLog', //收支明细
  orderRefundList: '/api/order/orderRefundList', //退货管理
  orderRefundCancel: '/api/order/orderRefundCancel', //取消退货
  myBalanceExtract: '/api/user/myBalanceExtract', //我的提现
  balanceRecharge: '/api/user/balanceRecharge', //余额充值
  myAddressSave: '/api/user/myAddressSave', //保存收货人信息
  myAddressUpdate: '/api/user/myAddressUpdate', //修改收货地址
  expressCompany: '/api/order/expressCompany', //物流公司列表
  addOrderRefundExpress: '/api/order/addOrderRefundExpress', //补充提交信息
  addOrderRefund: '/api/order/addOrderRefund', //提交售后申请
  myIntegralLog: '/api/user/myIntegralLog', //我的积分
  orderExpress: '/api/order/orderExpress', //物流详情
  verificationCode: '/api/user/verificationCode', //修改手机号码
  orderDetail: '/api/order/orderDetail', //订单详情
  orderRefundDetail: '/api/order/orderRefundDetail', //退款详情
  search: '/api/product/search', //搜索
  userCart: '/api/product/userCart', //购物车
  getUserCouponListForCart: '/api/activity/getUserCouponListForCart', //购物车优惠券列表
  delUserCartProduct: '/api/product/delUserCartProduct', //删除购物车里面商品
  addUserCartCount: '/api/product/addUserCartCount', //增加购物车里面商品数量
  addOrder: '/api/order/addOrder', //提交订单
  calcPostage: '/api/order/calcPostage', //计算邮费
  updateUserInfo: '/api/user/updateUserInfo', //测试用户手机号
  selectIntegralProductList: '/api/integral/selectIntegralProductList', //积分商品列表
  integralProductDetail: '/api/integral/integralProductDetail', //积分商品详情
  integralOrder: '/api/integral/integralOrder', //提交积分订单
  integralOrderList: '/api/integral/integralOrderList',  //积分订单列表
  integralPay: '/api/integral/integralPay',   //继续支付
  getValidateCode:'/api/integral/getValidateCode',   //获取短信验证码
  updateUserPhoneInfo:'/api/integral/updateUserPhoneInfo',   //保存用户信息
  shareSuccess:'/api/integral/shareSuccess',    //分享成功
  getShopInfo:'/api/user/getShopInfo',   //获取客服电话
  paymentTypeInfo:'/api/product/paymentTypeInfo',   //允许的支付方式
  shopLogo:'/api/shopLogo',           //商店logo
  enterPointConfig:'/api/user/enterPointConfig'   //个人中心入口配置
}
export {
  api
}