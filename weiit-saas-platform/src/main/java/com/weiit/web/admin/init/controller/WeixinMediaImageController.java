package com.weiit.web.admin.init.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.weiit.core.entity.E;
import com.weiit.core.entity.FormMap;
import com.weiit.resource.common.utils.WeiitUtil;
import com.weiit.web.admin.init.service.AgreementService;
import com.weiit.web.admin.init.service.NotifyService;
import com.weiit.web.admin.init.service.WeixinMediaImageService;
import com.weiit.web.common.AdminController;
import com.weiit.web.common.UIview;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import javax.annotation.Resource;
import java.util.List;

/**
 * Created by Administrator on 2018-07-03.
 */

@Controller
@RequestMapping(value = "/weixinMedia")
public class WeixinMediaImageController extends AdminController{

    @Resource
    private WeixinMediaImageService weixinMediaImageService;

    /**
     * 微信公共图片分类列表
     */
    @RequestMapping("/weixinMediaImageCateList")
    public UIview cateList(){
    	
        FormMap formMap=getFormMap();
        PageHelper.startPage(formMap.getPage(),formMap.getRows());
        List<E> imagelist = weixinMediaImageService.selectList(formMap);
        UIview view =UIView("/center/init/weixinMediaImageCateList",false);
        view.addObject("pageInfo",new PageInfo<E>(imagelist));
        return view;
    }

    /**
     * 微信公共图片分类新增&编辑
     */
    @RequestMapping("/weixinMediaImageCateEdit")
    public UIview cateEdit(){
    	
        FormMap formMap=getFormMap();
        E sortInfo=weixinMediaImageService.selectOne(formMap);
        UIview view =UIView("/center/init/weixinMediaImageCateEdit",false);
        view.addObject("infoMap",sortInfo);
        return view;
    }

    /**
     * 微信公共图片列表
     */
    @RequestMapping("/weixinMediaImageList")
    public UIview imageList(){
    	
        FormMap formMap=getFormMap();
        PageHelper.startPage(formMap.getPage(),16);
        List<E> imageList = weixinMediaImageService.selectImageList(formMap);
        List<E> sortList = weixinMediaImageService.selectImageCateList(formMap);
        UIview view =UIView("/center/init/weixinMediaImageList",false);
        view.addObject("pageInfo",new PageInfo<E>(imageList));
        view.addObject("sortList",sortList);
        view.addObject("formMap",formMap);
        return view;
    }

    /**
     * 微信公共图片分类新增&编辑 保存
     */
    @RequestMapping("/save")
    public UIview save(){

        FormMap formMap=getFormMap();
        if (formMap.getStr("cate_id")==null || formMap.getStr("cate_id").equals("")){
            weixinMediaImageService.insert(formMap);
        }else{
            weixinMediaImageService.edit(formMap);
        }
        UIview view =UIView("redirect:weixinMediaImageCateList",false);
        return view;
    }

    /**
     * 微信公共图片分类置顶
     */
    @RequestMapping("/sort")
    public UIview sort(){

        FormMap formMap=getFormMap();
        E sortInfo=weixinMediaImageService.selectSort(formMap);
        formMap.put("sort_num",sortInfo.getInt("sort_num")+1);
        weixinMediaImageService.edit(formMap);
        UIview view =UIView("redirect:weixinMediaImageCateList",false);
        return view;
    }


    /**
     * 微信公共图片插入
     */
    @RequestMapping("/insertImage")
    public UIview insertImage()throws Exception{

        FormMap formMap=getFormMap();
        try {
            // 转型为MultipartHttpRequest：
            MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) this.getRequest();
            // 获得文件：
            MultipartFile cate_image = multipartRequest.getFile("file");
            if( !cate_image.isEmpty()){
                String image= WeiitUtil.uploadFile(cate_image);
                formMap.put("image_url", image);
            }
            weixinMediaImageService.insertImage(formMap);

        } catch (Exception e) {
            e.printStackTrace();
            throw new Exception("出错啦...");
        }
        UIview view =UIView("redirect:weixinMediaImageList",false);
        return view;
    }


    /**
     * 微信公共图片删除
     */
    @RequestMapping("/imageDelete")
    public UIview imageDelete(){

        FormMap formMap=getFormMap();
        weixinMediaImageService.remove(formMap);
        UIview view =UIView("redirect:weixinMediaImageList",false);
        return view;
    }

}
