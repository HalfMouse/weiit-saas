package com.weiit.web.admin.ump.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.weiit.core.entity.E;
import com.weiit.core.entity.FormMap;
import com.weiit.core.view.UIview;
import com.weiit.resource.common.utils.WeiitUtil;
import com.weiit.web.admin.product.service.ProductService;
import com.weiit.web.admin.publics.service.ParameterService;
import com.weiit.web.admin.ump.service.IntegralService;
import com.weiit.web.base.AdminController;
import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by 罗鸿强 on 2018/9/18.
 */
@Controller
@RequestMapping("/ump/integral")
public class IntegralController  extends AdminController {


    @Resource
    private IntegralService integralService;

    @Resource
    ParameterService parameterService;


    @Resource
    ProductService productService;

   @RequestMapping("list")
    public UIview IntegralList(){
       logger.info("进入 IntegralController-list,积分商品列表");
       //获取请求参数
       FormMap formMap = getFormMap();
       //开启分页
       PageHelper.startPage(formMap.getPage(), formMap.getRows());
       //查询展示数量
       List<E> list = integralService.selectList(formMap);

       //返回到list页面
       UIview result = UIView("/center/ump/integral/integralProduct", false);
       //绑定分页返回
       result.addObject("pageInfo", new PageInfo<E>(list));
       //绑定上一次参数
       result.addObject("queryParam", formMap);
       return result;
   }


   @RequestMapping("config")
    public UIview config(){
       logger.info("进入 IntegralController-config,积分设置");
       //获取请求参数
       FormMap formMap = getFormMap();
       formMap.put("item_code", "INTEGRALSET");
       UIview result=UIView("/center/ump/integral/integralConfig",false);
       List<E> list=parameterService.selectList(formMap);
       for (E info : list) {
           formMap.set(info.getStr("item_name"), info.get("state"));
           formMap.set(info.getStr("item_name")+"_ITEM", info.get("item_value"));
           formMap.set(info.getStr("item_name")+"_ID", info.get("id"));
       }
       result.addObject("queryParam", formMap);
       return result;
   }

    /**
     * 积分设置 保存
     */
    @RequestMapping("/configSave")
    public UIview configSave() {
        logger.info("进入 IntegralController-configSave,积分设置 保存");
        FormMap formMap = getFormMap();
        UIview result=UIView("config",true);

        List<FormMap> list=new ArrayList<FormMap>();

        FormMap personalInfo = new FormMap();
        personalInfo.put("validate_id", formMap.get("PERSONAL_ID"));
        personalInfo.put("item_value", formMap.get("PERSONAL_ITEM"));
        personalInfo.put("state", formMap.get("PERSONAL"));
        personalInfo.put("shop_id", formMap.get("shop_id"));
        if(formMap.getStr("PERSONAL_ID").equals("")){
            personalInfo.put("item_code", "INTEGRALSET");
            personalInfo.put("item_name", "PERSONAL");
            personalInfo.put("item_desc", "积分-完善个人信息");
        }
        FormMap goShopInfo = new FormMap();
        goShopInfo.put("validate_id", formMap.get("GOSHOP_ID"));
        goShopInfo.put("item_value", formMap.get("GOSHOP_ITEM"));
        goShopInfo.put("state", formMap.get("GOSHOP"));
        goShopInfo.put("shop_id", formMap.get("shop_id"));
        if(formMap.getStr("PERSONAL_ID").equals("")){
            goShopInfo.put("item_code", "INTEGRALSET");
            goShopInfo.put("item_name", "GOSHOP");
            goShopInfo.put("item_desc", "积分-购物设置");
        }
        FormMap shaerInfo = new FormMap();
        shaerInfo.put("validate_id", formMap.get("SHARE_ID"));
        shaerInfo.put("item_value", formMap.get("SHARE_ITEM"));
        shaerInfo.put("state", formMap.get("SHARE"));
        shaerInfo.put("shop_id", formMap.get("shop_id"));
        if(formMap.getStr("PERSONAL_ID").equals("")){
            shaerInfo.put("item_code", "INTEGRALSET");
            shaerInfo.put("item_name", "SHARE");
            shaerInfo.put("item_desc", "积分-分享店铺");
        }
        FormMap bindInfo = new FormMap();
        bindInfo.put("validate_id", formMap.get("BIND_ID"));
        bindInfo.put("item_value", formMap.get("BIND_ITEM"));
        bindInfo.put("state", formMap.get("BIND"));
        bindInfo.put("shop_id", formMap.get("shop_id"));
        if(formMap.getStr("PERSONAL_ID").equals("")){
            bindInfo.put("item_code", "INTEGRALSET");
            bindInfo.put("item_name", "BIND");
            bindInfo.put("item_desc", "积分-绑定粉丝");
        }



        list.add(personalInfo);
        list.add(goShopInfo);
        list.add(shaerInfo);
        list.add(bindInfo);

        parameterService.editBatch(list);
        result.addPNotifyMessage("积分设置操作成功！");
        return result;
    }


   @RequestMapping("productAdd")
    public String productAdd(){
       return "/center/ump/integral/integralProductEdit";
   }



