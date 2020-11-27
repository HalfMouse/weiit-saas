package com.weiit.web.admin.weixin.mapper;

import com.weiit.core.entity.E;
import com.weiit.core.entity.FormMap;
import com.weiit.core.mapper.BaseMapper;

import java.util.List;

/**
 * 微信公众号自动回复管理
 * @author bill.ouyang
 * qq:137075251 半个鼠标
 * email:google555@126.com
 * team:weiyunshidai.com
 */
public interface WeixinPublicReplyMapper extends BaseMapper {
	
	/**
	 * 查询 自动回复 是否生效配置 
	 * @param map
	 * @return
	 */
	E selectReplyType(FormMap map);
	/**
	 * 查询 自动回复图片配置
	 * @param map
	 * @return
	 */
	List<E> selectImage(FormMap map); 
	/**
	 * 查询 自动回复图文配置
	 * @param map
	 * @return
	 */
	List<E> selectImageText(FormMap map); 
	
	/**
	 * 修改 生效配置
	 * @param map
	 */
	void editReplyType(FormMap map);

	/**
	 * 新增 生效配置
	 * @param map
	 */
	void insertReplyType(FormMap map);
	
}
