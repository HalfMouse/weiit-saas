package com.weiit.web.admin.util;

import com.weiit.web.common.KeyComplex;
import org.apache.commons.lang3.time.DateUtils;

import java.sql.Timestamp;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 * Created by 罗鸿强 on 2018/5/17.
 */
public class DateUtil {

    private static final Map formatCache = new HashMap();
    public static final TimeZone tzShangHai = TimeZone.getTimeZone("Asia/Shanghai");
    public static final TimeZone tzAmericaNewYork = TimeZone.getTimeZone("America/New_York");
    public static final String defaultPattern = "yyyy-MM-dd HH:mm:ss.SSS";


    /**
     * 获取当前时间的格式化后的字符串
     * @return
     */
    public static String getNow(){
        SimpleDateFormat sdf=new SimpleDateFormat(defaultPattern);
        return sdf.format(new Date());
    }

    /**
     *
     * @param locale
     * @param timeZone
     * @param pattern
     * @return
     */
    public static DateFormat getDateFormat(Locale locale, TimeZone timeZone, String pattern){
        if(timeZone == null)
            timeZone = TimeZone.getDefault();
        if(locale == null)
            locale = Locale.getDefault(Locale.Category.FORMAT);
        KeyComplex key = new KeyComplex(new Object[] {
                timeZone, locale, pattern
        });

        ThreadLocal formatThreadLocal = (ThreadLocal)formatCache.get(key);
        if(formatThreadLocal == null){
            formatThreadLocal = new ThreadLocal();
            formatCache.put(key, formatThreadLocal);
        }

        DateFormat result = (DateFormat)formatThreadLocal.get();
        if(result != null){
            return result;
        } else{
            result = new SimpleDateFormat(pattern, locale);
            result.setTimeZone(timeZone);
            formatThreadLocal.set(result);
            return result;
        }
    }

    /**
     *
     * @param date
     * @param locale
     * @param timeZone
     * @param pattern
     * @return
     */
    public static Date parse(String date, Locale locale, TimeZone timeZone, String pattern){
        if(date == null || date.isEmpty())
            return null;
        if(pattern.length() > date.length())
            pattern = pattern.substring(0, date.length());
        try{
            return getDateFormat(locale, timeZone, pattern).parse(date);
        }catch(ParseException e){
            throw new IllegalArgumentException((new StringBuilder()).append("pattern=").append(pattern).append(", date=").append(date).toString());
        }
    }

    /**
     *
     * @param date
     * @param locale
     * @param timeZone
     * @param pattern
     * @return
     */
    public static String format(Date date, Locale locale, TimeZone timeZone, String pattern){
        if(date == null)
            return null;
        else
            return getDateFormat(locale, timeZone, pattern).format(date);
    }

    /**
     *
     * @param date
     * @param pattern
     * @return
     */
    public static Date parse(String date, String pattern){
        return parse(date, null, null, pattern);
    }

    /**
     *
     * @param date
     * @return
     */
    public static Date parse(String date){
        return parse(date, null, null, "yyyy-MM-dd HH:mm:ss.SSS");
    }

    /**
     *
     * @param date
     * @param pattern
     * @return
     */
    public static String format(Date date, String pattern){
        return format(date, null, null, pattern);
    }

    /**
     *
     * @param date
     * @return
     */
    public static String format(Date date){
        return format(date, null, null, "yyyy-MM-dd HH:mm:ss.SSS");
    }

    /**
     *
     * @param time
     * @return
     */
    public static String format(long time){
        return format(new Date(time), null, null, "yyyy-MM-dd HH:mm:ss.SSS");
    }

    /**
     *
     * @param start
     * @param end
     * @return
     */
    public static String prettyTime(Number start, Number end){
        if(start == null && end == null)
            return null;
        if(start == null)
            return (new StringBuilder()).append("null --> ").append(format(new Date(end.longValue()), "yyyy-MM-dd HH:mm:ss.SSS")).toString();
        if(end == null){
            return (new StringBuilder()).append(format(new Date(start.longValue()), "yyyy-MM-dd HH:mm:ss.SSS")).append(" --> null").toString();
        } else{
            long time = end.longValue() - start.longValue();
            return time >= 0L ? prettyTime(((Number) (Long.valueOf(time)))) : (new StringBuilder()).append("-").append(prettyTime(((Number) (Long.valueOf(-time))))).toString();
        }
    }

