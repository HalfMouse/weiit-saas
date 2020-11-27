package com.weiit.web.admin.miniprogram.service;

import com.weiit.core.entity.E;
import com.weiit.core.entity.FormMap;
import com.weiit.core.service.BaseService;

import java.util.List;

/**
 * Created by 罗鸿强 on 2018/7/19.
 */
public interface WxMiniProgramService extends BaseService {

    /**
     * 设置小程序服务器域名
     */
    void modifyDomain(FormMap formMap);

    /**
     * 设置小程序业务域名
     */
    void setWebViewDomain(FormMap formMap);


    /**
     * 上传小程序代码
     */
    E uploadMiniCode(FormMap formMap,boolean isSubmit,boolean isFirst);



    /**
     * 代码上传后  可获取小程序体验二维码
     * */
    String getQrcode(FormMap formMap);

    /**
     *
     * 提交审核
     * */
    String submit_audit(FormMap formMap);

    /***
     *
     * 查询某个指定版本的审核状态
     */
    String getAuthStatus(FormMap formMap);

    /**
     * 发布已通过审核的小程序
     * @param formMap
     *
     * */
    String release(FormMap formMap);


    /**
     * 查询小程序体验用户
     * */
    List<E> selectTestUserList(FormMap formMap);

    /**
     * 绑定为小程序体验用户
     * */
    public String bindTester(FormMap formMap);

    /**
     * 绑定为小程序体验用户
     * */
    public String unbindTester(FormMap formMap);


    /**
     * 查询商户的小程序的当前版本信息
     * */
    public E selectMiniCurrentAuthInfo(FormMap formMap);

    /**
     * 查询商户的小程序的当前版本信息
     * */
    public E selectMiniVersionInfo(FormMap formMap);
}
