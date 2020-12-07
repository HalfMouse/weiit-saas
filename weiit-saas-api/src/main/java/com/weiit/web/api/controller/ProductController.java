package com.weiit.web.api.controller;


import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import javax.annotation.Resource;

import com.github.pagehelper.PageInfo;
import com.weiit.web.api.service.*;
import com.weiit.web.common.ApiResponseCode;
import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.core.annotation.Order;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import com.github.pagehelper.PageHelper;
import com.weiit.core.entity.E;
import com.weiit.core.entity.FormMap;
import com.weiit.web.base.FrontController;


@Controller
@RequestMapping(value = "/api/product")
public class ProductController extends FrontController {

    private Logger logger = Logger.getLogger(ProductController.class);

    @Resource
    private ProductService productService;

    @Resource
    ProductGroupService productGroupService;

    @Resource
    ActivityService activityService;

    @Resource
    OrderService orderService;

    @Resource
    UserService userService;


    @ResponseBody
    @RequestMapping(value = "/search", method = RequestMethod.POST)
    public String search() throws Exception {
        logger.info("【商品】接口调用创建计划,ProductController-search");

        FormMap formMap = getFormMap();
        // 开启分页
        PageHelper.startPage(formMap.getPage(), formMap.getRows());
        List<E> productList = productService.selectProductSearch(formMap);
        return toJsonAPI(new PageInfo<E>(productList));

    }

    /**
     * 商品详情接口
     *
     * @return
     * @throws Exception
     */
    @ResponseBody
    @RequestMapping(value = "/productDetail")
    public String productDetail() throws Exception {
        logger.info("【商品】接口调用创建计划,ProductController-productDetail");
        FormMap formMap = getFormMap();
        if (formMap.get("user_id")!=null){

            //添加访问商品记录
            formMap.put("type_id",formMap.get("product_id"));
            formMap.put("page_type",3);
            userService.addUserPageViewLog(formMap,true);
        }

        return toJsonAPI(productService.productDetail(formMap));


    }

    /**
     * 商品规格检查接口
     *
     * @return
     * @throws Exception
     */
    @ResponseBody
    @RequestMapping(value = "/productSpecCheck", method = RequestMethod.POST)
    public String productSpecCheck() throws Exception {
        logger.info("【商品】接口调用创建计划,ProductController-productSpecCheck");

        FormMap formMap = getFormMap();
        if (StringUtils.isEmpty(formMap.getStr("product_id"))) {
            return toJsonAPI("", "必须传递product_id", "1000");
        }
        if (StringUtils.isEmpty(formMap.getStr("spec_custom"))) {
            return toJsonAPI("", "必须传递spec_custom", "1000");
        }
        //根据product_id,spec_custom查询商品item信息
        E item = productService.selectItemSpec(formMap);
        if (item != null) {
            return toJsonAPI(item);
        } else {
            return toJsonAPI("", "此商品已被下架", "1000");
        }


    }

    /**
     * 加入购物车接口
     *
     * @return
     * @throws Exception
     * 传参param  product_id item_id count spec_custom token
     */
    @ResponseBody
    @RequestMapping(value = "/addUserCart", method = RequestMethod.POST)
    public String addUserCart(@RequestHeader("token") String token) throws Exception {
        logger.info("【商品】接口调用创建计划,ProductController-addUserCart");

        FormMap formMap = getFormMap();
        if (StringUtils.isEmpty(formMap.getStr("product_id")) || StringUtils.isEmpty(formMap.getStr("item_id")) || StringUtils.isEmpty(formMap.getStr("count"))) {
            return toJsonAPI("", "必须传递product_id,item_id,spec_content,count", "1000");
        }
        if (formMap.get("user_id") != null) {

            if(isPurchase(formMap,formMap.getInt("count"))){
                return toJsonAPI("", "已超过限购数量", "1008");
            }
            E item = productService.selectProductItemByItemId(formMap);
            if (item.getInt("stock") < 1) {
                return toJsonAPI("", "该商品已售罄", "1008");
            } else {
                if (formMap.getInt("count") > item.getInt("stock")) {
                    return toJsonAPI("", "该商品库存不足", "1008");
                } else {
                    //判断购物车是否已经存在该商品，如果存在，追加数量，如果不存在则新增
                    E userCart = productService.selectUserCartByProductIdAndItemId(formMap);

                    if (userCart == null) {//新增购物车
                        productService.insertUserCart(formMap);
                        return toJsonAPI("", "添加购物车成功", "0");
                    } else {//则修改购物车的数量
                        int countInCart =  userCart.getInt("count") + formMap.getInt("count");
                        if (countInCart> item.getInt("stock")) {
                            return toJsonAPI("", "该商品库存不足", "1008");
                        } else {
                            if(isPurchase(formMap,countInCart)){
                                return toJsonAPI("", "已超过限购数量", "1008");
                            }
                            productService.editUserCart(formMap);
                            return toJsonAPI("", "添加购物车成功", "0");
                        }
                    }
                }
            }

        } else {
            return toJsonAPI(ApiResponseCode.TOKEN_INVALID);
        }
    }