    /**
     *
     * @param detTime
     * @return
     */
    public static String prettyTime(Number detTime){
        if(detTime == null)
            return null;
        long time = detTime.longValue();
        StringBuilder buf = new StringBuilder(128);
        int tmp = (int)(time / 86400000L);
        if(tmp > 0)
            buf.append(tmp).append('\u5929');
        time %= 86400000L;
        if(time == 0L)
            return buf.length() != 0 ? buf.toString() : "0\u79D2";
        tmp = (int)(time / 3600000L);
        if(tmp > 0)
            buf.append(tmp).append('\u65F6');
        time %= 3600000L;
        if(time == 0L)
            return buf.length() != 0 ? buf.toString() : "0\u79D2";
        tmp = (int)(time / 60000L);
        if(tmp > 0)
            buf.append(tmp).append('\u5206');
        time %= 60000L;
        if(time == 0L){
            return buf.length() != 0 ? buf.toString() : "0\u79D2";
        } else{
            buf.append((float)time / 1000F).append('\u79D2');
            return buf.toString();
        }
    }

    /**
     *
     * @return
     */
    public static DateFormat getHttpDateFormat(){
        SimpleDateFormat format = new SimpleDateFormat("EEE, dd MMM yyyy HH:mm:ss zzz", Locale.UK);
        format.setTimeZone(TimeZone.getTimeZone("GMT"));
        return format;
    }

    /**
     *
     * @param date
     * @return
     */
    public static Date parseHttpDate(String date){
        try{
            return getHttpDateFormat().parse(date);
        }catch(ParseException e){
            throw new IllegalArgumentException((new StringBuilder()).append(date).append(", ").append(e).toString(), e);
        }
    }


    public static String getDateStr(Date d,String fmt){
        SimpleDateFormat sdf = new SimpleDateFormat(fmt);
        return sdf.format(d);
    }
    /**
     *
     * @param date
     * @return
     */
    public static String formatHttpDate(Date date){
        return getHttpDateFormat().format(date);
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
        return new Date(d.getTime()-1000l);
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
        if(next)
            c.set(5, c.get(5) + 1);
        return c.getTime();
    }

    /**
     *
     * @param date
     * @return
     */
    public static int[] getAll(Date date){
        Calendar c = Calendar.getInstance();
        c.setTime(date);
        return (new int[] {
                c.get(1), c.get(2), c.get(5), c.get(11), c.get(12), c.get(13), c.get(14)
        });
    }


    public static int getSurplusSecond(){
        return 86400 - (int) DateUtils.getFragmentInSeconds(Calendar.getInstance(), Calendar.DATE);
    }

    /**
     *
     * @param type 计算类型 1 年 ，2 月 ，3 周，5 天 ,12 分钟 , 10 小时
     * @param date 日期
     * @param number 计算量
     * @return
     */
    public static Date addDate(int type,Date date,int number){
        GregorianCalendar gc=new GregorianCalendar();
        gc.setTime(date);
        gc.add(type,number);
        return gc.getTime();
    }

    public static Timestamp nowTimestamp(){
        return getTimestamp(System.currentTimeMillis());
    }

    public static Timestamp getTimestamp(long time){
        return new Timestamp(time);
    }

    public static Timestamp getIntervalTimestamp(long interval){
        interval *= 1000;
        return new Timestamp(System.currentTimeMillis() + interval);
    }
    //    判断输入时间是否为今天
    public static boolean isToday(Date data){
        long timeMillis = System.currentTimeMillis();
        SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");
        String spDate = sf.format(data);
//        LocalDate today = LocalDate.now();
        String today = sf.format(timeMillis);
        if(spDate.equals(today)){
            return true;
        }else {
            return false;
        }
    }




