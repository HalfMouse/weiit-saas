package com.weiit.web.admin.util;

import org.apache.commons.lang.time.DateUtils;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;

/**
 * Created by 罗鸿强 on 2018/5/17.
 */
public class DateUtil {

    //每天秒数
    public static final Integer SECOND =84600;

    /**
     *
     * @param type 计算类型 1 年 ，2 月 ，3 周，5 天 ,12 分钟 , 10 小时
     * @param date 日期
     * @param number 计算量
     * @return
     */
    public static Date addDate(int type, Date date, int number){
        GregorianCalendar gc=new GregorianCalendar();
        gc.setTime(date);
        gc.add(type,number);
        return gc.getTime();
    }

    /**
     * 获取当天剩余秒
     * */
    public static int getSurplusSecond(){
        int secondsLeftToday = SECOND - (int) DateUtils.getFragmentInSeconds(Calendar.getInstance(), Calendar.DATE);
        return secondsLeftToday;
    }


    /**
     *
     * @param date
     * @param next
     * @return
     */
    public static Date getBeginOfDay(Date date, boolean next){
        Calendar c = Calendar.getInstance();
        c.setTime(date);
        c.set(11, 0);
        c.set(12, 0);
        c.set(13, 0);
        c.set(14, 0);
        if(next){
            c.set(5, c.get(5) + 1);
        }
        return c.getTime();
    }


    //获取日期  时间戳   type 1 秒  2 毫秒
    public static Long getTimeByString(String time,String pattern) {
        Long resTime=0L;
        SimpleDateFormat sdf = new SimpleDateFormat(pattern);
        Date date;
        try {
            date = sdf.parse(time);
            resTime = date.getTime();

        } catch (ParseException e) {
            e.printStackTrace();
        }
        return resTime;
    }

    /**
     *
     * @param date
     * @return
     */
    public static Date getBeginOfDay(Date date){
        return getBeginOfDay(date, false);
    }


    public static Date getEndOfDay(Date date){
        Date d= getBeginOfDay(date,true);
        return new Date(d.getTime()-1000L);
    }
}
