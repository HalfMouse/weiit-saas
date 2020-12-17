package com.weiit.web.admin.setting.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.weiit.core.entity.E;
import com.weiit.core.entity.FormMap;
import com.weiit.core.view.UIview;
import com.weiit.web.admin.publics.service.PublicsService;
import com.weiit.web.admin.setting.service.AddressService;
import com.weiit.web.base.AdminController;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.annotation.Resource;
import java.util.List;

/**
 * Created by Administrator on 2018-04-28.
 */
@Controller
@RequestMapping(value = "/setting")
public class AddressController extends AdminController{

    @Resource
    private AddressService addressService;

    @Resource
    private PublicsService publicsService;

    /**
     *  地址库  列表查询
     */
    @RequestMapping("/shopAddress")
    public UIview list() throws Exception {
        //获取请求参数
        FormMap formMap=getFormMap();
        //开启分页
        PageHelper.startPage(formMap.getPage(), formMap.getRows());
        //查询展示数量
        List<E> list=addressService.selectList(formMap);
        //返回到list页面
        UIview result = UIView("/center/setting/shopAddressList",false);
        //绑定分页返回
        result.addObject("pageInfo", new PageInfo<E>(list));
        //绑定上一次参数
        result.addObject("queryParam", formMap);
        return result;
    }


    /**
     * 新增
     */
    @RequestMapping("/shopAddressAdd")
    public String add() throws Exception {
        try {
            FormMap formMap=getFormMap();
            this.getRequest().setAttribute("title", "地址库新增");
            formMap.put("parent_id", -1);
            List<E> provinceList= publicsService.selectRegionList(formMap);
            this.getRequest().setAttribute("provinces", provinceList);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "/center/setting/shopAddressEdit";
    }


    /**
     * 精彩推荐保存
     */
    @RequestMapping("/shopAddressSave")
    public String save() throws Exception {
        try {
            FormMap param=getFormMap();
            if(param.get("address_id")==null || param.get("address_id").equals("")){
                param.put("shipping_type", "0");
                param.put("return_type", "0");
                addressService.insert(param);
            }else{
                addressService.edit(param);
            }
        } catch (Exception e) {
            e.printStackTrace();
            throw new Exception("出错啦...");
        }
        return "redirect:shopAddress";
    }



    /**
     * 精彩推荐  》》 精彩推荐编辑
     */
    @RequestMapping("/shopAddressEdit")
    public UIview edit() throws Exception {
        UIview result=UIView("/center/setting/shopAddressEdit",false);
        try {
            FormMap formMap=getFormMap();
            E infoMap=addressService.selectOne(formMap);
            this.getRequest().setAttribute("title", "地址库编辑");
            formMap.set("parent_id", "-1");
            List<E> provinces=publicsService.selectRegionList(formMap);
            formMap.set("parent_id", infoMap.getInt("province"));
            List<E> citys=publicsService.selectRegionList(formMap);
            formMap.set("parent_id", infoMap.getInt("city"));
            List<E> districts=publicsService.selectRegionList(formMap);
            result.addObject("queryParam", formMap);
            result.addObject("infoMap", infoMap);
            result.addObject("provinces", provinces);
            result.addObject("citys", citys);
            result.addObject("districts", districts);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;
    }



    /**
     * 地址删除
     */
    @RequestMapping("/shopAddressRemove")
    public String remove() throws Exception {
        try {
            FormMap formMap=getFormMap();
            addressService.remove(formMap);
        } catch (Exception e) {
            e.printStackTrace();
            throw new Exception("出错啦...");
        }
        return "redirect:shopAddress";
    }



    /**
     * 默认发货地址，收货地址修改
     */
    @RequestMapping("/shopAddressStatus")
    public String status() throws Exception {
        try {
            FormMap formMap=getFormMap();
            addressService.editType(formMap);
        } catch (Exception e) {
            e.printStackTrace();
            throw new Exception("出错啦...");
        }
        return "redirect:shopAddress";
    }
}
