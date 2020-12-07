package com.weiit.web.util;


import com.auth0.jwt.JWTSigner;
import com.auth0.jwt.JWTVerifier;
import com.auth0.jwt.internal.com.fasterxml.jackson.databind.ObjectMapper;
import org.apache.commons.codec.binary.Base64;

import java.util.HashMap;
import java.util.Map;

/**
 * JWT工具类
 * @author 半个鼠标
 * @Email：137075251@qq.com
 * @date：2017年2月4日 上午3:07:07
 * @version 1.0
 */
public class JWTUtil {  
  
    private static final String SECRET = "XX#$%()(#*!()!KL<><MQLMNQNQJQK sdfkjsdrow32234545fdf>?N<:{LWPW";  
      
    private static final String EXP = "exp";  
      
    private static final String PAYLOAD = "payload";  
  
    /** 
     * get jwt String of object 
     * @param object 
     *            the POJO object 
     * @param maxAge 
     *            the milliseconds of life time 
     * @return the jwt token 
     */  
    public static <T> String sign(T object, long maxAge) {  
        try {  
            final JWTSigner signer = new JWTSigner(SECRET);  
            final Map<String, Object> claims = new HashMap<String, Object>();  
            ObjectMapper mapper = new ObjectMapper();  
            String jsonString = mapper.writeValueAsString(object);  
            claims.put(PAYLOAD, jsonString);  
            claims.put(EXP, System.currentTimeMillis() + maxAge);  
            return signer.sign(claims);  
        } catch(Exception e) {  
            return null;  
        }  
    }  
      
      
    /** 
     * get the object of jwt if not expired 
     * @param jwt 
     * @return POJO object 
     */  
    public static<T> T unsign(String jwt, Class<T> classT) {  
        final JWTVerifier verifier = new JWTVerifier(SECRET);  
        try {  
            final Map<String,Object> claims= verifier.verify(jwt);  
            if (claims.containsKey(EXP) && claims.containsKey(PAYLOAD)) {  
                long exp = (Long)claims.get(EXP);  
                long currentTimeMillis = System.currentTimeMillis();  
                if (exp > currentTimeMillis) {  
                    String json = (String)claims.get(PAYLOAD);  
                    ObjectMapper objectMapper = new ObjectMapper();  
                    return objectMapper.readValue(json, classT);  
                }  
            }  
            return null;  
        } catch (Exception e) {  
            return null;  
        }  
    }  
    public static void main(String[] args) {
    	
//    	E e=new E();
//    	e.put("shop_id", 1);
//    	e.put("user_id", "2");
//    	e.put("user_name", "L");
//    	e.put("user_phone", "122");
//    	e.put("user_img", "http://thirdwx.qlogo.cn/mmopen/vi_32/UjGjJB9tCaqjCdrKWZLQ5jcOicicl9ZSrg1iaSwBxlaxBlcZeeNrFbBxGSOSC4dfEbnt4OkD6qD1GkWTJ6m9EqtVw/132");
//    	e.put("wx_open_id", "oBylrxJ8GLPaVTbzVnf8aqu_8pRg");
//    	e.put("open_id_type", "1");
//    	e.put("authorizer_app_id", "wxd4f394586be1148a");
//
//    	String token = JWTUtil.sign(e, 30L * 24L * 3600L * 1000L);
//    	System.out.println(token);
//
//
//    	E u = JWTUtil.unsign(token, E.class);
//    	System.out.println(u);

        String cc =new String(Base64.decodeBase64("eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJleHAiOjE1NDUxMjE1MjU3ODksInBheWxvYWQiOiJ7XCJ1c2VyX25hdGlvblwiOlwiXCIsXCJ1c2VyX2VtYWlsXCI6XCJcIixcIm9mdGVuX3BsYWNlXCI6XCJcIixcImVkdWNhdGlvblwiOm51bGwsXCJ1c2VyX2NvdW50cnlcIjpcIuS4reWbvVwiLFwidXNlcl9uYW1lXCI6XCLnjovlsI8yXCIsXCJiaXJ0aF9kYXRlXCI6MTU0NTAxOTc0OTAwMCxcImF1dGhfc3RhdGVcIjoyLFwidXNlcl9wb3NpdGlvblwiOlwiXCIsXCJvdXRzaWRlX2NvdW50cnlcIjpcIlwiLFwiYXV0aF9hZGRyZXNzXCI6XCJcIixcImlkX2NhcmRfemltZ1wiOlwiXCIsXCJhdXRoX2ltZ1wiOlwiXCIsXCJ1c2VyX3NleFwiOm51bGwsXCJpc19vdXRzaWRlXCI6LTEsXCJpZF9jYXJkX251bVwiOlwiMzYwNzM0MTk5MjExMjIzNTE4XCIsXCJ0YXhfbnVtXCI6XCJcIixcInVzZXJfaWRcIjo4NixcImJhc2VfcGxhY2VcIjpcIlwiLFwidXNlcl9waG9uZVwiOlwiMTU4MTIzNjUyMDBcIixcImlkX2NhcmRfZmltZ1wiOlwiXCIsXCJvZnRlbl9hZGRyZXNzXCI6XCJcIn0ifQ"));
        System.out.println(cc);
    }
}  