    //    将当前时间格式化为yyyy-MM-dd
    public static Date getDateFormNow(Date now){
//        DateFormat df = DateFormat.getDateInstance();
//        String formatDate = df.format(now);
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        try {
            return sdf.parse(sdf.format(now));
        }catch (ParseException e){
            e.printStackTrace();
        }
        return null;
    }
    //    获取两个时间相差月份
    public static int getMonth(Date start, Date end) {
        if (start.after(end)) {
            Date t = start;
            start = end;
            end = t;
        }
        Calendar startCalendar = Calendar.getInstance();
        startCalendar.setTime(start);
        Calendar endCalendar = Calendar.getInstance();
        endCalendar.setTime(end);
        Calendar temp = Calendar.getInstance();
        temp.setTime(end);
        temp.add(Calendar.DATE, 1);

        int year = endCalendar.get(Calendar.YEAR)
                - startCalendar.get(Calendar.YEAR);
        int month = endCalendar.get(Calendar.MONTH)
                - startCalendar.get(Calendar.MONTH);

        if ((startCalendar.get(Calendar.DATE) == 1)
                && (temp.get(Calendar.DATE) == 1)) {
            return year * 12 + month + 1;
        } else if ((startCalendar.get(Calendar.DATE) != 1)
                && (temp.get(Calendar.DATE) == 1)) {
            return year * 12 + month;
        } else if ((startCalendar.get(Calendar.DATE) == 1)
                && (temp.get(Calendar.DATE) != 1)) {
            return year * 12 + month;
        } else {
            return (year * 12 + month - 1) < 0 ? 0 : (year * 12 + month);
        }
    }


    //得到两个日期相差的天数
    public static int getDateSpace(String start, String end)  {

        Date startDate = parse(start,"yyyy-MM-dd");
        Date endDate = parse(end,"yyyy-MM-dd");
        if (startDate.after(endDate)) {
            Date t = startDate;
            startDate = endDate;
            endDate = t;
        }

        Calendar startCalendar = Calendar.getInstance();;
        Calendar endCalendar = Calendar.getInstance();

        startCalendar.setTime(startDate);
        endCalendar.setTime(endDate);
        //设置时间为0时
        startCalendar.set(Calendar.HOUR_OF_DAY, 0);
        startCalendar.set(Calendar.MINUTE, 0);
        startCalendar.set(Calendar.SECOND, 0);
        endCalendar.set(Calendar.HOUR_OF_DAY, 0);
        endCalendar.set(Calendar.MINUTE, 0);
        endCalendar.set(Calendar.SECOND, 0);

        int days = ((int)(endCalendar.getTime().getTime()/1000)-(int)(startCalendar.getTime().getTime()/1000))/3600/24;

        return days;
    }

    public static int getTimeByString(String str){
        SimpleDateFormat simpleDateFormat =new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        Date date= null;
        try {
            date = simpleDateFormat .parse(str);
        } catch (ParseException e) {
            e.printStackTrace();
        }
        return  (int) date.getTime();
    }


    //获取日期  时间戳   type 1 秒  2 毫秒
    public static Long getTimeByString(String time,String pattern) {
        Long resTime=0l;
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
     * 判断时间是否在时间段内
     * @param nowTime
     * @param beginTime
     * @param endTime
     * @return
     */
    public static boolean belongCalendar(Date nowTime, Date beginTime, Date endTime) {
        Calendar date = Calendar.getInstance();
        date.setTime(nowTime);

        Calendar begin = Calendar.getInstance();
        begin.setTime(beginTime);

        Calendar end = Calendar.getInstance();
        end.setTime(endTime);

        if (date.after(begin) && date.before(end)) {
            return true;
        } else {
            return false;
        }
    }

    public static int compare(Date beginTime, Date endTime) {
        return beginTime.compareTo(endTime);
    }



    public static void main(String[] args) {
        System.out.println(getBeginOfDay(new Date()));
        System.out.println(getEndOfDay(new Date()));
    }
}
