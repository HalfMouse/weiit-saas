package com.weiit.web.admin.weixin.service.impl;

import com.weiit.core.entity.E;
import com.weiit.core.entity.FormMap;
import com.weiit.core.mapper.BaseMapper;
import com.weiit.core.service.impl.AbstractService;
import com.weiit.web.admin.weixin.mapper.WeixinPublicReplyMapper;
import com.weiit.web.admin.weixin.service.WeixinPublicReplyService;

import org.springframework.stereotype.Service;

import javax.annotation.Resource;

import java.util.List;

/**
 * 微信公众号管理
 * @author bill.ouyang
 * qq:137075251 半个鼠标
 * email:google555@126.com
 * team:weiyunshidai.com
 */
@Service("weixinPublicReplyService")
public class WeixinPublicReplyServiceImpl extends AbstractService implements WeixinPublicReplyService{
	@Resource
	private WeixinPublicReplyMapper weixinPublicReplyMapper;
	
	@Override
	public BaseMapper setMapper() { 
		return weixinPublicReplyMapper;
	}
	 
	@Override
	public E selectById(FormMap map){
		E returnMap=new E();
		String action_type=map.getStr("action_type");
		//查询 自动回复配置 是否生效开启
		E replyTypeMap = weixinPublicReplyMapper.selectReplyType(map);
		returnMap.put("replyTypeMap", replyTypeMap);
		//查询 自动回复配置 
		// action_type=1表示被关注时回复，2表示收到消息回复，3表示关键词回复
		List<E> replyList = weixinPublicReplyMapper.selectList(map);
 
		if(action_type!=null && replyList!=null && !replyList.isEmpty()){
			if(action_type.equals("1") || action_type.equals("2")){
				E replyMap=replyList.get(0);
				returnMap.put("replyMap", replyMap);
				if(!replyMap.getStr("reply_content").equals("")){
					map.put("media_id", replyMap.get("reply_content"));
					if(replyMap.getInt("reply_type")==2){
						List<E> imageTextList = weixinPublicReplyMapper.selectImageText(map);
						if(imageTextList!=null && !imageTextList.isEmpty()){
							returnMap.put("imageTextMap", imageTextList.get(0));
						}
					}else if(replyMap.getInt("reply_type")==3){
						List<E> imageList = weixinPublicReplyMapper.selectImage(map);
						if(imageList!=null && !imageList.isEmpty()){
							returnMap.put("imageMap", imageList.get(0));
						}
					}
				}
			}else if(action_type.equals("3")){
				for (E replyMap : replyList){
					if(!replyMap.getStr("reply_content").equals("")){
						map.put("media_id", replyMap.get("reply_content"));
						if(replyMap.getInt("reply_type")==2){
							List<E> imageTextList = weixinPublicReplyMapper.selectImageText(map);
							if(imageTextList!=null && !imageTextList.isEmpty()){
								replyMap.put("imageTextMap", imageTextList.get(0));
							}
						}else if(replyMap.getInt("reply_type")==3){
							List<E> imageList = weixinPublicReplyMapper.selectImage(map);
							if(imageList!=null && !imageList.isEmpty()){
								replyMap.put("imageMap", imageList.get(0));
							}
						}
					}
				}
				returnMap.put("replyList", replyList);
			}
		}
		return returnMap;
	}
	
	@Override
	public E selectOne(FormMap map){ 
		E replyMap = weixinPublicReplyMapper.selectOne(map);
		if(!replyMap.getStr("reply_content").equals("")){
			map.put("media_id", replyMap.get("reply_content"));
			if(replyMap.getInt("reply_type")==2){
				List<E> imageTextList = weixinPublicReplyMapper.selectImageText(map);
				if(imageTextList!=null && !imageTextList.isEmpty()){
					replyMap.put("imageTextMap", imageTextList.get(0));
				}
			}else if(replyMap.getInt("reply_type")==3){
				List<E> imageList = weixinPublicReplyMapper.selectImage(map);
				if(imageList!=null && !imageList.isEmpty()){
					replyMap.put("imageMap", imageList.get(0));
				}
			} 
		}
		return replyMap;
	}

 
	@Override
	public E selectReplyType(FormMap map) { 
		return weixinPublicReplyMapper.selectReplyType(map);
	}
	
	@Override
	public List<E> selectImage(FormMap map) { 
		return weixinPublicReplyMapper.selectImage(map);
	}

	@Override
	public List<E> selectImageText(FormMap map) { 
		return weixinPublicReplyMapper.selectImageText(map);
	}


	@Override
	public void editReplyType(FormMap conditionMap) { 
		weixinPublicReplyMapper.editReplyType(conditionMap);
	}


	@Override
	public void insertReplyType(FormMap conditionMap) { 
		weixinPublicReplyMapper.insertReplyType(conditionMap);
	}

}
