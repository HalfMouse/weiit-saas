let getQueryString = function(name) {
    // var reg = new RegExp('(^|&)' + name + '=([^&]*)(&|$)', 'i');
    let r = window.location.search.substr(1).split('&');
    let urlObject = {}
    if(r.length > 0){
        for (var i=0, len=r.length; i<len; i++) { 
            var urlItem = r[i]; 
            var item = urlItem.split("="); 
            urlObject[item[0]] = item[1]; 
        } 
        
        return urlObject[name]
    }
    return null;
}
export {getQueryString}