package com.weiit.web.admin.publics.controller;


 
import java.util.List;
 





import javax.annotation.Resource; 

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller; 
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
 





import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo; 
import com.weiit.core.entity.E;
import com.weiit.core.entity.FormMap; 
import com.weiit.resource.common.utils.WeiitUtil;
import com.weiit.web.admin.publics.service.PublicsService;
import com.weiit.web.base.AdminController;
import com.weiit.web.base.UIview;
 
/**
 * 公共服务控制器
 * @author hezhiying
 * @date 2017年8月15日 下午3:20:16
 * @version 1.0
 * @company http://www.wei-it.com
 */
@Controller
@RequestMapping("/publics/publics")
public class PublicsController  extends AdminController {
	
	public static Logger logger=Logger.getLogger(PublicsController.class);
	
	@Resource
	private PublicsService publicsService;
  
	/**
	 * 查询省市区域集合
	 */
	@ResponseBody
	@RequestMapping("/selectRegionList")
	public String selectRegionList() throws Exception {
		logger.info("进入 PublicsController-selectRegionList,查询省市区域集合");
		
		try {
	    	List<E> list=publicsService.selectRegionList(getFormMap());
	    	return toJsonAPI(list);
		} catch (Exception e) {
			e.printStackTrace();
			return toJsonAPI("","操作异常："+e.getMessage(),"-1");
		}
	}
	
	
	/**
	 * 通过接口获取快递信息
	 * @return
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping("/expressList")
	public String expressList() throws Exception {
		logger.info("进入 PublicsController-expressList,通过接口获取快递信息   ");
		
		try {
			String code=this.getRequest().getParameter("expressCode");
			String expressNum=this.getRequest().getParameter("expressNum");
			//调用接口 获取快递单号运转信息
			String result = WeiitUtil.getLogistics(code, expressNum);
			if(result==null || result.equals("")){
				return toJsonAPI("","该单号暂无物流进展，请稍后再试，或检查公司和单号是否有误！","-1");
			}
			return toJsonAPI(result);
		} catch (Exception e) {
			return toJsonAPI("","查询异常，请稍后再试！","-1");
		}
	}
	
	/**
	 * 公共查询商品的服务
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/productList")
	public UIview productList() throws Exception {
		logger.info("进入 PublicsController-productList,公共查询商品的服务  ");
		
    	FormMap formMap=getFormMap();
    	//开启分页
    	PageHelper.startPage(formMap.getPage(), formMap.getRows());
    	List<E> list=publicsService.productList(formMap);
 
    	UIview result = UIView("/center/publics/productList",false);
        result.addObject("pageInfo", new PageInfo<E>(list));
        result.addObject("queryParam", formMap);
		return result;
	}

	/**
	 *  商品网格形式列表
	 */
	@RequestMapping("/productGridList")
	public ModelAndView productGridList() throws Exception { 
		logger.info("进入PictureFileController-source,资源加载");
		
		UIview result = UIView("/center/publics/productGridList",false);
    	FormMap formMap=getFormMap(true);
    	//开启分页
    	PageHelper.startPage(formMap.getPage(), 20);
    	List<E> list=publicsService.productList(formMap);
        result.addObject("pageInfo", new PageInfo<E>(list));
		return result;
	}


	/**
	 * 链接跳转
	 * */

	@RequestMapping(value = "/urlList",method = RequestMethod.GET)
	@ResponseBody
	public E urlList() {
		logger.info("PublicsController-urlList,链接跳转");
		FormMap formMap=new FormMap();
		List<E> list=publicsService.selectWeixinLink(formMap);
		E result = new E();
		result.put("urlList",list);
		//绑定上一次参数
		return result;
	}
}
