let getTime = function (times) {
  var date = new Date(times);
  let Y = date.getFullYear() + '-';
  let M = (date.getMonth() + 1 < 10 ? '0' + (date.getMonth() + 1) : date.getMonth() + 1) + '-';
  let D = (date.getDate() < 10 ? '0' + date.getDate() : date.getDate()) + ' ';
  let h = (date.getHours() < 10 ? '0' + date.getHours() : date.getHours()) + ':';
  let m = (date.getMinutes() < 10 ? '0' + date.getMinutes() : date.getMinutes()) + ':';
  let s = (date.getSeconds() < 10 ? '0' + date.getSeconds() : date.getSeconds());
  return Y + M + D + h + m + s;
}
export { getTime }


// 秒数转换时分秒
let convert = function (value) {
  var secondTime = parseInt(value);// 秒
  var minuteTime = 0;// 分
  var hourTime = 0;// 小时
  if (secondTime > 60) {//如果秒数大于60，将秒数转换成整数
    //获取分钟，除以60取整数，得到整数分钟
    minuteTime = parseInt(secondTime / 60);
    //获取秒数，秒数取佘，得到整数秒数
    secondTime = parseInt(secondTime % 60);
    //如果分钟大于60，将分钟转换成小时
    if (minuteTime > 60) {
      //获取小时，获取分钟除以60，得到整数小时
      hourTime = parseInt(minuteTime / 60);
      //获取小时后取佘的分，获取分钟除以60取佘的分
      minuteTime = parseInt(minuteTime % 60);
    }
  }
  var result = "" + parseInt(secondTime);

  if (minuteTime > 0) {
    result = "" + parseInt(minuteTime) + ":" + result;
  }
  if (hourTime > 0) {
    result = "" + parseInt(hourTime) + ":" + result;
  }
  return result;
}
export { convert }


// 时间戳转换时分秒
let Time = function (times) {
  let h = parseInt(times / 1000 / 60 / 60, 10) < 10 ? '0' + parseInt(times / 1000 / 60 / 60, 10) + ':' : parseInt(times / 1000 / 60 / 60, 10) + ':';
  let m = parseInt(times / 1000 / 60 % 60, 10) < 10 ? '0' + parseInt(times / 1000 / 60 % 60, 10) + ':' : parseInt(times / 1000 / 60 % 60, 10) + ':';
  let s = parseInt(times / 1000 % 60, 10) < 10 ? '0' + parseInt(times / 1000 % 60, 10) : parseInt(times / 1000 % 60, 10);
  return h + m + s;
}
export { Time }

// 时
let timeHour = function formatSeconds(times) {
  let h = parseInt(times / 1000 / 60 / 60, 10) < 10 ? '0' + parseInt(times / 1000 / 60 / 60, 10) : parseInt(times / 1000 / 60 / 60, 10);
  let m = parseInt(times / 1000 / 60 % 60, 10) < 10 ? '0' + parseInt(times / 1000 / 60 % 60, 10) : parseInt(times / 1000 / 60 % 60, 10);
  let s = parseInt(times / 1000 % 60, 10) < 10 ? '0' + parseInt(times / 1000 % 60, 10) : parseInt(times / 1000 % 60, 10);
  return h;
}
export { timeHour }


// 分钟
let timeMinute = function formatSeconds(times) {
  let h = parseInt(times / 1000 / 60 / 60, 10) < 10 ? '0' + parseInt(times / 1000 / 60 / 60, 10) : parseInt(times / 1000 / 60 / 60, 10);
  let m = parseInt(times / 1000 / 60 % 60, 10) < 10 ? '0' + parseInt(times / 1000 / 60 % 60, 10) : parseInt(times / 1000 / 60 % 60, 10);
  let s = parseInt(times / 1000 % 60, 10) < 10 ? '0' + parseInt(times / 1000 % 60, 10) : parseInt(times / 1000 % 60, 10);
  return m;
}
export { timeMinute }


// 秒
let timeSecondr = function formatSeconds(times) {
  let h = parseInt(times / 1000 / 60 / 60, 10) < 10 ? '0' + parseInt(times / 1000 / 60 / 60, 10) + ':' : parseInt(times / 1000 / 60 / 60, 10) + ':';
  let m = parseInt(times / 1000 / 60 % 60, 10) < 10 ? '0' + parseInt(times / 1000 / 60 % 60, 10) + ':' : parseInt(times / 1000 / 60 % 60, 10) + ':';
  let s = parseInt(times / 1000 % 60, 10) < 10 ? '0' + parseInt(times / 1000 % 60, 10) : parseInt(times / 1000 % 60, 10);
  return s;
}
export { timeSecondr }