<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
String basePath = request.getScheme() + "://" + request.getServerName() + ":"
+ request.getServerPort() + request.getContextPath() + "/";
%>
<%@ page isELIgnored="false" %><%--阻止jsp忽略el表达式--%>
<html>
<head>
<meta charset="UTF-8">
	<base href="<%=basePath%>" />
<link href="jquery/bootstrap_3.3.0/css/bootstrap.min.css" type="text/css" rel="stylesheet" />
<link href="jquery/bootstrap-datetimepicker-master/css/bootstrap-datetimepicker.min.css" type="text/css" rel="stylesheet" />

<script type="text/javascript" src="jquery/jquery-1.11.1-min.js"></script>
<script type="text/javascript" src="jquery/bootstrap_3.3.0/js/bootstrap.min.js"></script>
<script type="text/javascript" src="jquery/bootstrap-datetimepicker-master/js/bootstrap-datetimepicker.js"></script>
<script type="text/javascript" src="jquery/bootstrap-datetimepicker-master/locale/bootstrap-datetimepicker.zh-CN.js"></script>

   <link rel="stylesheet" type="text/css" href="jquery/bs_pagination/jquery.bs_pagination.min.css">
   <script type="text/javascript" src="jquery/bs_pagination/jquery.bs_pagination.min.js"></script>
   <script type="text/javascript" src="jquery/bs_pagination/en.js"></script>