    public boolean isPurchase(FormMap formMap,int countInCart){
        E productInfo = productService.selectProductInfoById(formMap);
        // 是否限购  不用对比订单库存
        if (productInfo.getInt("purchase")>0 ){
            //统计已支付/已完成/代支付订单的该商品数量
            int countInOrder = orderService.selectOrderProductCount(formMap);
            if((countInOrder+countInCart)>productInfo.getInt("purchase")){
                return true;
            }
        }
        return false;
    }


    /**
     * 购物车接口
     *
     * @return
     * @throws Exception
     */
    @ResponseBody
    @RequestMapping(value = "/userCart", method = RequestMethod.POST)
    public String userCart(@RequestHeader("token") String token) throws Exception {
        logger.info("【商品】接口调用创建计划,ProductController-userCart");

        FormMap formMap = getFormMap();
        if (formMap.get("user_id") != null) {
            //查询用户的购物车列表
            List<E> userCartList = orderService.selectUserCartList(formMap);
            //查询用户默认收货地址
            E userAddress = productService.selectUserAddressDefault(formMap);
            E result = new E();
            result.put("cart_info", userCartList);
            formMap.set("cartList",userCartList);
            //地址   关系 邮费计算
            if (userAddress!=null){
                formMap.put("address_id",userAddress.get("id"));
            }
            result.put("express_money", orderService.calcPostage(formMap).get("expressPrice"));
            result.put("user_address_info", userAddress);
            result.put("coupons", activityService.getUserCouponListForCart(formMap));



            return toJsonAPI(result);
        } else {
            return toJsonAPI(ApiResponseCode.TOKEN_INVALID);
        }
    }


    @RequestMapping("/paymentTypeInfo")
    @ResponseBody
    public String paymentTypeInfo(@RequestHeader String token){
        E result = new E();
        FormMap formMap = getFormMap();
        //控制支付方式 ，后台限制开启微信支付  余额方式可控
        formMap.put("payment_type",formMap.get("open_id_type"));
        E wxPaymentTypeInfo = orderService.selectPaymentTypeInfo(formMap);

        if (wxPaymentTypeInfo==null){
            result.put("wxPayAble",false);
        }else {
            result.put("wxPayAble",true);
        }

        formMap.put("payment_type",2);
        E balancePaymentTypeInfo = orderService.selectPaymentTypeInfo(formMap);

        if (balancePaymentTypeInfo==null){
            result.put("balancePayAble",false);
        }else {
            result.put("balancePayAble",true);
        }
        return toJsonAPI(result);
    }



    /**
     * 购物车 商品数量增加，减少
     *
     * @return
     * @throws Exception
     * param cart_id count
     */
    @ResponseBody
    @RequestMapping(value = "/addUserCartCount", method = RequestMethod.POST)
    public String addUserCartCount(@RequestHeader("token") String token) throws Exception {
        logger.info("【商品】接口调用创建计划,ProductController-addUserCart");
        FormMap formMap = getFormMap();
        if (formMap.get("user_id") != null) {
            E cartInfo =productService.selectCartInfoById(formMap);
            //product_id item_id
            formMap.put("product_id",cartInfo.get("product_id"));
            if(isPurchase(formMap,formMap.getInt("count"))){
                return toJsonAPI("", "已超过限购数量", "1008");
            }
            formMap.put("item_id",cartInfo.get("item_id"));
            E item = productService.selectProductItemByItemId(formMap);
            if (item.getInt("stock") < 1) {
                return toJsonAPI("", "该商品已售罄", "1008");
            } else {
                if (formMap.getInt("count") > item.getInt("stock")) {
                    return toJsonAPI("", "该商品库存不足", "1008");
                }
            }


            productService.editUserCartCount(formMap);
            return toJsonAPI("操作成功！");
        } else {
            return toJsonAPI(ApiResponseCode.TOKEN_INVALID);
        }
    }





