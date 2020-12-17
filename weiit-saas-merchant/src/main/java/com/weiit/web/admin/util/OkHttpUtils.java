package com.weiit.web.admin.util;

import com.google.common.base.Joiner;
import okhttp3.*;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;

/**
 * okHttp3.0    http请求工具类
 */
public class OkHttpUtils {
    public static OkHttpClient okHttpClient;

    static {
        okHttpClient = new OkHttpClient();
    }


    /**
     * @param url   请求地址
     * @param headers 头部信息
     * @param querys  参数信息
     * @param isPost  是否post 请求
     * @param isURLEncoder
     *
     * */
    public static Map post(String url,Map<String, String> headers, Map<String, String> querys,boolean isPost,boolean isURLEncoder){
        Request.Builder build = getBuilder(headers);
        if (isPost){
            build.url(url);
            build.post(getFormBody(querys));
        }else {
            url+=url.contains("?")?mapToFormData(querys,isURLEncoder):"?"+mapToFormData(querys,isURLEncoder);
            build.url(url);
            build.get();
        }

        build.url(url);
        build.post(getFormBody(querys));
        Request request = build.build();
        try {

            Response response = okHttpClient.newCall(request).execute();
            Map responseMap = getMapResponse(response);
            System.out.println(responseMap.toString());
            return responseMap;
        } catch (IOException e) {
            System.out.printf("sendMsgError:");
            e.printStackTrace();
            return null;
        }
    }

    private static Request.Builder getBuilder(Map<String, String> headers) {
        Request.Builder build = new Request.Builder();
        if (headers==null){
            return build;
        }

        Iterator iterator = headers.entrySet().iterator();
        //常用头部信息

        while(iterator.hasNext()) {
            Map.Entry header = (Map.Entry)iterator.next();
            build.addHeader((String)header.getKey(), (String)header.getValue());
        }


        return build;
    }

    private static Map getMapResponse(Response response) throws IOException {
        String responseStr = response.body().string();
        Map responseMap = JsonUtil.convertJson(responseStr, HashMap.class);
        return responseMap;
    }

    private static RequestBody getFormBody (Map<String, String> querys) {
        FormBody.Builder formBody= new FormBody.Builder();
        if (querys==null){
            return formBody.build();
        }
        Iterator iterator = querys.entrySet().iterator();

        while(iterator.hasNext()) {
            Map.Entry query = (Map.Entry)iterator.next();
            formBody.add((String)query.getKey(), (String)query.getValue());
        }
        return formBody.build();
    }

    public static String mapToFormData(Map<String, String> map, boolean isURLEncoder)  {
        String formData = "";
        if (map != null && map.size() > 0) {
            formData = Joiner.on("&").withKeyValueSeparator("=").join(map);
            if (isURLEncoder) {
                try {
                    formData = URLEncoder.encode(formData, "UTF-8");
                } catch (UnsupportedEncodingException e) {
                    e.printStackTrace();
                }
            }
        }
        return formData;
    }



    public static void main(String[] args) throws Exception {
        for (int i =0;i<10;i++){
            Long startTme = System.currentTimeMillis();

//            String host = "https://www.apiopen.top";
//            String path = "/novelSearchApi";
//            String method = "GET";
            HashMap querys = new HashMap();
            querys.put("name", "盗墓笔记");
            querys.put("name1", "盗墓笔记");
            querys.put("name2", "盗墓笔记");
            querys.put("name3", "盗墓笔记");
//            HashMap headers = new HashMap();
//            String result = null;
//            HttpResponse response = com.weiit.resource.common.utils.HttpUtils.doGet(host, path, method, headers, querys);
//            result = EntityUtils.toString(response.getEntity());

//            System.out.println(result);

            post("https://www.apiopen.top/novelSearchApi",null,querys,true,false);

            Long endTime = System.currentTimeMillis();

        System.out.println("耗时为======================"+(endTime-startTme));

        }

//        HashMap querys = new HashMap();
//        querys.put("name", "盗墓笔记");
//        querys.put("sex",1);
//
//        System.out.println(  mapToFormData(querys,false));


    }
}
