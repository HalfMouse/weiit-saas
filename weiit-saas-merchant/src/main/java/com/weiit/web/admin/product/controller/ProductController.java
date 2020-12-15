package com.weiit.web.admin.product.controller;


import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.weiit.core.entity.E;
import com.weiit.core.entity.FormMap;
import com.weiit.core.view.UIview;
import com.weiit.resource.common.utils.WeiitUtil;
import com.weiit.web.admin.product.service.ProductGroupService;
import com.weiit.web.admin.product.service.ProductService;
import com.weiit.web.admin.product.service.ProductTagService;
//import com.weiit.web.admin.setting.service.ShippingService;
import com.weiit.web.admin.setting.service.ShippingService;
import com.weiit.web.admin.util.DesUtil;
import com.weiit.web.base.AdminController;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import javax.annotation.Resource;

import java.net.URLDecoder;
import java.util.*;

/**
 * 商品管理
 *
 * @author 半个鼠标
 * @version 1.0
 * @date：2017年2月14日 上午2:01:43
 * @company http://www.wei-it.com
 */
@Controller
@RequestMapping(value = "/product")
public class ProductController extends AdminController {
    public static Logger logger = Logger.getLogger(ProductController.class);

    @Resource
    private ProductService productService;
    @Resource
    private ShippingService shippingService;
    @Resource
    private ProductGroupService productGroupService;
    @Resource
    private ProductTagService productTagService;

    /**
     * 上架商品查询
     *
     * @author hzy
     */
    @RequestMapping("/onSaleList")
    public UIview onSaleList() {
        logger.info("进入 ProductController-onSaleList,出售中的商品");
        FormMap formMap = getFormMap();
        List<E> groupList = productGroupService.selectList(formMap);
        List<E> tagList = productTagService.selectDetailList(formMap);

        formMap.put("is_on_sale", "0");
        //开启分步
        PageHelper.startPage(formMap.getPage(), formMap.getRows());
        List<E> list = productService.selectList(formMap);
        UIview result = UIView("/center/product/onSaleList", false);
        result.addObject("pageInfo", new PageInfo<E>(list));
        result.addObject("groupList", groupList);
        result.addObject("tagList", tagList);
        //绑定上一次参数
        result.addObject("queryParam", formMap);
        return result;
    }

    /**
     * 库存紧张商品查询
     *
     * @author hzy
     */
    @RequestMapping("/soldOutList")
    public UIview soldOutList() {
        logger.info("进入 ProductController-soldOutList,库存紧张商品");
        FormMap formMap = getFormMap();
        List<E> groupList = productGroupService.selectList(formMap);
        List<E> tagList = productTagService.selectDetailList(formMap);
        formMap.put("is_on_sale", "0");
        formMap.put("stock", "10");
        //开启分步
        PageHelper.startPage(formMap.getPage(), formMap.getRows());
        List<E> list = productService.selectList(formMap);
        UIview result = UIView("/center/product/soldOutList", false);
        result.addObject("pageInfo", new PageInfo<E>(list));
        result.addObject("groupList", groupList);
        result.addObject("tagList", tagList);
        //绑定上一次参数
        result.addObject("queryParam", formMap);
        return result;
    }

    /**
     * 下架商品 查询
     *
     * @author hzy
     */
    @RequestMapping("/forSaleList")
    public UIview forSaleList() {
        logger.info("进入 ProductController-forSaleList,下架商品 查询");
        FormMap formMap = getFormMap();
        List<E> groupList = productGroupService.selectList(formMap);
        List<E> tagList = productTagService.selectDetailList(formMap);
        formMap.put("is_on_sale", "-1");
        //开启分步
        PageHelper.startPage(formMap.getPage(), formMap.getRows());
        List<E> list = productService.selectList(formMap);
        UIview result = UIView("/center/product/forSaleList", false);
        result.addObject("pageInfo", new PageInfo<E>(list));
        result.addObject("groupList", groupList);
        result.addObject("tagList", tagList);
        //绑定上一次参数
        result.addObject("queryParam", formMap);
        return result;
    }


