package com.weiit.web.admin.setting.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.weiit.core.entity.E;
import com.weiit.core.entity.FormMap;
import com.weiit.core.view.UIview;
import com.weiit.web.admin.publics.service.PublicsService;
import com.weiit.web.admin.setting.service.ShippingService;
import com.weiit.web.base.AdminController;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.annotation.Resource;
import java.util.List;

/**
 * 
 * Title: ProductBannerController.java
 * Description: 物流管理 》》运费模板
 * Shipments: 微云时代 http://weiyunshidai.com/
 * @author hzy 
 * @date 2017年3月30日
 */
@Controller
@RequestMapping("/setting")
public class ShippingController  extends AdminController {
	@Resource
	private ShippingService shippingService;
	@Resource
	private PublicsService publicsService;
 
    /**
     * 物流公司列表查询
     */
	@RequestMapping("/shippingList")
	public UIview list() throws Exception { 
		//获取请求参数
    	FormMap formMap=getFormMap();
    	//开启分页
    	PageHelper.startPage(formMap.getPage(), formMap.getRows());
    	//查询展示数量
    	List<E> list=shippingService.selectList(formMap);

    	List shipmentDetailList=shippingService.selectShipmentsDetail(formMap);
 
    	//返回到list页面
    	UIview result = UIView("/center/setting/shippingList",false);
        //绑定分页返回
        result.addObject("pageInfo", new PageInfo<E>(list));
        //绑定上一次参数
        result.addObject("queryParam", formMap);
        result.addObject("shipmentDetailList", shipmentDetailList);
		return result;
	}
	
    /**
     * 新增运费模板
     */
	@RequestMapping("/shippingAdd")
	public String add() throws Exception {
		try { 
			FormMap formMap=getFormMap(); 
			this.getRequest().setAttribute("title", "运费模板新增");  
			formMap.put("parent_id", -1);
			List provinceList=publicsService.selectRegionList(formMap);
			this.getRequest().setAttribute("provinceList", provinceList);
			
			formMap.put("parentList", provinceList);
			List cityList=publicsService.selectRegionList(formMap);
			this.getRequest().setAttribute("cityList", cityList);
		} catch (Exception e) {
			e.printStackTrace(); 
		}
		return "/center/setting/shippingEdit";
	}
	
    /**
     * 运费模板编辑
     */
	@RequestMapping("/shippingEdit")
	public String edit() throws Exception {
		try {
			FormMap formMap=getFormMap(); 
			E infoMap=shippingService.selectOne(formMap); 
			this.getRequest().setAttribute("infoMap", infoMap);
			List shipmentDetailList=shippingService.selectShipmentsDetail(formMap);
			this.getRequest().setAttribute("shipmentDetailList", shipmentDetailList);
			
			this.getRequest().setAttribute("title", "运费模板编辑");  
			 
			formMap.put("parent_id", -1);
			List provinceList=publicsService.selectRegionList(formMap);
			this.getRequest().setAttribute("provinceList", provinceList);
			formMap.put("parentList", provinceList);
			List cityList=publicsService.selectRegionList(formMap);
			this.getRequest().setAttribute("cityList", cityList);
		} catch (Exception e) {
			e.printStackTrace(); 
		}
		return "/center/setting/shippingEdit";
	}
	
    /**
     * 运费模板保存
     */
	@RequestMapping("/shippingSave")
	public String save() throws Exception {
		try { 
	        FormMap param=getFormMap(); 
			 
			if(param.get("shipping_id")==null || param.get("shipping_id").equals("")){  
				shippingService.insert(param);
			}else{ 
				shippingService.edit(param);
			}
		} catch (Exception e) {
			e.printStackTrace();
			throw new Exception("出错啦...");
		}
		return "redirect:shippingList";
	}
	
    /**
     * 运费模板状态更新
     */
	@RequestMapping("/shippingStatus")
	public String status() throws Exception {
		try {
			FormMap formMap=getFormMap();
			formMap.set("eivt", "status");
			shippingService.edit(formMap);
		} catch (Exception e) {
			e.printStackTrace();
			throw new Exception("出错啦...");
		}
		return "redirect:shippingList";
	}
	 
    /**
     * 运费模板删除
     */
	@RequestMapping("/shippingRemove")
	public String remove() throws Exception {
		try {
			FormMap formMap=getFormMap();
			shippingService.remove(formMap);
		} catch (Exception e) {
			e.printStackTrace();
			throw new Exception("出错啦...");
		}
		return "redirect:shippingList";
	}


	/**
	 * 运费模板复制
	 */
	@RequestMapping("/shippingCopySave")
	public String shippingCopySave() throws Exception {
		try {
			FormMap formMap=getFormMap();
			shippingService.insertShipmentsCopy(formMap);
		} catch (Exception e) {
			e.printStackTrace();
			throw new Exception("出错啦...");
		}
		return "redirect:shippingList";
	}
}
