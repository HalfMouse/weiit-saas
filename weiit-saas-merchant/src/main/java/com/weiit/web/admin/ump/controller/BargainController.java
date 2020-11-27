package com.weiit.web.admin.ump.controller;


import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.weiit.core.entity.E;
import com.weiit.core.entity.FormMap;
import com.weiit.resource.common.utils.WeiitUtil;
import com.weiit.web.admin.product.service.ProductService;
import com.weiit.web.admin.ump.service.BargainService;
import com.weiit.web.admin.util.DateUtil;
import com.weiit.web.admin.util.DesUtil;
import com.weiit.web.base.AdminController;
import com.weiit.web.base.UIview;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;

import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * 砍价 活动
 *
 * @author 半个鼠标
 * @version 1.0
 * @date：2017年2月14日 上午2:01:43
 * @company http://www.wei-it.com
 */
@Controller
@RequestMapping(value = "/ump/bargain")
public class BargainController extends AdminController {

    public static Logger logger = Logger.getLogger(BargainController.class);

    @Resource
    private BargainService bargainService;

    @Resource
    ProductService productService;


    /**
     * 砍价活动 列表
     */
    @RequestMapping("/bargainList")
    public UIview bargainList() throws Exception {
        logger.info("进入 bargainController-list,砍价活动列表");
        //获取请求参数
        FormMap formMap = getFormMap();
        //开启分页
        PageHelper.startPage(formMap.getPage(), formMap.getRows());
        //查询展示数量
        List<E> list = bargainService.selectList(formMap);

        //返回到list页面
        UIview result = UIView("/center/ump/bargain/bargainList", false);
        //绑定分页返回
        result.addObject("pageInfo", new PageInfo<E>(list));
        //绑定上一次参数
        result.addObject("queryParam", formMap);
        return result;
    }

    /**
     * 砍价活动 新增
     */
    @RequestMapping("/add")
    public UIview add() throws Exception {

        UIview result = UIView("/center/ump/bargain/bargainCreate", false);

        this.getRequest().setAttribute("title", "砍价活动新增");

        return result;
    }



    /**
     * 砍价活动 编辑
     */
    @RequestMapping("/edit")
    public UIview edit() throws Exception {

        FormMap formMap = getFormMap();

        E infoMap = bargainService.selectOne(formMap);
        formMap.put("item_id",infoMap.get("item_id"));
        E itemInfo = productService.getItemById(formMap);


        String specString ="";
        if (itemInfo!=null && itemInfo.get("spec_custom")!=null){
            formMap.put("specIds", itemInfo.getStr("spec_custom").split(";"));
            List<E> specList = productService.getSpecCustomByIds(formMap);

            for(E spec :specList){
                specString+=spec.getStr("key_name")+";";
            }
        }
        specString=specString==""?infoMap.getStr("product_name"):specString;

        infoMap.put("skuName",specString);
        UIview result = UIView("/center/ump/bargain/bargainCreate", false);

        this.getRequest().setAttribute("infoMap", infoMap);

        this.getRequest().setAttribute("title", "砍价活动编辑");

        return result;
    }

    /**
     * 砍价活动 保存
     */
    @RequestMapping("/save")
    public UIview save() throws Exception {

        FormMap param = getFormMap();
        if (param.get("validate_id") == null || param.get("validate_id").equals("")) {

            //根据生效时间判断是否现在生效
            if (System.currentTimeMillis()> DateUtil.getTimeByString(param.getStr("start_time"),"yyyy/MM/dd HH:mm:ss")){
                param.put("state", 0);
            }else {
                //未开始状态
                param.put("state", -2);
            }

            bargainService.insert(param);
        } else {
            param.set("eivt", null);
            //失效后再编辑
            if (System.currentTimeMillis()> DateUtil.getTimeByString(param.getStr("start_time"),"yyyy/MM/dd HH:mm:ss") && System.currentTimeMillis()<DateUtil.getTimeByString(param.getStr("end_time"),"yyyy/MM/dd HH:mm:ss")){
                param.put("state", 0);
            }else if (System.currentTimeMillis()<DateUtil.getTimeByString(param.getStr("start_time"),"yyyy/MM/dd HH:mm:ss")){
                param.put("state", -2);
            }

            bargainService.edit(param);
        }
        UIview result = UIView("redirect:bargainList", false);

        return result;
    }

    /**
     * 砍价活动 状态修改
     */
    @RequestMapping("/status")
    public UIview status() throws Exception {

        FormMap formMap = getFormMap();

        formMap.set("eivt", "state");

        bargainService.edit(formMap);

        UIview result = UIView("redirect:bargainList", false);

        return result;
    }

    /**
     * 秒杀活动 删除
     */
    @RequestMapping("/remove")
    public UIview remove() throws Exception {

        FormMap map = getFormMap();

        bargainService.remove(map);

        UIview result = UIView("redirect:bargainList", false);

        return result;
    }

    /**
     * 砍价活动记录列表
     */
    @RequestMapping("/bargainDetailList")
    public UIview bargainOrderList() throws Exception {
        logger.info("进入 bargainController-bargainOrderList,满减送活动列表");
        //获取请求参数
        FormMap formMap = getFormMap();
        //开启分页
        PageHelper.startPage(formMap.getPage(), formMap.getRows());
        //查询展示数量
        List<E> list = bargainService.selectBargainDetailList(formMap);
        //返回到list页面
        UIview result = UIView("/center/ump/bargain/bargainDetailList", false);
        //绑定分页返回
        result.addObject("pageInfo", new PageInfo<E>(list));
        //绑定上一次参数
        result.addObject("queryParam", formMap);
        return result;
    }

    /**
     * 砍价活动 列表
     */
    @RequestMapping("/bargainNancyList")
    public UIview bargainNancyList() throws Exception {
        logger.info("进入 bargainController-bargainOrderList,砍价活动列表");
        //获取请求参数
        FormMap formMap = getFormMap();
        //开启分页
        PageHelper.startPage(formMap.getPage(), formMap.getRows());
        //查询展示数量
        List<E> list = bargainService.selectBargainNancyList(formMap);
        //返回到list页面
        UIview result = UIView("/center/ump/bargain/bargainNancyList", false);
        //绑定分页返回
        result.addObject("pageInfo", new PageInfo<E>(list));
        //绑定上一次参数
        result.addObject("queryParam", formMap);
        return result;
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
            List<E> productList = bargainService.selectProductList(formMap);
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
     * 微页面(活动页) 根据bargain_ids 获取砍价商品活动列表
     */
    @ResponseBody
    @RequestMapping("/getProductByBargainIds")
    public String getProductByBargainIds(@RequestParam String token,String bargain_ids,Integer bargainGetType) throws Exception {
        logger.info("进入 bargainController-getProductByBargainIds,微页面根据bargain_ids 获取砍价商品活动列表");
        FormMap formMap = new FormMap();
        try {
            formMap.put("shop_id", DesUtil.decrypt(token));
        } catch (Exception e) {
            e.printStackTrace();
            logger.error("token 解密失败");
            return "";
        }
        if (!StringUtils.isEmpty(bargain_ids)&& bargainGetType==0) {
            formMap.put("bargain_ids", StringUtils.strip(bargain_ids, "[]").split(","));
        }
		formMap.put("end_time",new Date());
        List<E> BargainList = bargainService.getProductByBargainIds(formMap);
        return toJsonAPI(BargainList);
    }


}