    /**
     * 商品发布第一步
     *
     * @author hzy
     */
    @RequestMapping("/releaseOne")
    public String releaseOne() throws Exception {
        logger.info("进入ProductController-releaseOne,商品发布第一步");

        FormMap requestMap = getFormMap();

        //oneflag  缓存标志  有值是代表需要缓存；两个场景进入    1直接发布商品  2 第二步返回
        if ("".equals(requestMap.getStr("oneflag").toString())) {
            this.getSession().removeAttribute("productSession");
            this.getRequest().setAttribute("saveStatus", requestMap.getStr("saveStatus"));
            getProductSession(requestMap);
            return "/center/product/releaseOne";
        }

        //从第二步返回第一步  需保存的规格参数ID
        List idslist = new ArrayList();
        for (Iterator iterator = requestMap.keySet().iterator(); iterator.hasNext(); ) {
            String name = (String) iterator.next();
            //myAttributeValueIds??
            if (name.indexOf("mattvalids") != -1) {
                idslist.add(requestMap.get(name));
            }
        }
        requestMap.put("idslist", idslist);

        //从第二步返回第一步  需保存的规格参数
        //spec_config 0 统一规格 1 多规格
        if (requestMap.get("spec_config") != null && requestMap.get("spec_config").toString().equals("1")) {
            int rowCount = Integer.parseInt(requestMap.get("rowCount").toString());
            List skulist = new ArrayList();
            for (int i = 0; i < rowCount; i++) {
                Map sukMap = new HashMap();
                sukMap.put("item_num", requestMap.get("itemNumlist" + i));
                sukMap.put("smarket_price", requestMap.get("smarketPricelist" + i));
                sukMap.put("sale_price", requestMap.get("salePricelist" + i));
                sukMap.put("stock", requestMap.get("stocklist" + i));
                skulist.add(sukMap);
            }
            requestMap.put("skulist", skulist);
        }

        //mitems  myItems?
        //属性值
        if (requestMap.get("mitems") != null) {
            if (requestMap.get("mitems").getClass().getName().equals("java.lang.String")) {
                requestMap.put("mitemsCount", 1);
            } else if (requestMap.get("mitems").getClass().isArray()) {
                requestMap.put("mitemsCount", 2);
            }
        }

        //商品分组
        if (requestMap.get("tag_id_str") != null) {
            if (requestMap.get("tag_id_str").getClass().getName().equals("java.lang.String")) {
                requestMap.put("tag_id_count", 1);
            } else if (requestMap.get("tag_id_str").getClass().isArray()) {
                requestMap.put("tag_id_count", 2);
            }
        }
        getProductSession(requestMap);
        return "/center/product/releaseOne";
    }

    /**
     * 商品发布三个步面跳转 缓存数据
     *
     * @author hzy
     */
    public FormMap getProductSession(FormMap map) throws Exception {
        if (this.getSession().getAttribute("productSession") != null) {
            FormMap productSession = (FormMap) this.getSession().getAttribute("productSession");
            productSession.putAll(map);
            this.getSession().setAttribute("productSession", productSession);
            return productSession;
        } else {
            this.getSession().setAttribute("productSession", map);
            return map;
        }
    }

