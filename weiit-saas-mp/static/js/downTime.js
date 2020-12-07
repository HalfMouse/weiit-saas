let downTime = function(times){
    let h = parseInt(times / 1000 / 60 / 60 , 10) < 10 ? '0'+parseInt(times / 1000 / 60 / 60 , 10) + ':' : parseInt(times / 1000 / 60 / 60 , 10) + ':';
    let m = parseInt(times / 1000 / 60 % 60 , 10) < 10 ? '0'+parseInt(times / 1000 / 60 % 60 , 10) + ':' : parseInt(times / 1000 / 60 % 60 , 10) + ':';
    let s = parseInt(times / 1000 % 60 , 10) < 10 ? '0'+parseInt(times / 1000 % 60 , 10) : parseInt(times / 1000 % 60 , 10);
    
    return h+m+s; 
}
export {downTime}