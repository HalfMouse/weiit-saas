package com.weiit.web.admin.user.service.impl;

import com.weiit.core.entity.E;
import com.weiit.core.entity.FormMap;
import com.weiit.core.mapper.BaseMapper;
import com.weiit.core.service.impl.AbstractService;
import com.weiit.web.admin.user.mapper.UserCardMapper;
import com.weiit.web.admin.user.service.UserCardService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.List;

/**
 * 会员卡实现类
 * @author：半个鼠标
 * @date：2018年2月7日
 * @version 1.0
 * @company http://www.wei-it.com 微邦互联
 */
@Service("userCardService")
@Transactional(readOnly=false)
public class UserCardServiceImpl extends AbstractService implements UserCardService {

	@Resource
	private UserCardMapper userCardMapper;

	@Override
	public BaseMapper setMapper() {
		return userCardMapper;
	}
 
	/**
     * 查询店铺信息
     * @param param 
     * @return 返回店铺信息
     */
	@Override
	public E selectShopInfo(FormMap formMap) {
		return userCardMapper.selectShopInfo(formMap);
	}
	
	/**
     * 查询已拥有此卡的所有会员
     * @param param 
     * @return 返回拥有此卡的会员集合
     */
	@Override
	public List<E> selectHaveCardUserList(FormMap formMap) {
		return userCardMapper.selectHaveCardUserList(formMap);
	}

	/**
     * 查询此卡没拥有的会员
     * @param param 
     * @return 返回无此卡的会员集合
     */
	@Override
	public List<E> selectNoCardUserList(FormMap formMap) {
		return userCardMapper.selectNoCardUserList(formMap);
	}
	
	/**
     * 会员绑定卡片
     * @param param 
     * @return 
     */
	@Override
	@Transactional(propagation= Propagation.REQUIRED,readOnly=false,rollbackFor=Exception.class)
	public String insertUserCardTrans(FormMap formMap){
		int type=formMap.getInt("type");
		if(type==0){//单个送卡
			formMap.put("card_id", formMap.get("validate_id"));
			userCardMapper.insertUserCard(formMap);
			
		}else if(type==1){//批量送卡
			String userId[] = formMap.getStr("userIds").split(",");
			FormMap cardUserInfo=new FormMap();
			for(int i=0;i< userId.length;i++){
				cardUserInfo.put("card_id", formMap.get("validate_id"));
				cardUserInfo.put("user_id", userId[i]);
				cardUserInfo.put("shop_id", formMap.get("shop_id"));
				userCardMapper.insertUserCard(cardUserInfo);
			}
		}
		return null; 
	}
	
	/**
     * 会员卡片删除
     * @param param 
     * @return 
     */
	@Override
	public int removeUserCard(FormMap formMap){
		userCardMapper.removeUserCard(formMap);
		return 1; 
	}
	
	/**
     * 会员卡图片素材查询
     * @param param 
     * @return 
     */
	@Override
	public List<E> selectUserCardPictureSourceList(FormMap formMap) {
		return userCardMapper.selectUserCardPictureSourceList(formMap);
	}

	
}