    /**
     * 商品发布第二步
     *
     * @author hzy
     */
    @RequestMapping("/releaseTwo")
    public String releaseTwo() throws Exception {
        logger.info("进入ProductController-releaseTwo,商品发布第二步");

        FormMap requestMap = getFormMap();
        if (!requestMap.getStr("validate_id").equals("")) {
            requestMap.set("product_id", requestMap.get("validate_id"));
        }

        if (requestMap.get("oneflag") == null || "".equals(requestMap.get("oneflag").toString())) {
            this.getSession().removeAttribute("productSession");
        }

        if (requestMap.get("product_id") != null && !requestMap.get("product_id").toString().equals("")) {

            this.getSession().removeAttribute("productSession");

            Map product = productService.selectOne(requestMap);

            List imagesList = new ArrayList();
            //获取产品图片  可优化
            List imgist = productService.selectImagesList(requestMap);
            for (int i = 0; i < imgist.size(); i++) {
                Map map = (Map) imgist.get(i);
                imagesList.add(map.get("product_img"));
            }
            requestMap.put("imagesList", imagesList);


            requestMap.putAll(product);


            if (product.get("attribute_custom") != null) {
                //商品属性
                String[] attarr = product.get("attribute_custom").toString().split("\\|");
                requestMap.put("mitemsCount", 2);
                requestMap.put("mitems", attarr);
            }

            //分组列表
            List<E> groupDetailList = productGroupService.selectDetailList(requestMap);

            if (groupDetailList != null) {
                List groupIdList = new ArrayList();
                for (E e : groupDetailList) {
                    groupIdList.add(e.get("group_id"));
                }

//				for (Iterator iterator = groupDetailList.iterator(); iterator.hasNext();) {
//					E info = (E) iterator.next();
//					tag.add(info.get("group_id"));
//				}
                requestMap.put("tag_id_count", 2);
                requestMap.put("tag_id_str", groupIdList);
            }

            //商品item
            requestMap.put("is_deleted", 0);
            List itemList = productService.selectItemList(requestMap);

            //itemIds
            List idslist = new ArrayList();
            for (int i = 0; i < itemList.size(); i++) {
                if (itemList.get(i) != null) {
                    Map map = (Map) itemList.get(i);
                    if (map.get("spec_custom") != null) {
                        String attValArr = map.get("spec_custom").toString();
                        String[] arr = attValArr.split(";");
                        if (arr != null && arr.length > 0) {
                            for (int j = 0; j < arr.length; j++) {
                                idslist.add(arr[j]);
                            }
                        }
                    }
                }
            }
            requestMap.put("idslist", idslist);

            if (product.get("spec_config") != null && product.get("spec_config").toString().equals("0")
                    && itemList != null && itemList.size() > 0) {
                Map item = (Map) itemList.get(0);
                requestMap.put("item_num", item.get("item_num"));
                requestMap.put("item_id", item.get("item_id"));
                requestMap.put("smarket_price", item.get("smarket_price"));
                requestMap.put("sale_price", item.get("sale_price"));
                requestMap.put("stock", item.get("stock"));
                requestMap.put("item_id", item.get("item_id"));
            } else {
                requestMap.put("skulist", itemList);
                requestMap.put("rowCount", itemList.size());
            }

            List<E> desclist = productService.selectProductDescList(requestMap);
            if (desclist != null && desclist.size() > 0) {
                requestMap.put("editorValue", desclist.get(0).get("product_desc"));
            }

            //商品是否在参与活动中
            requestMap.put("activity", productService.isJoinActivity(requestMap));
        }

        requestMap = getProductSession(requestMap);

        String cateId = "";
        if (requestMap.get("thirdCateId") != null && !requestMap.get("thirdCateId").toString().equals("") && !requestMap.get("thirdCateId").toString().equals("0")) {
            cateId = requestMap.get("thirdCateId").toString();
        } else if (requestMap.get("secondCateId") != null && !requestMap.get("secondCateId").toString().equals("") && !requestMap.get("secondCateId").toString().equals("0")) {
            cateId = requestMap.get("secondCateId").toString();
        } else {
            cateId = requestMap.get("firstCateId").toString();
        }
        requestMap.put("cate_id", cateId);

        List attrList = productService.selectAttrList(requestMap);
        this.getRequest().setAttribute("attrList", attrList);

        FormMap shipMap = new FormMap();
        shipMap.put("shop_id", requestMap.get("shop_id"));
        List shipList = shippingService.selectList(shipMap);
        this.getRequest().setAttribute("shipList", shipList);

        List tagList = productGroupService.selectList(requestMap);
        this.getRequest().setAttribute("tagList", tagList);

        return "/center/product/releaseTwo";
    }