<script type="text/javascript">

	$(function(){
		$("#addBtn").click(function () {
            //时间控件
			$(".time").datetimepicker({
				minView: "month",
				language:  'zh-CN',
				format: 'yyyy-mm-dd',
				autoclose: true,
				todayBtn: true,
				pickerPosition: "bottom-left"
			})
			//alert("123");

			//走后台，拿取数据
			$.ajax({
				url:"workbench/activity/getUserList.do",
				type:"post",
				dataType:"json",
				success:function (data){
					var a = "";
                $.each(data,function (i,n){
                  a += "<option value='"+n.id+"'> "+n.name+" </option>";
				})
					$("#create-owner").html(a);
				/*
                操作模态窗口的方式
                */
					//取得当前用户ip
					//在js中使用EL表达式，EL表达式一定要套用在字符串中
					var id = "${user.id}"
					$("#create-owner").val(id);
					$("#createActivityModal").modal("show");
				}
			})

		})


		//为保存绑定按钮事件，执行添加操作(千万不能写在addBtn事件按钮里面)
		$("#saveBtn").click(function () {
			$.ajax({
				url:"workbench/activity/save.do",
				data:{
					"owner":$.trim($("#create-owner").val()),
					"name":$.trim($("#create-name").val()),
					"startDate":$.trim($("#create-startDate").val()),
					"endDate":$.trim($("#create-endDate").val()),
					"cost":$.trim($("#create-cost").val()),
					"description":$.trim($("#create-description").val()),
				},
				type:"post",
				dataType: "json",
				success:function (data) {
					if (data.success){
                        pageList(1,2)
						//添加成功后
						//刷新市场活动信息列表(局部刷新)

						/*

                           注意：
                               我们拿到了form表单的jquery对象
                               对于表单的jquery对象，提供了submit()方法让我们提交表单
                               但是表单的jquery对象，没有为我们提供reset()方法让我们重置表单（坑：idea为我们提示了有reset()方法）

                               虽然jquery对象没有为我们提供reset方法，但是原生js为我们提供了reset方法
                               所以我们要将jquery对象转换为原生dom对象

                               jquery对象转换为dom对象：
                                   jquery对象[下标]

                               dom对象转换为jquery对象：
                                   $(dom)

                        */

						//清空添加操作模态窗口中的数据
						$("#activityAddForm")[0].reset();

						//关闭模态窗口
						$("#createActivityModal").modal("hide");

						alert("添加成功");
						//return false;

					}else{
						alert("添加市场活动失败");
					}
				}
			})

		})

		pageList(1,2);

		//为查询按钮绑定事件，触发pageList方法
		$("#searchBtn").click(function (){
			/*保存到隐藏域当中*/
			$("#hidden-name").val($.trim($("#search-name").val()));
			$("#hidden-owner").val($.trim($("#search-owner").val()));
			$("#hidden-startDate").val($.trim($("#search-startDate").val()));
			$("#hidden-endDate").val($.trim($("#search-endDate").val()));


			pageList(1,2);
		})

		//为全选框绑定事件，触发全选操作
		$("#qx").click(function () {
			$("input[name=xz]").prop("checked",this.checked);
		})

		//单点一个取消全选
		$("#activityBody").on("click",$("input[name=xz]"),function () {
			//alert("123")
			$("#qx").prop("checked",$("input[name=xz]").length==$("input[name=xz]:checked".length))
		})

        //为删除按钮绑定事件，执行市场活动删除操作
		$("#deleteBtn").click(function () {
			var $xz = $("input[name=xz]:checked");
			if ($xz.length==0){
				alert("请选择需要删除的记录")
			}else{

				if (confirm("确定删除吗？")){
					//拼接参数
					var param ="";
					//将$xz遍历，取出里面打钩选择的input的值
					for (var i = 0; i <$xz.length ; i++) {
						param +="id="+$xz[i].value;

						//param +="id="+$($xz[i]).value
						//如果不是最后一个元素，每一个元素后面要加&符号
						if (i<$xz.length-1){
							param += "&";
						}

					}
					//alert(param);
					$.ajax({
						url:"workbench/activity/delete.do",
						data: param,
						type:"post",
						dataType:"json",
						success:function (data) {
							if(data.success){
								alert("删除成功");
								pageList(1,2);
							}else{
								alert("删除失败")
							}
						}
					})
				}

			}
		})

		//为修改按钮绑定事件，打开修改操作模态窗口
		$("#editBtn").click(function () {
			var $xz = $("input[name=xz]:checked");
			if ($xz.length==0){
				alert("请选择需要修改的记录")
			}else if ($xz.length>1){
				alert("请选择一条记录进行修改")
			}else {
				var id = $xz.val();
				$.ajax({
					url:"workbench/activity/getUserListAndActivity.do",
					data:{
						/*
						 传过来一个uList
						 传过来一个单条详情数据a
						*/
						"id":id,
					},
					type:"post",
					dataType:"json",
					success:function (data) {
						//处理所有者下拉框
                        var html = "";
                        $.each(data.uList,function (i,n) {
                            html +="<option value='"+n.id+"'>"+n.name+"</option>";
						})
						$("#edit-owner").html(html);
                        //处理单条activity
						$("#edit-name").val(data.a.name);
						$("#edit-owner").val(data.a.owner);
						$("#edit-startDate").val(data.a.startDate);
						$("#edit-endDate").val(data.a.endDate);
						$("#edit-cost").val(data.a.cost);
						$("#edit-description").val(data.a.description);
						$("#edit-id").val(data.a.id);

						//所有值都填好之后，打开修改操作的模态窗口
						$("#editActivityModal").modal("show");

					}
				})

			}
		})

		//为更新按钮绑定事件，执行修改操作
		$("#updateBtn").click(function () {
			$.ajax({
				url:"workbench/activity/update.do",
				data:{
					"id":$.trim($("#edit-id").val()),
					"owner":$.trim($("#edit-owner").val()),
					"name":$.trim($("#edit-name").val()),
					"startDate":$.trim($("#edit-startDate").val()),
					"endDate":$.trim($("#edit-endDate").val()),
					"cost":$.trim($("#edit-cost").val()),
					"description":$.trim($("#edit-description").val()),
				},
				type:"post",
				dataType: "json",
				success:function (data) {
					if (data.success){
                        pageList(1,2)
						//添加成功后
						//刷新市场活动信息列表(局部刷新)

						/*

                           注意：
                               我们拿到了form表单的jquery对象
                               对于表单的jquery对象，提供了submit()方法让我们提交表单
                               但是表单的jquery对象，没有为我们提供reset()方法让我们重置表单（坑：idea为我们提示了有reset()方法）

                               虽然jquery对象没有为我们提供reset方法，但是原生js为我们提供了reset方法
                               所以我们要将jquery对象转换为原生dom对象

                               jquery对象转换为dom对象：
                                   jquery对象[下标]

                               dom对象转换为jquery对象：
                                   $(dom)

                        */

						//清空添加操作模态窗口中的数据
						//$("#activityAddForm")[0].reset();

						//关闭模态窗口
						$("#editActivityModal").modal("hide");

						alert("修改成功");
						//return false;

					}else{
						alert("修改市场活动失败");
					}
				}
			})

		})

	});

	//pageList方法
	function pageList(pageNo,pageSize){
		//将全选的复选框取消
		$("#qx").prop("checked",false);

		/*保存到隐藏域当中*/
		$("#search-name").val($.trim($("#hidden-name").val()));
		$("#search-owner").val($.trim($("#hidden-owner").val()));
		$("#search-startDate").val($.trim($("#hidden-startDate").val()));
		$("#search-endDate").val($.trim($("#hidden-endDate").val()));

		$.ajax({
			url:"workbench/activity/pageList.do",
			data:{
			  "pageNo":pageNo,
			  "pageSize":pageSize,
				"name":$.trim($("#search-name").val()),
				"owner":$.trim($("#search-owner").val()),
				"startDate":$.trim($("#search-startDate").val()),
				"endDate":$.trim($("#search-endDate").val()),
			},
			type:"get",
			dataType:"json",
			success:function (data){
                var html ="";
                $.each(data.dataList,function (i,n){
				    html += '<tr class="active">';
					html += '<td><input type="checkbox" name="xz" value="'+n.id+'" /></td>';
					html += '<td><a style="text-decoration: none; cursor: pointer;" onclick="window.location.href=\'workbench/activity/detail.jsp\';">'+n.name+'</a></td>';
					html += '<td>'+n.owner+'</td>';
					html += '<td>'+n.startDate+'</td>';
					html += '<td>'+n.endDate+'</td>';
					html += '</tr>';
				})
				$("#activityBody").html(html);
                //alert("123")
                //计算总页数
				//var totalPages = data.total%pageSize==0?data.total%pageSize:parseInt(data.total%pageSize)+1;
				var totalPages = data.total%pageSize==0?data.total/pageSize:parseInt(data.total/pageSize)+1;
                //数据处理完毕后，结合分页查询，对前端展现分页信息
				$("#activityPage").bs_pagination({
					currentPage: pageNo, // 页码
					rowsPerPage: pageSize, // 每页显示的记录条数
					maxRowsPerPage: 20, // 每页最多显示的记录条数
					totalPages: totalPages, // 总页数
					totalRows: data.total, // 总记录条数

					visiblePageLinks: 3, // 显示几个卡片

					showGoToPage: true,
					showRowsPerPage: true,
					showRowsInfo: true,
					showRowsDefaultInfo: true,
                    //该回调函数是在点击分页组件时触发的
					onChangePage : function(event, data){
						pageList(data.currentPage , data.rowsPerPage);
					}
				});
				//alert("111");

			}
		})
	}
