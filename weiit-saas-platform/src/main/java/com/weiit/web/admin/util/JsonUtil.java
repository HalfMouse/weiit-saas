package com.weiit.web.admin.util;

import com.alibaba.fastjson.JSON;
import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.core.JsonParser;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.DeserializationFeature;
import com.fasterxml.jackson.databind.JavaType;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.SerializationFeature;

import java.io.IOException;
import java.util.*;

/**
 * Created by 罗鸿强 on 2018/6/19.
 */
public class JsonUtil {
    public static final ObjectMapper mapper = newObjectMapper(), webMapper = mapper;

    /**
     *
     * @return
     */
    private static ObjectMapper newObjectMapper() {
        ObjectMapper result = new ObjectMapper();
        result.configure(JsonParser.Feature.ALLOW_UNQUOTED_FIELD_NAMES, true);
        result.configure(JsonParser.Feature.ALLOW_SINGLE_QUOTES, true);
        result.setSerializationInclusion(JsonInclude.Include.NON_NULL);
        //不输出value=null的属性
        result.configure(SerializationFeature.WRITE_NULL_MAP_VALUES, false);
        //不知道的属性，不异常
        result.configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false);
        return result;
    }

    /**
     * 转化为json串
     * @param value
     * @return value == null ? null :
     */
    public static String writerWithDefaultPrettyPrinter(Object value) {
        try {
            return value == null ? null : mapper.writerWithDefaultPrettyPrinter().writeValueAsString(value);
        } catch (IOException e) {
            throw new IllegalArgumentException(e);
        }
    }

    /**
     * 转化为json bytes
     * @param value
     * @return value == null ? null :
     */
    public static byte[] writeValueAsBytes(Object value) {
        try {
            return value == null ? null : mapper.writeValueAsBytes(value);
        } catch (IOException e) {
            throw new IllegalArgumentException(e);
        }
    }

    /**
     * 转化为json串
     * @param value
     * @return value == null ? null :
     */
    public static String writeValueAsString(Object value) {
        try {
            return value == null ? null : mapper.writeValueAsString(value);
        } catch (IOException e) {
            throw new IllegalArgumentException(e);
        }
    }

    /**
     * 对象转换为map，如果是字符串，先转成json对象再转为map
     * @param value
     * @return
     * @throws IllegalArgumentException
     */
    @SuppressWarnings("unchecked")
    public static Map<String, Object> toMap(Object value) throws IllegalArgumentException {
        return convertValue(value, Map.class);
    }

    /**
     * 读取为List或者Map
     * @param content
     * @return
     */
    @SuppressWarnings("unchecked")
    public static <T> T readValue(String content) {
        if (content == null || content.isEmpty()) return null;

        char ch = content.charAt(0);
        try {
            if (ch == '[') return (T) mapper.readValue(content, List.class);
            return (T) mapper.readValue(content, Map.class);
        } catch (IOException e) {
            throw new IllegalStateException(e);
        }
    }

    /**
     *
     * @param content
     * @param type
     * @return
     */
    public static <T> T readValue(String content, Class<T> type) {
        if (content == null || content.isEmpty()) return null;
        try {
            return mapper.readValue(content, type);
        } catch (IOException e) {
            throw new IllegalStateException(e);
        }
    }

    /**
     *
     * @param content
     * @param type
     * @return
     */
    public static <T> T readValue(byte[] content, Class<T> type) {
        if (content == null) return null;
        try {
            return mapper.readValue(content, type);
        } catch (IOException e) {
            throw new IllegalStateException(e);
        }
    }

    /**
     *
     * @param content
     * @param mapClass
     * @param keyClass
     * @param valueClass
     * @return
     */
    @SuppressWarnings("rawtypes")
    public static <T> T readMap(String content, Class<? extends Map> mapClass, Class<?> keyClass, Class<?> valueClass) {
        if (content == null) return null;
        try {
            return mapper.readValue(content, mapper.getTypeFactory().constructMapType(mapClass, keyClass, valueClass));
        } catch (IOException e) {
            throw new IllegalStateException(e);
        }
    }

    /**
     *
     * @param content
     * @param collectionClass
     * @param elementClass
     * @return
     */
    @SuppressWarnings("rawtypes")
    public static <T> T readCollection(String content, Class<? extends Collection> collectionClass, Class<?> elementClass) {
        if (content == null) return null;
        try {
            return mapper.readValue(content, mapper.getTypeFactory().constructCollectionType(collectionClass, elementClass));
        } catch (IOException e) {
            throw new IllegalStateException(e);
        }
    }

    /**
     *
     * @param content
     * @param elementClass
     * @return
     */
    public static <T> List<T> readListValue(String content, Class<T> elementClass) {
        if (content == null || content.isEmpty()) return null;
        try {
            return mapper.readValue(content, mapper.getTypeFactory().constructCollectionType(List.class, elementClass));
        } catch (IOException e) {
            throw new IllegalStateException(e);
        }
    }

    /**
     *
     * @param content
     * @param elementClass
     * @return
     */
    public static <T> T[] readArrayValue(String content, Class<T> elementClass) {
        if (content == null || content.isEmpty()) return null;
        try {
            return mapper.readValue(content, mapper.getTypeFactory().constructArrayType(elementClass));
        } catch (IOException e) {
            throw new IllegalStateException(e);
        }
    }

    /**
     * 转换为目标类，如果value是字符串，将被认为是json串<br>
     * 所以特别注意：'"abc"'是json字符串，目标类型是String时，转换结果为'abc'而不是'"abc"'
     * @param value
     * @param clazz
     * @return
     * @throws IllegalArgumentException
     */
    public static <T> T convertValue(Object value, Class<T> clazz) throws IllegalArgumentException {
        if (value == null) return null;
        try {
            if (value instanceof String) {
                if (!String.class.equals(clazz) && ((String) value).isEmpty()) return null;
                if (String.class.equals(clazz) && ((String) value).isEmpty()) return (T)value;
                value = mapper.readTree((String) value);
            }
            return mapper.convertValue(value, clazz);
        } catch (IOException e) {
            throw new IllegalArgumentException(e);
        }
    }

    /**
     *
     * @param json
     * @param typeRef
     * @return
     */
    public static <T> T getCollectionType(String json, TypeReference<T> typeRef) {
        if (json == null || json.isEmpty()) return null;
        try {
            return  mapper.readValue(json, typeRef);
        } catch (IOException e) {
            throw new IllegalArgumentException(e);
        }
    }

    /**
     * 范型readValue
     * json ==> Pager&lt;MyBean&gt;: readValue(json, Pager.class, MyBean.class)
     * json ==> List<Set<Integer>>: readValue(json, List.class, Integer.class)
     * @param json
     * @param parametrized
     * @param parametersFor
     * @param parameterClasses
     * @return
     */
    public static <T> T readValue(String json, Class<?> parametrized, Class<?> parametersFor, Class<?>... parameterClasses) {
        if (json == null) return null;

        JavaType type;
        if (parameterClasses == null || parameterClasses.length == 0) {
            type = mapper.getTypeFactory().constructParametrizedType(parametrized, parametrized, parametersFor);
        } else {
            type = mapper.getTypeFactory().constructParametrizedType(parametrized, parametersFor, parameterClasses);
        }

        try {
            return mapper.readValue(json, type);
        } catch (IOException e) {
            throw new IllegalStateException(e);
        }
    }


    public static <T> T convertJson(String json,Class clazz){
        return (T) JSON.parseObject(json,clazz);
    }

    /**
     * 转为Map<String,String> 类型
     * @param o
     * @return
     */
    public static Map convertObjectToMap(Object o){
        String json= writeValueAsString(o);
        Map map= convertJson(json,Map.class);
        Iterator<String> iterator= map.keySet().iterator();
        Map result=new HashMap();
        while(iterator.hasNext()){
            String key=iterator.next();
            if(map.get(key)!=null){
                result.put(key,map.get(key).toString());
            }
        }
        return result;
    }

    public static <T> T convertMapToObject(Map map,Class clazz){
        String json= writeValueAsString(map);
        return convertJson(json,clazz);
    }


    public static void main(String[] args) {
        String json="{\"code\":200,\"size\":2,\"friends\":[{\"createtime\":1440037706987,\"bidirection\":true,\"faccid\":\"t2\"}, {\"createtime\":1440037718190,\"bidirection\":true,\"faccid\":\"t3\",\"alias\":\"t3\"}]}";
        Map m= convertJson(json, HashMap.class);
        System.out.printf(m.toString());
    }
}