    /**
     * 商品发布第三步
     *
     * @author hzy
     */
    @RequestMapping("/releaseThree")
    public String releaseThree() throws Exception {
        logger.info("进入ProductController-releaseThree,商品发布第三步");

        FormMap requestMap = this.getFormMap();

        //上传文件
        try {
            // 转型为MultipartHttpRequest：
            MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) this.getRequest();
            // 获得文件：
            List imagesList = new ArrayList();
            String[] imgArr = this.getRequest().getParameterValues("imagesList");
            if (imgArr != null) {
                List arrlist = Arrays.asList(imgArr);
                imagesList = new ArrayList(arrlist);
            }
            Map<String, MultipartFile> fileMap = multipartRequest.getFileMap();
            if (fileMap != null && !fileMap.isEmpty()) {
                for (Iterator iterator = fileMap.keySet().iterator(); iterator.hasNext(); ) {
                    String key = iterator.next().toString();
                    MultipartFile mFile = fileMap.get(key);
                    if (!mFile.isEmpty()) {
                        String pictureName = WeiitUtil.uploadFile(mFile);
                        imagesList.add(pictureName);
                    }
                }
            }
            requestMap.put("imagesList", imagesList);
        } catch (Exception e) {
            e.printStackTrace();
            throw new Exception("出错啦...");
        }

        if (requestMap.get("oneflag") == null || "".equals(requestMap.get("oneflag").toString())) {
            this.getSession().removeAttribute("productSession");
        }


        List idslist = new ArrayList();
        for (Iterator iterator = requestMap.keySet().iterator(); iterator.hasNext(); ) {
            String name = (String) iterator.next();
            if (name.indexOf("mattvalids") != -1) {
                idslist.add(requestMap.get(name));
            }
        }
        requestMap.put("idslist", idslist);

