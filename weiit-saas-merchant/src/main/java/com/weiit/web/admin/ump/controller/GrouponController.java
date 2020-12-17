package com.weiit.web.admin.ump.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.weiit.core.entity.E;
import com.weiit.core.entity.FormMap;
import com.weiit.core.view.UIview;
import com.weiit.resource.common.utils.WeiitUtil;
import com.weiit.web.admin.product.service.ProductService;
import com.weiit.web.admin.ump.service.GrouponService;
import com.weiit.web.admin.util.DateUtil;
import com.weiit.web.admin.util.DesUtil;
import com.weiit.web.base.AdminController;
import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.List;

/**
 * 秒杀 活动
 *
 * @author 半个鼠标
 * @version 1.0
 * @date：2017年2月14日 上午2:01:43
 * @company http://www.wei-it.com
 */
@Controller
@RequestMapping(value = "/ump/groupon")
public class GrouponController extends AdminController {

    public static Logger logger = Logger.getLogger(GrouponController.class);

    @Resource
    private GrouponService grouponService;

    @Resource
    ProductService productService;


    /**
     * 拼团活动 列表
     */
    @RequestMapping("/grouponList")
    public UIview grouponList() throws Exception {
        logger.info("进入 grouponController-list,拼团活动列表");
        //获取请求参数
        FormMap formMap = getFormMap();
        //开启分页
        PageHelper.startPage(formMap.getPage(), formMap.getRows());
        //查询展示数量

        if(StringUtils.isEmpty(formMap.getStr("state"))){
            formMap.put("state",0);
        }
        List<E> list = grouponService.selectList(formMap);
        for (E groupon : list){
            //已成团  和  已开团  数量
            FormMap param = new FormMap();
            param.put("groupon_id",groupon.get("groupon_id"));

            //已开团数  （包含成功和其他状态的拼团）
            int count = grouponService.selectGrouponCount(param);
            groupon.put("sumGroupon",count);
            //已成团数
            param.put("state",3);
            int hasGroupon = grouponService.selectGrouponCount(param);
            groupon.put("hasGroupon",hasGroupon);



        }

        //返回到list页面
        UIview result = UIView("/center/ump/groupon/grouponList", false);
        //绑定分页返回
        result.addObject("pageInfo", new PageInfo<E>(list));
        //绑定上一次参数
        result.addObject("queryParam", formMap);
        return result;
    }

