package com.weiit.web.admin.dashboard.mapper;


import com.weiit.core.entity.E;
import com.weiit.core.entity.FormMap;
import com.weiit.core.mapper.BaseMapper;

import java.util.List;


/**
 * 订单管理mapper
 * @author zhouliang
 * @date 2017年8月15日 下午3:20:16
 * @version 1.0
 * @company http://www.wei-it.com
 */
public interface DashBoardMapper extends BaseMapper {
	
	List<E> selectBrowseList(FormMap formmap);
	List<E> selectBrowseCountList(FormMap param);
	E selectPageCount(FormMap param);
	E selectProductCount(FormMap param);
	
	E selectOrderSurveyCount(FormMap param);
	List<E> selectOrderSurveyList(FormMap param);

	E selectUserCount(FormMap param);
	List<E> selectUserCountList(FormMap param);
	
	
}
