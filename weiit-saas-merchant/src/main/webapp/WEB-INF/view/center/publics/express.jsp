<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
 
<!-- 物流信息  -->
<div class="modal fade" id="modal-Express">
	<div class="modal-dialog">
		<div class="modal-content" style="margin-left: -100px;">
			<div class="modal-header" style="height: 43px;padding-top:5px;margin-top:5px;">
				<button type="button" class="close" data-dismiss="modal"
					aria-hidden="true">×</button>
				<h2 class="modal-title text-bold">快递详细信息</h2>
			</div>
			<hr style="padding:0px;margin:0px;">
			<div class="modal-body" >
				<table id="levelTable"
					class="table table-striped table-bordered  table-condensed ">
					<thead>
						<tr>
							<th width="170">操作时间</th>
							<th>快递信息</th>
						</tr>
					</thead>
					<tbody>

					</tbody>
				</table>
			</div>
		</div>
	</div>
</div>
<!--  end modal-alert -->

<script>
var exNum="";
function oncheckExpress(expressNum,expressCode){
//	if(exNum==expressNum){
//		$('#modal-Express').modal('show');
//	}
	exNum=expressNum;
	$("#levelTable").find("tbody").html("");
	if(expressCode==""){
		MAlert("物流公司配置信息异常，请稍后再试！");
		return;
	}
	var url="${pageContext.request.contextPath}/center/publics/publics/expressList?expressCode="+expressCode+"&expressNum="+expressNum;	
	$.post(url,  null ,
		function (result){
 	 	  try{
 	 		var date= eval("("+result+")"); 
 	 		var tr="";
 	 		if(date.code=='-1'){
   	 	    	tr+="<tr class='odd gradeA'><td  colspan='2'><label style='color: red;'>"+date.message+"</label></td>"
    		  	 +'</tr>';
   	 	    }
 	 		if(date.code=='0'){
 	 	    	date= eval("("+date.data+")");
//	   	 		if(date.Success==true && (date.Reason=="" || date.Reason==undefined ) ){
//		    		var expList = date.Traces ;
//		    		for(var i=0;i<expList.length;i++){
//		    		  	tr+="<tr class='odd gradeA'><td> "+expList[i].AcceptTime+"</td>"
//		    		  	 +'<td>'+expList[i].AcceptStation+'</td></tr>';
//		    		}
//	   	 	 	}else{
//	       	 	      tr+="<tr class='odd gradeA'><td  colspan='2'><label style='color: red;'>"+date.Reason+"</label></td>"
//		    		  	 +'</tr>';
//	   	 	 	}
	   	 		if(date.status==0 && date.msg=="ok"){
		    		var expList = date.result.list ;
		    		for(var i=0;i<expList.length;i++){
		    		  	tr+="<tr class='odd gradeA'><td> "+expList[i].time+"</td>"
		    		  	 +'<td>'+expList[i].status+'</td></tr>';
		    		}
	   	 	 	}else{
	       	 	      tr+="<tr class='odd gradeA'><td  colspan='2'><label style='color: red;'>"+date.Reason+"</label></td>"
		    		  	 +'</tr>';
	   	 	 	}

 	 		}
              $("#levelTable").find("tbody").html(tr);
              $('#modal-Express').modal('show');
    	  }catch(oException){
    		  MAlert("和服务器交互失败:" + oException.message);
    	  }
	});
}; 
 
</script>