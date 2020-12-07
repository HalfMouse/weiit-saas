package com.weiit.web.api.service;

import com.weiit.core.entity.E;
import com.weiit.core.entity.FormMap;
import com.weiit.core.service.BaseService;

import java.util.List;

/**
 * Created by Administrator on 2018-05-08.
 */
public interface BargainService extends BaseService{

    /**
     * 查询店铺砍价活动的商品
     * @param formMap
     * @return 店铺砍价活动的商品
     * */
    List<E> selectBargainList(FormMap formMap);

    /**
     * 活动页面  根据IDS 查询店铺砍价活动的商品   todo 需要改进（每个活动模块一个商品之展现一次就好）
     * @param formMap
     * @return 店铺砍价活动的商品
     * */
    List<E> getProductByBargainIds(FormMap formMap);

    /**
     * 插入砍价记录
     * @param formMap
     * @return
     * */
    int insertBargainLog(FormMap formMap);

    /**
     * 插入砍价订单
     * @param formMap
     * @return
     * */
    int insertBargainOrder(FormMap formMap);
    /**
     * 查询用户砍价记录
     * @param formMap
     * @return 砍价记录
     * */
    E selectUserBargainLog(FormMap formMap);

    /**
     * 根据log_id 查询 商品信息  图片商品名 原价 砍主的昵称 头像
     * @param formMap
     * @return  商品信息  图片商品名  砍主的昵称 头像
     * */
    E selectBargainInfo(FormMap formMap);


    /**
     * 根据b_order_id 查询 帮砍信息列表
     * @param formMap
     * @return
     * */
    List<E> SelectBargainLogList(FormMap formMap);



    /**
     * 根据b_order_id 查询 已砍多少金额
     * @param formMap
     * @return
     * */
    E getBargainSumPrice(FormMap formMap);


    /**
     * 查询用户的砍价列表
     *@param formMap
     * @return
     * */
    List<E> SelectUserBargain(FormMap formMap);

    /**
     * 查询店铺的砍价支付消息
     *
     * */
    List<E> bargainMessage(FormMap formMap);

    /**
     * 根据bargainId  查询用户在该砍价活动中是否有待完成的砍价
     * @param formMap
     * @return
     * */
    E hasBargainCount(FormMap formMap);

    /**
     * 根据LogIdAndUserId 查询用户在该某个发起砍价活动中是否参与
     * @param formMap
     * @return
     * */
    int hasBargainByLogId(FormMap formMap);



    /**
     * 根据b_order_id  查询weiit_ump_bargain_order_log 表 中最后一条砍价信息
     * @param formMap
     * @return
     * */
    E selectLastBargain(FormMap formMap);


    /**
     * 根据bargain_id  获取砍价活动信息  （只查询了个别字段）
     * @param formMap
     * @return
     * */
    E selectBargainLogOne(FormMap formMap);


    /**
     * 根据b_order_id  获取砍价订单信息
     * @param formMap
     * @return
     * */
    E getBargainOrderById(FormMap formMap);


    /**
     * 根据b_order_id  更新砍价订单信息
     * @param formMap
     * @return
     * */
    void updateBargainOrderById(FormMap formMap);


    /**
     * todo  有统一获取方式   改接口需去掉
     * 获取商户支付信息
     * @param orderNo
     * @return
     * */
    E getMchKeyBybargainOrderNo(String orderNo);

    /**
     *
     * 获取发起者的openId
     * @param b_order_id
     * @return
     * */
    E selectOpenIdbyBOrderId(String b_order_id);




}