    /**
     * 查询商品列表
     */
    @ResponseBody
    @RequestMapping("/productList.json")
    public String productList() throws Exception {
        logger.info("进入seckillController-productList,查询商品");
        try {
            FormMap formMap = getFormMap();
            formMap.set("product_name", new String(formMap.getStr("product_name").getBytes("ISO-8859-1")));
            List<E> productList = integralService.selectProductList(formMap);
            List<E> productJson = new ArrayList<E>();
            for (E e : productList) {
                E productinfo = new E();
                productinfo.set("product_name", "<img src='" + WeiitUtil.getFileDomain() + e.getStr("product_img") + "' width='60px' height='60px'/>" + e.getStr("product_name"));
                productinfo.set("sale_price", e.getStr("sale_price"));
                productinfo.set("stock", e.getStr("stock"));
                if (StringUtils.isEmpty(e.getStr("state"))) {
                    productinfo.set("option", "<a href='javascript:;'   title='选取' class='btn bg-green m-r-5 m-b-5 able_product_" + e.getStr("product_id") + "' style='height: 22px;padding-top: 0px;' onclick='selectProduct(" + e.getStr("product_id") + ")' price='" + e.getStr("sale_price") + "'spec_config='" + e.getStr("spec_config") + "'>选取</a>");
                } else {
                    productinfo.set("option", "<a href='javascript:;' class='btn bg-grey m-r-5 m-b-5' style='height: 22px;padding-top: 0px;'>已参加</a>");
                }
                productJson.add(productinfo);
            }
            return toJsonAPI(productJson);
        } catch (Exception e) {
            e.printStackTrace();
            throw new Exception("出错啦...");
        }
    }



    /**
     * 选择多规格商品  规格、价格、库存、操作
     * produce_id
     */
    @ResponseBody
    @RequestMapping("/skuList.json")
    public String skuList() throws Exception {
        logger.info("BargainController-skuList,选择多规格商品");
        FormMap formMap = getFormMap();
        formMap.put("is_deleted", 0);
        formMap.put("is_disabled", 0);
        List<E> list = productService.selectItemList(formMap);

        E productInfo = productService.selectById(formMap);

        List<E> productJson = new ArrayList<E>();
        for (E e : list) {
            E productinfo = new E();
            formMap.put("specIds", e.getStr("spec_custom").split(";"));
            List<E> specList = productService.getSpecCustomByIds(formMap);
            String specString ="";
            for(E spec :specList){
                specString+=spec.getStr("key_name")+";";
            }
            specString=specString==""?productInfo.getStr("product_name"):specString;
            productinfo.set("specDesc",specString);
            productinfo.set("sale_price", e.getStr("sale_price"));
            productinfo.set("stock", e.getStr("stock"));
            productinfo.set("option", "<a href='javascript:;'   title='选取' class='btn bg-green m-r-5 m-b-5 able_item_" + e.getStr("item_id") + "' style='height: 22px;padding-top: 0px;' onclick='selectItem(" + e.getStr("item_id") + ")' specDesc='" + specString + "'  product_id='" + e.getStr("product_id") + "' product_img='" + WeiitUtil.getFileDomain()+productInfo.getStr("product_img") + "' stock='" + e.getStr("stock") + "' price='" + e.getStr("sale_price") + "'>选取</a>");

            productJson.add(productinfo);

        }
        return toJsonAPI(productJson);
    }


    /**
     * 积分商城活动 保存
     */
    @RequestMapping("/save")
    public UIview save() throws Exception {

        FormMap param = getFormMap();
        if (param.get("validate_id") == null || param.get("validate_id").equals("")) {

            integralService.insert(param);
        } else {

            integralService.edit(param);
        }
        UIview result = UIView("redirect:list", false);

        return result;
    }



    /**
     * 积分商品删除
     */
    @RequestMapping("/remove")
    public UIview remove() throws Exception {

        FormMap map = getFormMap();

        integralService.remove(map);

        UIview result = UIView("redirect:list", false);

        return result;
    }



    /**
     * 积分商品编辑
     */
    @RequestMapping("/edit")
    public UIview edit() throws Exception {

        FormMap formMap = getFormMap();

        E infoMap = integralService.selectOne(formMap);

        formMap.put("item_id",infoMap);

        UIview result = UIView("/center/ump/integral/integralProductEdit", false);

        result.addObject("infoMap",infoMap);

        return result;
    }


    /**
     * 积分商品编辑
     */
    @RequestMapping("/productStatus")
    public UIview productStatus() throws Exception {

        FormMap formMap = getFormMap();

        integralService.updateIntegralProductState(formMap);


        UIview result = UIView("redirect:list", false);


        return result;
    }



    @RequestMapping("orderList")
    public UIview orderList(){
        logger.info("进入 IntegralController-orderList,积分订单列表");
        //获取请求参数
        FormMap formMap = getFormMap();
        //开启分页
        PageHelper.startPage(formMap.getPage(), formMap.getRows());
        //查询展示数量
        List<E> list = integralService.selectOrderList(formMap);

        //返回到list页面
        UIview result = UIView("/center/ump/integral/integralOrder", false);
        //绑定分页返回
        result.addObject("pageInfo", new PageInfo<E>(list));
        //绑定上一次参数
        result.addObject("queryParam", formMap);
        return result;
    }


    /**
     * 积分商品编辑
     */
    @RequestMapping("/orderDetail")
    public UIview orderDetail() throws Exception {

        FormMap formMap = getFormMap();

        E OrderDetail = integralService.selectOrderDetail(formMap);

        double TotalPrice =(OrderDetail.getDouble("pay_price")+OrderDetail.getDouble("express_price"));

        OrderDetail.put("TotalPrice",TotalPrice);

        UIview result = UIView("/center/ump/integral/integralOrderDetail", false);

        result.addObject("order",OrderDetail);

        return result;
    }
}
