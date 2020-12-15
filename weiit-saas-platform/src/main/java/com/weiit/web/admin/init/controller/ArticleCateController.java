package com.weiit.web.admin.init.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.weiit.core.entity.E;
import com.weiit.core.entity.FormMap;
import com.weiit.core.view.UIview;
import com.weiit.web.admin.init.service.ArticleCateService;
import com.weiit.web.common.AdminController;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.annotation.Resource;

import java.util.List;

/**
 * Created by Administrator on 2018-07-07.
 */
@Controller
@RequestMapping("/articleCate")
public class ArticleCateController extends AdminController{

    @Resource
    private ArticleCateService articleCateService;

    @RequestMapping("/list")
    public UIview articleList(){
        FormMap formMap=getFormMap();
        PageHelper.startPage(formMap.getPage(),formMap.getRows());
        List<E> cateInfp = articleCateService.selectCateList(formMap);
        UIview view=UIView("/center/init/articleCateList",false);
        view.addObject("pageInfo",new PageInfo<E>(cateInfp));
        return view;
    }

    /**
     * 添加图文分类
     */
    @RequestMapping("/add")
    public UIview addAgreement(){
        logger.info("进入 UserController-add,添加图文分类");
        FormMap formMap = getFormMap();
        UIview view=UIView("/center/init/articleCateEdit",false);
        return view;
    }


    /**
     * 新增服务协议     编辑保存
     */
    @RequestMapping("/save")
    public UIview insertAgreement(){
        logger.info("进入 UserController-save,添加图文分类");
        FormMap formMap = getFormMap();
        if (formMap.getStr("cate_id")==null || formMap.getStr("cate_id").equals("")){
            articleCateService.insert(formMap);
        }else{
            articleCateService.edit(formMap);
        }
        UIview view=UIView("redirect:list",false);
        return view;
    }

    /**
     * 图文分类编辑
     */
    @RequestMapping("/edit")
    public UIview edit(){
        logger.info("进入 UserController-edit,添加图文分类");
        FormMap formMap=getFormMap();
        E articleInfo = articleCateService.selectOne(formMap);
        UIview view = UIView("/center/init/articleCateEdit",false);
        view.addObject("infoMap",articleInfo);
        return view;
    }

    @RequestMapping("/sort")
    public UIview sort(){
        logger.info("进入 UserController-edit,图文分类置顶");
        FormMap formMap=getFormMap();
        E sortInfo=articleCateService.selectSort(formMap);
        formMap.put("sort_num",sortInfo.getInt("sort_num")+1);
        articleCateService.editSort(formMap);
        UIview view = UIView("redirect:list",false);
        return view;
    }

}