    /**
     * 购物车 商品 删除
     *
     * @return
     * @throws Exception
     */
    @ResponseBody
    @RequestMapping(value = "/delUserCartProduct", method = RequestMethod.POST)
    public String delUserCartProduct(@RequestHeader("token") String token) throws Exception {
        logger.info("【商品】接口调用创建计划,ProductController-delUserCartProduct");
        FormMap formMap = getFormMap();
        if (formMap.get("user_id") != null) {
            productService.deleteUserCartById(formMap);
            return toJsonAPI("操作成功！");
        } else {
            return toJsonAPI(ApiResponseCode.TOKEN_INVALID);
        }
    }

    /**
     * 商品收藏接口
     *
     * @return
     * @throws Exception
     */
    @ResponseBody
    @RequestMapping(value = "/addProductCollection", method = RequestMethod.POST)
    public String addProductCollection(@RequestHeader("token") String token) throws Exception {
        logger.info("【商品】接口调用创建计划,ProductController-addProductCollection");

        FormMap formMap = getFormMap();

        if (formMap.get("user_id") != null) {

            //根据商品ID查询商品信息
            E product = productService.selectProductById(formMap);
            //组装商品收藏信息
            formMap.set("product_name", product.getStr("product_name"));
            formMap.set("product_img", product.getStr("product_img"));
            formMap.set("smarket_price", product.getStr("smarket_price"));
            formMap.set("sale_price", product.getStr("sale_price"));

            productService.insertProductcollection(formMap);
            return toJsonAPI("收藏成功");
        } else {
            return toJsonAPI(ApiResponseCode.TOKEN_INVALID);
        }
    }


    /**
     * 微页面 获取商品列表 中的商品 基本信息
     *
     * @author lhq
     * @date 2018年5月7日
     */

    @RequestMapping(value = "/getProductListByIds", method = RequestMethod.POST)
    @ResponseBody
    public String getProductListByIds() {
        logger.info("进入ProductGroupController-getProductListByIds,微页面商品列表基本信息");
        FormMap formMap = getFormMap();
        List<E> list ;
        if (StringUtils.isEmpty(formMap.getStr("productIds"))) {
            PageHelper.startPage(1,formMap.getInt("showNum")==0?4:formMap.getInt("showNum"));
            list=productService.autoGetProduct(formMap);
        } else {
            //小海 晓东  传参不一样
            if (formMap.getStr("productIds").contains("[")) {
                formMap.put("productIds", convertJson(formMap.getStr("productIds"), String[].class));
            } else {
                formMap.put("productIds", formMap.getStr("productIds").split(","));
            }

            list=productService.getProductListByIds(formMap);
        }

        E result = new E();
        if (list != null && list.size() > 0) {
            result.put("productInfo", (list));
        }
        return toJsonAPI(result);
    }

    /**
     * 微页面商品分组基本信息  根据group_ids 获取商品
     *
     * @author lhq
     * @date 2018年5月9日
     * <p>
     * request_param group_ids
     *
     * 参数名  sortOrder   参数值（time price sale）   排序方式
     */

    @RequestMapping(value = "/getProductByGroupIds", method = RequestMethod.POST)
    @ResponseBody
    public String getProductByGroupIds() {
        logger.info("进入ProductGroupController-getProductByGroupIds,微页面  商品分组获取商品基本信息");
        FormMap formMap = getFormMap();
        //根据group_id 返回分组下的商品
        if (StringUtils.isEmpty(formMap.getStr("group_ids"))) {
            return toJsonAPI(ApiResponseCode.GROUPIDS_EMPTY);
        } else {
            //小海 晓东  传参不一样
            List<String> group_ids;
            if (formMap.getStr("group_ids").contains("[")) {
                group_ids = Arrays.asList(StringUtils.strip(formMap.getStr("group_ids"), "[]").split(","));
            } else {
                group_ids = Arrays.asList(formMap.getStr("group_ids").split(","));
            }
            List<E> result = new ArrayList();



            for (String group_id : group_ids) {
                formMap.put("group_id", group_id);
                //获取分组下的商品
                List<E> list = productGroupService.getProductByGroupId(formMap);
                E groupInfo = new E();
                if (list != null && list.size() > 0) {
                    groupInfo.put("productInfo", list);
                    groupInfo.put("group_name", list.get(0).getStr("group_name"));
                    groupInfo.put("group_id", group_id);
                    result.add(groupInfo);
                }

            }
            return toJsonAPI(result);
        }
    }


    //计算邮费 product_id count address_id
    @ResponseBody
    @RequestMapping(value = "/calcExpressPriceForActivity")
    public String calcExpressPriceForActivity(@RequestHeader String token){
        logger.info("进入ProductGroupController-calcExpressPriceForActivity,计算邮费");
        FormMap formMap= getFormMap();
        return toJsonAPI(productService.calcExpressPriceForActivity(formMap));
    }



}
