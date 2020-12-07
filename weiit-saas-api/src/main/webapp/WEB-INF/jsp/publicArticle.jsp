<%@ page language="java" pageEncoding="utf-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html;charset=UTF-8">
    <title>${blog.title}</title>
    <meta content="width=device-width, initial-scale=1.0, minimum-scale=1.0" name="viewport">
    <style type="text/css">
        body { font-family: arial; font-size: 12px; background-color: #fff; color: #333; margin: 0 auto; min-width: 320px; max-width: 640px;}
        .main { min-width: 320px; }
        .about-area {background-color: #fff;}
        .about-area img {width: 100%; height: 100%}
    </style>
</head>
<body>
<div class="main">
    <div class="about-area">${blog.content}</div>
</div>
</body>
</html>