    /**
     * 拼团活动 新增
     */
    @RequestMapping("/add")
    public String add() throws Exception {
        try {
            this.getRequest().setAttribute("title", "拼团活动新增");
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "/center/ump/groupon/grouponCreate";
    }

    /**
     * 拼团活动 编辑
     */
    @RequestMapping("/edit")
    public String edit() throws Exception {
        try {
            FormMap formMap = getFormMap();
            E infoMap = grouponService.selectOne(formMap);
            this.getRequest().setAttribute("infoMap", infoMap);
            this.getRequest().setAttribute("title", "拼团活动编辑");

            //如果该活动选择的商品是多规格的  拼团多规格配置
            List<E> itemList = grouponService.grouponItemById(formMap);

            if (itemList != null && itemList.size() > 0) {
                this.getRequest().setAttribute("itemList", itemList);
                //查询多规格属性<tr>
                String spec_custom = infoMap.getStr("spec_custom");
                String[] specIds = spec_custom.split(";");
                formMap.put("specIds", specIds);
                List<E> specList = productService.getSpecCustomByIds(formMap);
                this.getRequest().setAttribute("specList", specList);
                //查询多规格属性<td>
                for (E e : itemList) {
                    formMap.put("specIds", e.getStr("spec_custom").split(";"));
                    e.put("specDesc", productService.getSpecCustomByIds(formMap));
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return "/center/ump/groupon/grouponCreate";
    }

    public static void main(String[] args) {
        String date ="2018/06/21 16:23:46";

        System.out.println(""+DateUtil.getTimeByString(date,"yyyy/MM/dd HH:mm:ss"));
        System.out.println(""+System.currentTimeMillis());



    }

    /**
     * 拼团活动 保存
     */
    @RequestMapping("/save")
    public String save() throws Exception {
        try {
            FormMap param = getFormMap();

            //使用有效期表示“不限购”
            if (param.getInt("maxLimitType") == 1) {
                param.set("max_limit", 0);
            }


            if (param.get("itemCount") != null && param.getInt("itemCount") > 0) {
                Double groupon_price=0.0;
                for (int i = 0; i < param.getInt("itemCount"); i++) {
                    if (i==0){
                        groupon_price = param.getDouble("grouponPrice" + i);
                    }else if (groupon_price.compareTo(param.getDouble("grouponPrice" + i))>0){
                        groupon_price=param.getDouble("grouponPrice" + i);
                    }
                }
                param.put("groupon_price", groupon_price);
            }
            //根据生效时间判断是否现在生效
            if (System.currentTimeMillis()>DateUtil.getTimeByString(param.getStr("start_time"),"yyyy/MM/dd HH:mm:ss")){
                param.put("state", 0);
            }else {
                //未开始状态
                param.put("state", -2);
            }

            if (param.get("validate_id") == null || param.get("validate_id").equals("")) {

                //多规格商品 groupon_price为null


                grouponService.insert(param);
                //插入砍价拼团详情
                if (param.get("itemCount") != null && param.getInt("itemCount") > 0) {
                    for (int i = 0; i < param.getInt("itemCount"); i++) {
                        E skuMap = new E();
                        skuMap.put("item_id", param.getStr("itemId" + i).split(":")[0]);
                        skuMap.put("spec_custom", param.getStr("itemId" + i).split(":")[1]);
                        skuMap.put("groupon_price", param.get("grouponPrice" + i));
                        skuMap.put("sale_price", param.get("salePrice" + i));
                        skuMap.put("groupon_id", param.get("groupon_id"));
                        skuMap.put("product_id", param.get("product_id"));
                        //插入数据
                        grouponService.insertGrouponItem(skuMap);
                    }
                }else {
                    E skuMap = new E();
                    skuMap.put("item_id", param.getStr("item_id"));
                    skuMap.put("spec_custom", param.getStr("spec_custom"));
                    skuMap.put("groupon_price", param.get("groupon_price"));
                    skuMap.put("sale_price", param.get("sale_price"));
                    skuMap.put("groupon_id", param.get("groupon_id"));
                    skuMap.put("product_id", param.get("product_id"));
                    grouponService.insertGrouponItem(skuMap);
                }
            } else {
                param.set("eivt", null);
                grouponService.edit(param);
                //更新拼团item
                if (param.get("itemCount") != null && param.getInt("itemCount") > 0) {
                    for (int i = 0; i < param.getInt("itemCount"); i++) {
                        E skuMap = new E();
                        skuMap.put("item_id", param.getStr("itemId" + i).split(":")[0]);
                        skuMap.put("groupon_price", param.get("grouponPrice" + i));
                        skuMap.put("groupon_id", param.get("validate_id"));
                        //插入数据
                        grouponService.updateGrouponItem(skuMap);
                    }
                }


            }
        } catch (Exception e) {
            e.printStackTrace();
            throw new Exception("出错啦...");
        }
        return "redirect:grouponList";
    }

    /**
     * 拼团活动 状态修改
     */
    @RequestMapping("/status")
    public String status() throws Exception {
        try {
            FormMap formMap = getFormMap();
            formMap.set("eivt", "state");
            grouponService.edit(formMap);
        } catch (Exception e) {
            e.printStackTrace();
            throw new Exception("出错啦...");
        }
        return "redirect:grouponList";
    }

    /**
     * 拼团活动 删除
     */
    @RequestMapping("/remove")
    public String remove() throws Exception {

        //更新为删除状态
        FormMap map = getFormMap();
        map.put("is_delete",-1);
        grouponService.remove(map);

        //更新拼团Item
        E updateParam = new E();
        updateParam.set("is_delete",-1);
        updateParam.set("groupon_id",map.get("validate_id"));
        grouponService.updateGrouponItem(updateParam);



        return "redirect:grouponList";
    }

    /**
     * 发起拼团活动列表
     */
    @RequestMapping("/grouponDetailList")
    public UIview grouponOrderList() throws Exception {
        logger.info("进入 grouponController-grouponOrderList,发起拼团活动列表");
        //获取请求参数
        FormMap formMap = getFormMap();
        //开启分页
        PageHelper.startPage(formMap.getPage(), formMap.getRows());
        //查询展示数量
        List<E> list = grouponService.selectGrouponDetailList(formMap);
        //返回到list页面
        UIview result = UIView("/center/ump/groupon/grouponDetailList", false);
        //绑定分页返回
        result.addObject("pageInfo", new PageInfo<E>(list));
        //绑定上一次参数
        result.addObject("queryParam", formMap);
        return result;
    }

    /**
     * 拼团用户活动记录列表
     */
    @RequestMapping("/grouponNancyList")
    public UIview grouponNancyList() throws Exception {
        logger.info("进入 grouponController-grouponOrderList,拼团用户活动记录列表");
        //获取请求参数
        FormMap formMap = getFormMap();
        //开启分页
        PageHelper.startPage(formMap.getPage(), formMap.getRows());
        //查询展示数量
        List<E> list = grouponService.selectGrouponNancyList(formMap);
        //返回到list页面
        UIview result = UIView("/center/ump/groupon/grouponNancyList", false);
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
        logger.info("GrouponController-productList,查询商品");
        try {
            FormMap formMap = getFormMap();
            formMap.set("product_name", new String(formMap.getStr("product_name").getBytes("ISO-8859-1")));
            List<E> productList = grouponService.selectProductList(formMap);
            List<E> productJson = new ArrayList<E>();
            for (E e : productList) {
                E productinfo = new E();
                productinfo.set("product_name", "<img src='" + WeiitUtil.getFileDomain() + e.getStr("product_img") + "' width='60px' height='60px'/>" + e.getStr("product_name"));
                productinfo.set("sale_price", e.getStr("sale_price"));
                productinfo.set("stock", e.getStr("stock"));

                if (StringUtils.isEmpty(e.getStr("state")) || e.getInt("state")<0) {
                    productinfo.set("option", "<a href='javascript:;'   title='选取' class='btn bg-green m-r-5 m-b-5 able_product_" + e.getStr("product_id") + "' style='height: 22px;padding-top: 0px;' onclick='selectProduct(" + e.getStr("product_id") + ")' >选取</a>");
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
     * * 微页面 拼团活动列表
     */
    @RequestMapping("/grouponListByIds")
    @ResponseBody
    public String grouponListByIds(@RequestParam String token,String groupon_ids,Integer grouponGetType) throws Exception {
        logger.info("进入 PageController-list,拼团活动列表");
        FormMap formMap = new FormMap();
        try {
            formMap.put("shop_id", DesUtil.decrypt(token));
        } catch (Exception e) {
            e.printStackTrace();
            logger.error("token 解密失败");
            return "";
        }
        formMap.put("groupon_ids",groupon_ids);
        formMap.put("grouponGetType",grouponGetType);
        if (StringUtils.isNotEmpty(groupon_ids) && grouponGetType==0){
            formMap.put("groupon_ids", StringUtils.strip(groupon_ids, "[]").split(","));
        }

        List<E> list = grouponService.grouponListByIds(formMap);
        return toJsonAPI(list);
    }


}