<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<% if(((int)(Math.random()*100)) % 15 == 0){ %>
<!-- 

//
//                       _oo0oo_
//                      o8888888o
//                      88" . "88
//                      (| -_- |)
//                      0\  =  /0
//                    ___/`---'\___
//                  .' \\|     |// '.
//                 / \\|||  :  |||// \
//                / _||||| -:- |||||- \
//               |   | \\\  -  /// |   |
//               | \_|  ''\---/''  |_/ |
//               \  .-\__  '-'  ___/-. /
//             ___'. .'  /--.--\  `. .'___
//          ."" '<  `.___\_<|>_/___.' >' "".
//         | | :  `- \`.;`\ _ /`;.`/ - ` : | |
//         \  \ `_.   \_ __\ /__ _/   .-` /  /
//     =====`-.____`.___ \_____/___.-`___.-'=====
//                       `=---='
//
//
//     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
//
//               佛祖保佑         永無bug
//
//***************************************************

 -->
 
 <%} else {
	 
 }%>
<html lang="en">
<head>
<meta HTTP-EQUIV="content-type" CONTENT="text/html; charset=UTF-8" />

<!-- lib start-->
<tiles:insertAttribute name="lib" />
<!-- lib  end -->
<title><tiles:insertAttribute name="title" /></title>
</head>
<body>
<div class="allbody">
<!-- menu start -->
<div class="menu">
    	<tiles:insertAttribute name="menu" />
</div>	
<!-- menu  end  -->
    
<!-- body start -->
<div class="main">
	<tiles:insertAttribute name="body" />
</div>
<!-- body  end  -->
    
<!-- footer start-->
<div class="footer">
    	<tiles:insertAttribute name="footer" />
</div>
<!-- footer end-->
</div>
</body>
</html>
