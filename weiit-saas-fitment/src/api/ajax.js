import axios from 'axios';
import qs from 'qs';
import {getQueryString} from '../../static/js/getQueryString';

// let url = 'http://merchant.woyoulian.com'; 
let url = 'http://merchant.wstore.me';


// 创建实例默认设置
var instance = axios.create({
    baseURL: url,
    timeout: 1000,
    headers: {
        'Content-Type': 'application/x-www-form-urlencoded'
    }
});
let token = getQueryString('token');
localStorage.setItem('token', token);
instance.interceptors.request.use(function (config) {
    if (config.method === 'post') {
        config.data = qs.stringify(config.data);
        config.params = qs.stringify({
            token:localStorage.getItem('token'),
			//   token:'13FF7ABE13B23843',
            ...config.params
        })
    }else if(config.method === 'get'){
        config.params = {
            token:localStorage.getItem('token'),
			//   token:'13FF7ABE13B23843',
            ...config.params
        }
    }
    return config;
}, (error) => {
    return Promise.reject(error);
})

instance.interceptors.response.use((res) => {
    return res;
}, (error) => {
    //404等问题可以在这里处理
    auth(error.response.data.code, error.response.data.message);
    return Promise.reject(error);
});
export default instance