package com.weiit.web.common;

/**
 * Created by 罗鸿强 on 2018/7/23.
 *
 * 小程序模板消息用
 */
public class FormTemplateVO extends Object  {
    private String formId;

    private Long expire;

    public String getFormId() {
        return formId;
    }

    public void setFormId(String formId) {
        this.formId = formId;
    }

    public Long getExpire() {
        return expire;
    }

    public void setExpire(Long expire) {
        this.expire = expire;
    }



    @Override
    public String toString() {
        return "FormTemplateVO{" +
                "formId='" + formId + '\'' +
                ", expire=" + expire +
                '}';
    }
}