</script>
</head>
<body>
<%--隐藏域--%>
<input type="hidden" id="hidden-name" />
<input type="hidden" id="hidden-owner" />
<input type="hidden" id="hidden-startDate" />
<input type="hidden" id="hidden-endDate" />


	<!-- 创建市场活动的模态窗口 -->
	<div class="modal fade" id="createActivityModal" role="dialog">
		<div class="modal-dialog" role="document" style="width: 85%;">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">
						<span aria-hidden="true">×</span>
					</button>
					<h4 class="modal-title" id="myModalLabel1">创建市场活动</h4>
				</div>
				<div class="modal-body">
				
					<form id="activityAddForm" class="form-horizontal" role="form">
					
						<div class="form-group">
							<label for="create-marketActivityOwner" class="col-sm-2 control-label">所有者<span style="font-size: 15px; color: red;">*</span></label>
							<div class="col-sm-10" style="width: 300px;">
								<select class="form-control" id="create-owner">

								</select>
							</div>
                            <label for="create-marketActivityName" class="col-sm-2 control-label">名称<span style="font-size: 15px; color: red;">*</span></label>
                            <div class="col-sm-10" style="width: 300px;">
                                <input type="text" class="form-control" id="create-name">
                            </div>
						</div>
						
						<div class="form-group">
							<label for="create-startTime" class="col-sm-2 control-label">开始日期</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control time" id="create-startDate"readonly>
							</div>
							<label for="create-endTime" class="col-sm-2 control-label">结束日期</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control time" id="create-endDate" readonly>
							</div>
						</div>
                        <div class="form-group">

                            <label for="create-cost" class="col-sm-2 control-label">成本</label>
                            <div class="col-sm-10" style="width: 300px;">
                                <input type="text" class="form-control" id="create-cost">
                            </div>
                        </div>
						<div class="form-group">
							<label for="create-describe" class="col-sm-2 control-label">描述</label>
							<div class="col-sm-10" style="width: 81%;">
								<textarea class="form-control" rows="3" id="create-description"></textarea>
							</div>
						</div>

					</form>
					
				</div>
				<div class="modal-footer">
					<%--data-dismiss关闭模态窗口--%>
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					<button type="button" class="btn btn-primary" id="saveBtn">保存</button>
				</div>
			</div>
		</div>
	</div>





	<!-- 修改市场活动的模态窗口 -->
	<div class="modal fade" id="editActivityModal" role="dialog">
		<div class="modal-dialog" role="document" style="width: 85%;">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">
						<span aria-hidden="true">×</span>
					</button>
					<h4 class="modal-title" id="myModalLabel2">修改市场活动</h4>
				</div>
				<div class="modal-body">
				
					<form class="form-horizontal" role="form">
					
						<div class="form-group">
							<label for="edit-marketActivityOwner" class="col-sm-2 control-label">所有者<span style="font-size: 15px; color: red;">*</span></label>
							<div class="col-sm-10" style="width: 300px;">
								<select class="form-control" id="edit-owner">

								</select>
							</div>
                            <label for="edit-marketActivityName" class="col-sm-2 control-label">名称<span style="font-size: 15px; color: red;">*</span></label>
                            <div class="col-sm-10" style="width: 300px;">
                                <input type="text" class="form-control" id="edit-name" >
                            </div>
						</div>

						<div class="form-group">
							<label for="edit-startTime" class="col-sm-2 control-label">开始日期</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control time" id="edit-startDate" readonly>
							</div>
							<label for="edit-endTime" class="col-sm-2 control-label">结束日期</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control time" id="edit-endDate" readonly>
							</div>
						</div>
						
						<div class="form-group">
							<label for="edit-cost" class="col-sm-2 control-label">成本</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="edit-cost" >
							</div>
						</div>
						
						<div class="form-group">
							<label for="edit-describe" class="col-sm-2 control-label">描述</label>
							<div class="col-sm-10" style="width: 81%;">
								<textarea class="form-control" rows="3" id="edit-description"></textarea>
							</div>
						</div>
						
					</form>
					
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					<button type="button" class="btn btn-primary" id="updateBtn">更新</button>
				</div>
			</div>
		</div>
	</div>
	
	
	
	
	<div>
		<div style="position: relative; left: 10px; top: -10px;">
			<div class="page-header">
				<h3>市场活动列表</h3>
			</div>
		</div>
	</div>
	<div style="position: relative; top: -20px; left: 0px; width: 100%; height: 100%;">
		<div style="width: 100%; position: absolute;top: 5px; left: 10px;">
		
			<div class="btn-toolbar" role="toolbar" style="height: 80px;">
				<form class="form-inline" role="form" style="position: relative;top: 8%; left: 5px;">
                    <%--隐藏域，放id--%>
					<input type="hidden" id="edit-id" />
				  <div class="form-group">
				    <div class="input-group">
				      <div class="input-group-addon">名称</div>
				      <input class="form-control" type="text" id="search-name">
				    </div>
				  </div>
				  
				  <div class="form-group">
				    <div class="input-group">
				      <div class="input-group-addon">所有者</div>
				      <input class="form-control" type="text" id="search-owner">
				    </div>
				  </div>


				  <div class="form-group">
				    <div class="input-group">
				      <div class="input-group-addon">开始日期</div>
					  <input class="form-control" type="text" id="search-startDate" />
				    </div>
				  </div>
				  <div class="form-group">
				    <div class="input-group">
				      <div class="input-group-addon">结束日期</div>
					  <input class="form-control" type="text" id="search-endDate">
				    </div>
				  </div>
				  
				  <button type="button" class="btn btn-default" id="searchBtn">查询</button>
				  
				</form>
			</div>
			<div class="btn-toolbar" role="toolbar" style="background-color: #F7F7F7; height: 50px; position: relative;top: 5px;">
				<div class="btn-group" style="position: relative; top: 18%;">
				  <button type="button" class="btn btn-primary" id="addBtn"><span class="glyphicon glyphicon-plus"></span> 创建</button>
				  <button type="button" class="btn btn-default" id="editBtn"><span class="glyphicon glyphicon-pencil"></span> 修改</button>
				  <button type="button" class="btn btn-danger" id="deleteBtn"><span class="glyphicon glyphicon-minus"></span> 删除</button>
				</div>
				
			</div>
			<div style="position: relative;top: 10px;">
				<table class="table table-hover">
					<thead>
						<tr style="color: #B3B3B3;">
							<td><input type="checkbox" id="qx"/></td>
							<td>名称</td>
                            <td>所有者</td>
							<td>开始日期</td>
							<td>结束日期</td>
						</tr>
					</thead>
					<tbody id="activityBody">

					</tbody>
				</table>
			</div>
			
			<div style="height: 50px; position: relative;top: 30px;">

				<div id="activityPage"></div>
			</div>
			
		</div>
		
	</div>
<%--<div id="activityPage"></div>--%>
</body>
</html>