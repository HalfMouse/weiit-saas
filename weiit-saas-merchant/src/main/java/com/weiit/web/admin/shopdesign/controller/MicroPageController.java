package com.weiit.web.admin.shopdesign.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.weiit.core.entity.E;
import com.weiit.core.entity.FormMap;
import com.weiit.web.admin.shopdesign.service.PageService;
import com.weiit.web.base.AdminController;
import com.weiit.web.base.UIview;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.List;



/**
 * Description:  微页面设置
 * @author lhq
 * @date 2018年4月27日
 */
@Controller
@RequestMapping(value = "/design/page")
public class MicroPageController extends AdminController {
    public static Logger logger=Logger.getLogger(MicroPageController.class);
    @Resource
    private PageService pageService;



    /**
     * @author hzy
     * @date 2018年4月27日
     */
    @RequestMapping("/pageList")
    public UIview pageList() {
        logger.info("进入 MicroPageController-pageList,微页面列表");
        UIview result=UIView("/center/design/page/pageList",false);
        FormMap formMap = getFormMap();
        PageHelper.startPage(formMap.getPage(), formMap.getRows());
        List<E> pageList = pageService.selectList(formMap);
        for (E page:pageList){
            page.put("page_view",pageService.pageView(page));
        }

        result.addObject("pageInfo", new PageInfo<E>(pageList));
        result.addObject("queryParam", formMap);
        return result;
    }

    /**
     * 跳转新增微页面
     * @author hzy
     * @date 2018年4月27日
     */
    @RequestMapping("/pageAdd")
    public UIview pageAdd() {
        logger.info("进入 MicroPageController-pageAdd,跳转新增微页面");

        UIview result=UIView("/center/design/page/pageEdit",false);
        this.getRequest().setAttribute("title", "微页面新增");
        return result;
    }

    /**
     * 跳转微页面编辑
     * @author
     * @date 2018年4月27日
     */
    @RequestMapping("/pageEdit")
    public UIview pageEidt() {
        logger.info("进入 MicroPageController-pageEidt,跳转微页面编辑");
        try {
            FormMap formMap=getFormMap();
            E infoMap=pageService.selectOne(formMap);

            this.getRequest().setAttribute("infoMap", infoMap);
            this.getRequest().setAttribute("title", "微页面编辑");
        } catch (Exception e) {
            e.printStackTrace();
        }
        UIview result=UIView("/center/design/page/pageEdit",false);
        return result;
    }

    /**
     * @author
     * @date 2018年4月27日
     */
    @RequestMapping("/pageSave")
    public UIview pageSave() throws Exception {
        logger.info("进入 MicroPageController-pageSave,微页面装修保存");
        FormMap param=getFormMap();

        if(param.get("validate_id")==null || param.get("validate_id").equals("")){
                pageService.insert(param);
        }else{
                pageService.edit(param);
        }

        UIview result=UIView("pageList",true);

        return result;
    }

    /**
     * 微页面装修删除
     * @date 2018年4月27日
     */
    @RequestMapping("/pageRemove")
    public UIview pageRemove() throws Exception {
        logger.info("进入 MicroPageController-pageRemove,微页面装修删除");
        try {
            FormMap param=getFormMap();
            pageService.remove(param);
        } catch (Exception e) {
            e.printStackTrace();
            throw new Exception("出错啦...");
        }
        UIview result=UIView("pageList",true);
        return result;
    }

    /**
     * @author hzy
     * @date 2018年4月27日
     */
    @RequestMapping("/pageDefault")
    public UIview pageDefault() throws Exception {
        logger.info("进入 MicroPageController-pageDefault,微页面设置主页");
        try {
            FormMap param=getFormMap();
            pageService.pageDefault(param);
        } catch (Exception e) {
            e.printStackTrace();
            throw new Exception("出错啦...");
        }
        UIview result=UIView("pageList",true);
        return result;
    }

    /**
     *
     * @date 2018年4月27日
     */
    @ResponseBody
    @RequestMapping("/pageList.json")
    public String pageListJson() throws Exception {
        logger.info("MicroPageController-pageList.json,微页面列表");
        try {
            FormMap formMap=getFormMap();
            formMap.set("page_name", new String(formMap.getStr("page_name").getBytes("ISO-8859-1")));//中文乱码
            List<E> productList=pageService.selectList(formMap);
            List<E> productJson=new ArrayList<E>();
            for (E e : productList) {
                E productInfo=new E();
                productInfo.set("page_name", e.getStr("page_name"));
                productInfo.set("create_time", e.getStr("create_time"));

                productInfo.set("option", "<a href='javascript:;'   title='选取' class='btn bg-green m-r-5 m-b-5 able_custom_"+e.getStr("validate_id")+"' style='height: 22px;padding-top: 0px;' onclick='selectProduct("+e.getStr("validate_id")+",\""+e.getStr("page_name")+"\")' >选取</a>");

                productJson.add(productInfo);
            }
            return toJsonAPI(productJson);
        } catch (Exception e) {
            e.printStackTrace();
            throw new Exception("出错啦...");
        }
    }


    /**
     * 新增微页面  选择模板
     * @author hzy
     */
    @RequestMapping("/newPageModal")
    public UIview editProductTag(){
        logger.info("MicroPageController-newPageModal,新增微页面  选择模板");
        UIview result = UIView("/center/design/page/newPageModal",false);
        //查询平台模板
        List<E> templatePageList = pageService.selectTemplateCate(null);

        //查询全部模版下的page
        List<E> pageList = pageService.selectTemplatePage(null);

        this.getSession().setAttribute("templatePageList",templatePageList);
        this.getSession().setAttribute("pageList",pageList);

        return result;
    }


    @RequestMapping(value = "getTemplatePageJson")
    @ResponseBody
    public E getTemplatePageJson(@RequestParam Integer templateId){
            return pageService.getTemplatePageJson(templateId);
    }
}
