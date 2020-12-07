package com.weiit.web.common;

import java.util.Arrays;

/**
 * Created by 罗鸿强 on 2018/8/9.
 */
public class KeyComplex {
    private final Object datas[];
    public KeyComplex(Object datas[]){
        this.datas = datas;
    }

    public int hashCode(){
        return Arrays.hashCode(datas);
    }

    public boolean equals(Object obj){
        if(this == obj)
            return true;
        if(obj == null || !(obj instanceof KeyComplex)){
            return false;
        } else{
            KeyComplex other = (KeyComplex)obj;
            return Arrays.equals(datas, other.datas);
        }
    }
}