        if (requestMap.get("spec_config") != null && requestMap.get("spec_config").toString().equals("1")) {
            int rowCount = Integer.parseInt(requestMap.get("rowCount").toString());
            List skulist = new ArrayList();
            for (int i = 0; i < rowCount; i++) {
                Map sukMap = new HashMap();
                sukMap.put("item_num", requestMap.get("itemNumlist" + i));
                sukMap.put("smarket_price", requestMap.get("smarketPricelist" + i));
                sukMap.put("sale_price", requestMap.get("salePricelist" + i));
                sukMap.put("stock", requestMap.get("stocklist" + i));
                skulist.add(sukMap);
            }
            requestMap.put("skulist", skulist);
        }
        if (requestMap.get("mitems") != null) {
            if (requestMap.get("mitems").getClass().getName().equals("java.lang.String")) {
                requestMap.put("mitemsCount", 1);
            } else if (requestMap.get("mitems").getClass().isArray()) {
                requestMap.put("mitemsCount", 2);
            }
        }
        if (requestMap.get("tag_id_str") != null) {
            if (requestMap.get("tag_id_str").getClass().getName().equals("java.lang.String")) {
                requestMap.put("tag_id_count", 1);
            } else if (requestMap.get("tag_id_str").getClass().isArray()) {
                requestMap.put("tag_id_count", 2);
            }
        }
        if (this.getSession().getAttribute("productSession") != null) {
            FormMap productSession = (FormMap) this.getSession().getAttribute("productSession");
            if (requestMap.get("tag_id_str") == null) {
                productSession.remove("tag_id_str");
            }
            productSession.putAll(requestMap);
            this.getSession().setAttribute("productSession", productSession);
        }
        return "/center/product/releaseThree";
    }


    /**
     * 商品发布第一步  js获取二级，三级分类
     *
     * @author hzy
     */
    @ResponseBody
    @RequestMapping("/productCate")
    public String productCate() throws Exception {
        logger.info("【异步】进入ProductController-productCate,商品第一步js获取二、三级分类");

        try {
            FormMap map = this.getFormMap();
            List secondCateList = productService.selectCateList(map);
            logger.info("【异步返回json】:" + this.toJsonAPI(secondCateList));
            return this.toJsonAPI(secondCateList);
        } catch (Exception e) {
            e.printStackTrace();
            return toJsonAPI("", "操作异常：" + e.getMessage(), "-1");
        }

    }

    /**
     * 商品发布第二步  属性 新增保存
     *
     * @author hzy
     */
    @ResponseBody
    @RequestMapping("/attrSave")
    public String attrSave() throws Exception {
        logger.info("【异步】进入ProductController-attrSave,商品发布第二步-属性新增保存");

        try {
            FormMap param = this.getFormMap();
            param.put("attributeName", URLDecoder.decode(param.get("attributeName").toString(), "UTF-8"));
            param.put("attributeValueName", URLDecoder.decode(param.get("attributeValueName").toString(), "UTF-8"));

            productService.insertAttr(param);
            logger.info("【异步返回json】:" + this.toJsonAPI(param));
            return this.toJsonAPI(param);
        } catch (Exception e) {
            e.printStackTrace();
            return toJsonAPI("", "操作异常：" + e.getMessage(), "-1");
        }
    }

    /**
     * 商品发布第二步  属性  删除
     *
     * @author hzy
     */
    @ResponseBody
    @RequestMapping("/removeAttr")
    public String removeAttr() throws Exception {
        logger.info("【异步】进入ProductController-removeAttr,商品发布第二步-属性删除");

        try {
            FormMap param = this.getFormMap();
            productService.removeAttr(param);
            logger.info("【异步返回json】:" + this.toJsonAPI("删除成功"));
            return this.toJsonAPI("删除成功！");
        } catch (Exception e) {
            e.printStackTrace();
            return toJsonAPI("", "操作异常：" + e.getMessage(), "-1");
        }
    }

    /**
     * 商品发布第二步  属性值 查询
     *
     * @author hzy
     */
    @ResponseBody
    @RequestMapping("/attrValList")
    public String attrValList() throws Exception {
        logger.info("【异步】进入ProductController-attrValList,商品发布第二步-属性值查询");

        try {
            FormMap map = this.getFormMap();
            List attrValList = productService.selectAttrList(map);
            logger.info("【异步返回json】:" + this.toJsonAPI(attrValList));
            return this.toJsonAPI(attrValList);
        } catch (Exception e) {
            e.printStackTrace();
            return toJsonAPI("", "操作异常：" + e.getMessage(), "-1");
        }
    }

    /**
     * 商品发布第二步  属性值  新增保存
     *
     * @author hzy
     */
    @ResponseBody
    @RequestMapping("/attrValSave")
    public String attrValSave() throws Exception {
        logger.info("【异步】进入ProductController-attrValSave,商品发布第二步-属性值新增保存");

        try {
            FormMap param = this.getFormMap();
            param.put("parent_id", param.get("attributeId"));
            param.put("key_name", param.get("attributeValueName"));
            productService.insertAttrVal(param);
            logger.info("【异步返回json】:" + this.toJsonAPI(param));
            return this.toJsonAPI(param);
        } catch (Exception e) {
            e.printStackTrace();
            return toJsonAPI("", "操作异常：" + e.getMessage(), "-1");
        }
    }

    /**
     * 商品发布第二步  属性值 删除
     *
     * @author hzy
     */
    @ResponseBody
    @RequestMapping("/removeAttrVal")
    public String removeAttrVal() throws Exception {
        logger.info("【异步】进入ProductController-removeAttrVal,商品发布第二步-属性值删除");

        try {
            FormMap param = this.getFormMap();
            productService.removeAttrVal(param);
            logger.info("【异步返回json】:" + this.toJsonAPI("删除成功"));
            return this.toJsonAPI("删除成功！");
        } catch (Exception e) {
            e.printStackTrace();
            return toJsonAPI("", "操作异常：" + e.getMessage(), "-1");
        }
    }

    /**
     * 商品发布  保存
     *
     * @author hzy
     */
    @RequestMapping("/save")
    public String saveProduct() throws Exception {
        logger.info("进入ProductController-saveProduct,商品发布保存");

        String retUrl = "redirect:onSaleList";
        try {
            FormMap requestMap = this.getFormMap();
            requestMap = getProductSession(requestMap);
            String saleOld = requestMap.getStr("saleOld");
            if (saleOld.equals("2")) {
                retUrl = "redirect:soldOutList";
            } else if (saleOld.equals("3")) {
                retUrl = "redirect:forSaleList";
            }
            if (requestMap.get("product_id") == null || requestMap.get("product_id").equals("")) {
                productService.insert(requestMap);
            } else {
                productService.edit(requestMap);
            }
            this.getSession().removeAttribute("productSession");
        } catch (Exception e) {
            e.printStackTrace();
            throw new Exception("出错啦...");
        }
        return retUrl;
    }

    /**
     * 商品发布修改    上架，下架，删除状态
     *
     * @author hzy
     */
    @RequestMapping("/status")
    public String status() throws Exception {
        logger.info("进入ProductController-status,商品发布修改-上架下架删除状态");

        String retUrl = "redirect:onSaleList";
        try {
            FormMap formMap = getFormMap();
            formMap.set("eivt", "state");

            if (StringUtils.isNotBlank(formMap.getStr("mfalg"))) {
                String[] validate_id = (String[]) this.getRequest().getParameterValues("validate_id");
                for (int i = 0; i < validate_id.length; i++) {
                    formMap.set("product_id", validate_id[i]);
                    productService.editStatus(formMap);
                }
            } else {
                formMap.set("product_id", formMap.get("validate_id"));
                productService.editStatus(formMap);
            }
            String saleOld = formMap.getStr("saleOld");
            if (saleOld.equals("2")) {
                retUrl = "redirect:soldOutList";
            } else if (saleOld.equals("3")) {
                retUrl = "redirect:forSaleList";
            }
        } catch (Exception e) {
            e.printStackTrace();
            throw new Exception("出错啦...");
        }
        return retUrl;
    }


    /**
     * 查看商品详情
     *
     * @author hzy
     */
    @RequestMapping("/productDetail")
    public String productDetail() throws Exception {
        logger.info("进入ProductController-productDetail,商品详情");
        FormMap requestMap = getFormMap();
        if (requestMap.get("validate_id") != null && !requestMap.get("validate_id").toString().equals("")) {
            String product_id = requestMap.getStr("product_id");
            if (product_id.equals("")) {
                requestMap.set("product_id", requestMap.get("validate_id"));
            }

            Map product = productService.selectOne(requestMap);

            List imagesList = new ArrayList();
            List imgist = productService.selectImagesList(requestMap);
            for (int i = 0; i < imgist.size(); i++) {
                Map map = (Map) imgist.get(i);
                imagesList.add(map.get("product_img"));
            }
            requestMap.put("imagesList", imagesList);
            requestMap.putAll(product);

            if (!requestMap.getStr("spec_custom").equals("")) {
                requestMap.put("guigeList", requestMap.getStr("spec_custom").split(";"));
            }


            if (product.get("attribute_custom") != null) {
                //商品属性
                String[] attarr = product.get("attribute_custom").toString().split("\\|");
                String[] att = new String[attarr.length];
                for (int i = 0; i < attarr.length; i++) {
                    att[i] = attarr[i].substring(attarr[i].indexOf(":") + 1);
                }
                requestMap.put("mitemsCount", 2);
                requestMap.put("mitems", att);
            }
            List itemList = productService.selectItemList(requestMap);

            List idslist = new ArrayList();


            for (int i = 0; i < itemList.size(); i++) {
                if (itemList.get(i) != null) {
                    Map map = (Map) itemList.get(i);
                    if (map.get("spec_custom") != null) {
                        String attValArr = map.get("spec_custom").toString();
                        String[] arr = attValArr.split(";");
                        if (arr != null && arr.length > 0) {
                            for (int j = 0; j < arr.length; j++) {
                                if (!idslist.contains(arr[j])) {
                                    idslist.add(arr[j]);
                                }
                            }
                        }
                    }
                }
            }
            requestMap.put("idslist", idslist);

            if (product.get("spec_config") != null && product.get("spec_config").toString().equals("0") && itemList != null && itemList.size() > 0) {
                Map item = (Map) itemList.get(0);
                requestMap.put("item_num", item.get("item_num"));
                requestMap.put("bar_code", item.get("bar_code"));
                requestMap.put("smarket_price", item.get("smarket_price"));
                requestMap.put("sale_price", item.get("sale_price"));
                requestMap.put("stock", item.get("stock"));
            } else {
                requestMap.put("skulist", itemList);
                requestMap.put("rowCount", itemList.size());
            }

            List<E> desclist = productService.selectProductDescList(requestMap);
            if (desclist != null && desclist.size() > 0) {
                requestMap.put("editorValue", desclist.get(0).get("product_desc"));
            }

            String cateId = "";
            if (requestMap.get("thirdCateId") != null && !requestMap.get("thirdCateId").toString().equals("") && !requestMap.get("thirdCateId").toString().equals("0")) {
                cateId = requestMap.get("thirdCateId").toString();
            } else if (requestMap.get("secondCateId") != null && !requestMap.get("secondCateId").toString().equals("") && !requestMap.get("secondCateId").toString().equals("0")) {
                cateId = requestMap.get("secondCateId").toString();
            } else {
                cateId = requestMap.get("firstCateId").toString();
            }
            requestMap.put("cate_id", cateId);

            List<E> attrList = productService.selectAttrList(requestMap);
            this.getRequest().setAttribute("attrList", attrList);
        }
        this.getRequest().setAttribute("product", requestMap);
        return "/center/product/productDetail";
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
            //中文乱码
            formMap.set("product_name", new String(formMap.getStr("product_name").getBytes("ISO-8859-1")));
            List<E> productList = productService.selectList(formMap);
            List<E> productJson = new ArrayList<E>();
            for (E e : productList) {
                E productInfo = new E();
                productInfo.set("product_info", "<img src='" + WeiitUtil.getFileDomain() + e.getStr("product_img") + "' width='60px' height='60px'/>" + e.getStr("product_name"));
                productInfo.set("sale_price", e.getStr("sale_price"));
                productInfo.set("stock", e.getStr("stock"));

                productInfo.set("option", "<a href='javascript:;'   title='选取' class='btn bg-green m-r-5 m-b-5 able_product_" + e.getStr("product_id") + "' style='height: 22px;padding-top: 0px;' onclick='selectProduct(" + e.getStr("product_id") + ",\"" + e.getStr("product_name") + "\")' >选取</a>");

                productJson.add(productInfo);
            }
            return toJsonAPI(productJson);
        } catch (Exception e) {
            e.printStackTrace();
            throw new Exception("出错啦...");
        }
    }


    /**
     * 微页面装修  商品列表  选择商品
     */
    @RequestMapping(value = "/productListForPage", method = RequestMethod.GET)
    @ResponseBody
    public E productListForPage(@RequestParam String token, Integer page, Integer rows, String product_name) {
        logger.info("进入ProductGroupController-productList,微页面商品列表选择商品");
        FormMap formMap = new FormMap();
        E result = new E();
        try {
            formMap.put("shop_id", DesUtil.decrypt(token));
        } catch (Exception e) {
            e.printStackTrace();
            logger.error("token 解密失败");
            result.put("productList", null);
            return result;
        }
        formMap.put("product_name", product_name);
        formMap.put("page", page);
        formMap.put("rows", rows);
        PageHelper.startPage(formMap.getPage(), formMap.getRows());
        List<E> list = productService.productListForPage(formMap);

        result.put("productList", new PageInfo<E>(list));
        //绑定上一次参数
        return result;
    }

    @RequestMapping(value = "/productListForPageNotoken", method = RequestMethod.GET)
    @ResponseBody
    public E productListForPageNotoken( Integer page, Integer rows, String product_name) {
        logger.info("进入ProductGroupController-productListForPageNotoken,微页面商品列表选择商品");
        FormMap formMap = getFormMap();
        E result = new E();

        formMap.put("product_name", product_name);
        formMap.put("page", page);
        formMap.put("rows", rows);
        PageHelper.startPage(formMap.getPage(), formMap.getRows());
        List<E> list = productService.productListForPage(formMap);

        result.put("productList", new PageInfo<E>(list));
        //绑定上一次参数
        return result;
    }


    /**
     * 微页面 回显 商品
     *
     * @author lhq
     * @date 2018年5月7日
     */
    @RequestMapping(value = "/getProductListByIds", method = RequestMethod.GET)
    @ResponseBody
    public E getProductListByIds(@RequestParam String token, Integer page, Integer rows, Integer productGetType, String productIds) {
        logger.info("进入ProductGroupController-getProductListByIds,获取商品");
        FormMap formMap = new FormMap();
        E result = new E();
        try {
            formMap.put("shop_id", DesUtil.decrypt(token));
        } catch (Exception e) {
            e.printStackTrace();
            logger.error("token 解密失败");
            result.put("productInfo", "null");
            return result;
        }

        List<E> list;
        formMap.put("page", page);
        formMap.put("rows", rows);
        PageHelper.startPage(formMap.getPage(), formMap.getRows());
        if (StringUtils.isNotEmpty(productIds) && productGetType == 0) {
            formMap.put("productIds", StringUtils.strip(productIds, "[]").split(","));
            list = productService.getProductListByIds(formMap);
        } else {
            list = productService.autoGetProduct(formMap);
        }
        result.put("productInfo", list);
        //绑定上一次参数
        return result;
    }


    @ResponseBody
    @RequestMapping("/getProductById")
    public E getProductById() {
        E result = new E();
        FormMap formMap = getFormMap();
        E product = productService.selectOne(formMap);

        result.put("spec_config", product.getInt("spec_config"));
        result.put("product", product);
        formMap.put("is_deleted", 0);
        List<E> list = productService.selectItemList(formMap);
        //若是多规格  返回多规格参数
        if (list != null ) {

            if (list.size()>1){
                result.put("itemList", list);
                //查询多规格属性<tr>
                String spec_custom = product.getStr("spec_custom");
                String[] specIds = spec_custom.split(";");
                formMap.put("specIds", specIds);
                List<E> specList = productService.getSpecCustomByIds(formMap);
                result.put("specList", specList);
                //查询多规格属性<td>
                for (E e : list) {
                    formMap.put("specIds", e.getStr("spec_custom").split(";"));
                    e.put("specDesc", productService.getSpecCustomByIds(formMap));
                }
            }else if (list.size()==1){
                result.put("item_id", list.get(0).get("item_id"));
                result.put("spec_custom", list.get(0).get("spec_custom"));
                result.put("sale_price", list.get(0).get("sale_price"));
            }
        }

        return result;
    }


    @RequestMapping(value = "/getProductByGroupId")
    @ResponseBody
    public String getProductByGroupId(@RequestParam String token, @RequestParam Integer group_id, Integer showNum) {
        logger.info("进入ProductController-getProductByGroupIds,微页面  商品分组获取商品基本信息");
        FormMap formMap = new FormMap();
        //根据group_id 返回分组下的商品
        try {
            formMap.put("shop_id", DesUtil.decrypt(token));
        } catch (Exception e) {
            e.printStackTrace();
            logger.error(" 解密失败");
            return "";
        }
        formMap.put("group_id", group_id);
        //获取分组下的商品
        if (showNum!=null && showNum>0){
            PageHelper.startPage(1,showNum);
        }
        List<E> list = productGroupService.getProductByGroupId(formMap);
        E groupInfo = new E();
        if (list != null && list.size() > 0) {
            groupInfo.put("productInfo", list);
            groupInfo.put("group_name", list.get(0).getStr("group_name"));
            groupInfo.put("group_id", group_id);
        }
        return toJsonAPI(groupInfo);
    }

}