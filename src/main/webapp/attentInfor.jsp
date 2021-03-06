<%@ page language="java" pageEncoding="UTF-8"%>
<div class="easyui-panel" data-options="fit:true,border:false">
	<div align="center"
		style="margin: 20px auto auto 20px; font-weight: bold; font-size: 20px;">

		<p class="zooqi-head-text">考勤信息管理</p>

	</div>
	<div style="margin: 20px 30px auto 30px;"  >
		<table id="attent_datagrid"></table>
		<!-- 工具栏按钮 -->
		<div id="attent_toolbar">
			<a id="attent_reload" href="javascript:void(0)" class="easyui-linkbutton"
				data-options="iconCls:'icon-reload',plain:true">显示所有</a> <a
				id="attent_add" href="javascript:void(0)" class="easyui-linkbutton"
				data-options="iconCls:'icon-add',plain:true">添加</a> <a id="attent_edit"
				href="javascript:void(0)" class="easyui-linkbutton"
				data-options="iconCls:'icon-edit',plain:true">编辑</a> <a
				id="attent_delete" href="javascript:void(0)" class="easyui-linkbutton"
				data-options="iconCls:'icon-remove',plain:true">删除</a> <a
				id="attent_search" href="javascript:void(0)" class="easyui-linkbutton"
				data-options="iconCls:'icon-search',plain:true">搜索</a>
		</div>
		<!-- 对话框 -->
		<div id="attent_edit_dlg" class="easyui-dialog"
			style="padding: 0px 0px; width: 550px; height: 320px;"
			data-options="closed:true,buttons:'#attent_edit_dlg-buttons'">
			<form id="attent_edit_fm">
				<div id="attent_edit_tabs" class="easyui-tabs">
					<div title="考勤基本信息">
						<table class="zooqi-frame-text" border="1"
							style="border-collapse: collapse; border: 2px solid #D6E3F4; margin-left: 3px; margin-right: 1px"
							cellspacing="35%" cellpadding="8">
							<tr>
								<td style="width: 93px; text-align: center;">姓&emsp;&emsp;名：</td>
								<td>
									<input id="empInfor" name="empName" style="width: 144px">
								</td>
								<td style="width: 93px; text-align: center;">时&emsp;&emsp;间：</td>
								<td><input id="datetime11" name="attentDate"
									data-options="validType:'length[0,32]'" style="width: 144px">
								</td>
							</tr>
							<tr>
								<td style="width: 93px; text-align: center;">出  &nbsp;勤 &nbsp;数：</td>
								<td><input class="easyui-validatebox" name="attentNum"
									data-options="validType:'length[0,32]'" style="width: 140px">
								</td>
								<td style="width: 93px; text-align: center;">请 &nbsp;假 &nbsp;数：</td>
								<td><input class="easyui-validatebox" name="attentReasonNum"
									data-options="validType:'length[0,32]'" style="width: 140px">
								</td>
							</tr>
							<tr>
								<td style="width: 93px; text-align: center;">请假理由：</td>
								<td><input class="easyui-validatebox" name="attentReason"
									data-options="validType:'length[0,32]'" style="width: 140px">
								</td>
								<td style="width: 93px; text-align: center;">加 &nbsp;班 &nbsp;数：</td>
								<td><input class="easyui-validatebox" name="attentOverTimeNum"
									data-options="validType:'length[0,32]'" style="width: 140px">
								</td>
							</tr>
							<tr>
								<td style="width: 93px; text-align: center;">加 &nbsp;班 &nbsp;费：</td>
								<td><input class="easyui-validatebox" name="attentOverTimePay"
									data-options="validType:'length[0,32]'" style="width: 140px">
								</td>
								<td style="width: 93px; text-align: center;">奖&emsp;&emsp;金：</td>
								<td><input class="easyui-validatebox" name="attentBonus"
									data-options="validType:'length[0,32]'" style="width: 140px">
								</td>
							</tr>
							<tr>
								<td style="width: 93px; text-align: center;">基本工资：</td>
								<td><input class="easyui-validatebox" name="empWage"
									data-options="validType:'length[0,32]'" style="width: 140px">
								</td>
								<td style="width: 93px; text-align: center;">备&emsp;&emsp;注：</td>
								<td><input class="easyui-validatebox" name="attentRemark"
									data-options="validType:'length[0,32]'" style="width: 140px">
								</td>
							</tr>
						</table>
					</div>
				</div>
			</form>
		</div>
		
		<!-- 按钮 -->
		<div id="attent_edit_dlg-buttons">
			<a id="attent_edit_submit_button" href="javascript:void(0)"
				class="easyui-linkbutton c6" data-options="iconCls:'icon-ok'"
				style="width: 90px">保存</a> <a href="javascript:void(0)"
				class="easyui-linkbutton" data-options="iconCls:'icon-cancel'"
				onclick="javascript:$('#attent_edit_dlg').dialog('close');$('#attent_edit_fm').form('clear');"
				style="width: 90px">取消</a>
		</div>
	</div>

	<!-- 搜索表单 -->
	<div id="attent_search_dlg" class="easyui-dialog"
		style="padding: 20px 50px;"
		data-options="closed:true,buttons:'#attent_search_dlg-buttons'">
		<form id="attent_search_fm">
			<table class="zooqi-frame-text" style="border-spacing: 10px;">
				<tr>
					<td width="72px">职 &nbsp;工 &nbsp;号 ：</td>
					<td><input id="attent_empNum" name="empNum" style="width: 114px"></td>
				</tr>
				<tr>
					<td width="70px">员工姓名：</td>
					<td><input id="attent_empName" name="empName" style="width: 114px"></td>
				</tr>
				<tr>
					<td>时&emsp;&emsp;间：</td>
					<td><input id="datetime1" name="attentDate"
						data-options="validType:'length[0,32]'" style="width: 114px">
					</td>
				</tr>
			</table>
		</form>
	</div>
	<div id="attent_search_dlg-buttons">
		<a id="attent_search_button" href="javascript:void(0)"
			class="easyui-linkbutton c6" data-options="iconCls:'icon-ok'"
			style="width: 90px">搜索</a> <a href="javascript:void(0)"
			class="easyui-linkbutton" data-options="iconCls:'icon-cancel'"
			onclick="javascript:$('#attent_search_dlg').dialog('close')"
			style="width: 90px">取消</a>
	</div>

	<script type="text/javascript">
		$('#attent_datagrid').datagrid({
			url : 'attentReach',
			fitColumns : true,
			singleSelect : true,
			pagination : true,
			rownumbers : true,
			toolbar : '#attent_toolbar',
			remoteSort : false,
			columns : [ [ {
				field : 'attentId',
				hidden : true
			}, {
				title : '职工号',
				field : 'empNum',
				align : 'center',
				sortable : true,
				width : 100,
				formatter : function(value, row, index) {
					if(row.empId) {
						return row.empNum;
					} else {
						return value;
					}
				}
			}, {
				title : '姓名',
				field : 'empId',
				align : 'center',
				sortable : true,
				width : 100,
				formatter : function(value, row, index) {
					if(row.empId) {
						return row.empName;
					} else {
						return value;
					}
				}
			}, {
				title : '部门',
				field : 'empDepart',
				align : 'center',
				sortable : true,
				width : 100,
				formatter : function(value, row, index) {
					if(row.empId) {
						return row.empDepart;
					} else {
						return value;
					}
				}
			}, {
				title : '考勤次数',
				field : 'attentDate',
				align : 'center',
				sortable : true,
				width : 100,
			}, {
				title : '请假理由',
				field : 'attentReason',
				align : 'center',
				sortable : true,
				width : 140,
			}, {
				title : '出勤数',
				field : 'attentNum',
				align : 'center',
				sortable : true,
				width : 80
			}, {
				title : '请假时间',
				field : 'attentReasonNum',
				align : 'center',
				sortable : true,
				width : 150
			}, {
				title : '请假次数',
				field : 'attentReasonNum',
				align : 'center',
				sortable : true,
				width : 150
			}, {
				title : '加班次数',
				field : 'attentOverTimeNum',
				align : 'center',
				sortable : true,
				width : 80
			}, {
				title : '加班费',
				field : 'attentOverTimePay',
				align : 'center',
				sortable : true,
				width : 100
			}, {
				title : '奖金',
				field : 'attentBonus',
				align : 'center',
				sortable : true,
				width : 100
			}, {
				title : '基本工资',
				field : 'empWage',
				align : 'center',
				sortable : true,
				width : 100
			}, {
				title : '备注',
				field : 'attentRemark',
				align : 'center',
				sortable : true,
				width : 150
			}] ]
		});

		/* 显示所有 */
		$('#attent_reload').click(function() {
			$("#attent_datagrid").datagrid("load", {});
		});
		
		/* 获取职工姓名  */
		$('#empInfor').combobox({ 
			url:'empInfor', 
			valueField:'empId',
			textField:'empName'
		});
		
		$('#attent_empName').combobox({ 
			url:'empInfor', 
			valueField:'empId',
			textField:'empName'
		});
		
		/*获取职工号*/
		$('#attent_empNum').combobox({ 
			url:'empInfor', 
			valueField:'empId',
			textField:'empNum'
		});
		/*获取职工部门*/
		$('#attent_empDepart').combobox({ 
			url:'empInfor', 
			valueField:'empId',
			textField:'empDepart'
		});
		
		var url;
		/* 弹出添加窗口 */
		$('#attent_add').click(function() {
			$('#attent_edit_dlg').dialog('open').dialog('setTitle', '添加');
			url = 'attentAdd';
		});
		/* 弹出编辑窗口 */
		$('#attent_edit').click(function() {
			var row = $('#attent_datagrid').datagrid('getSelected');
			if (row) {
				url = 'attentUpda?attentId=' + row.attentId;
				$('#attent_edit_dlg').dialog('open').dialog('setTitle', '编辑信息');
				$('#attent_edit_fm').form('load', row);
			} else {
				$.messager.alert('提示', '请选择数据！');
			}
		});
		$('#attent_edit_submit_button').click(function() {
			if (!$('#attent_edit_fm').form('validate')) {
				$.messager.alert('提示', '请正确填写信息！');
				return;
			}
			$.messager.confirm('确认', '确认保存吗？', function(r) {
				if (r) {
					$.ajax({
						type : 'POST',
						url : url,
						data : $('#attent_edit_fm').serialize(),
						success : function(data) {
							if (data.success) {
								$.messager.alert('提示', '保存成功！');
								$('#attent_edit_dlg').dialog('close');
								$("#attent_datagrid").datagrid("reload");
							} else {
								$.messager.alert('提示', '保存失败，请稍后再试！');
							}
						},
						error : function(request, error) {
							$.messager.alert('提示', '保存失败，请稍后再试！');
						}
					});
				} else {
					$('#attent_edit_dlg').dialog('close');
				}
				$('#attent_edit_fm').form('clear');
			});
		});

		/* 删除用户 */
		$('#attent_delete').click(function() {
			var row = $('#attent_datagrid').datagrid('getSelected');
			if (row) {
				$.messager.confirm('确认', '确认删除吗？', function(r) {
					if (r) {
						$.ajax({
							type : 'POST',
							url : 'attentDele',
							data : {
								attentId : row.attentId
							},
							success : function(data) {
								//var result = eval("(" + data + ")");
								if (data.success) {
									$.messager.alert('提示', '删除成功！');
									$("#attent_datagrid").datagrid("reload");
								} else {
									$.messager.alert('提示', '删除失败，请稍后再试！');
								}
							},
							error : function(request, error) {
								$.messager.alert('提示', '删除失败，请稍后再试！');
							}
						});
					}
				});
			} else {
				$.messager.alert('提示', '请选择数据！');
			}
		});
		
		/*弹出搜索窗口*/
		$('#attent_search').click(function() {
			$('#attent_search_dlg').dialog('open').dialog('setTitle', '搜索出勤信息');
		});
		/* 搜索 */
		$('#attent_search_button').click(function() {
			if (!$('#attent_search_fm').form('validate')) {
				$.messager.alert('提示', '请正确填写信息！');
				return;
			}
			$('#attent_datagrid').datagrid('load', {
				empNum : $('#attent_empNum').combobox('getText'),
				empName : $('#attent_empName').combobox('getText'),
				attentDate : $('#datetime1').datebox('getValue')
			});
			$('#attent_search_dlg').dialog('close');
			$('#attent_search_fm').form('clear');
		});

		/*修改easyUI的日期控件*/
		$(function() {      
      		$('#datetime1').datebox({    
           		 onShowPanel : function() {// 显示日趋选择对象后再触发弹出月份层的事件，初始化时没有生成月份层    
                	span.trigger('click'); // 触发click事件弹出月份层    
                if (!tds)    
                    setTimeout(function() {// 延时触发获取月份对象，因为上面的事件触发和对象生成有时间间隔    
                        tds = p.find('div.calendar-menu-month-inner td');    
                        tds.click(function(e) {    
                            e.stopPropagation(); // 禁止冒泡执行easyui给月份绑定的事件    
                            var year = /\d{4}/.exec(span.html())[0]// 得到年份    
                            , month = parseInt($(this).attr('abbr'), 10) + 1; // 月份    
                            $('#datetime1').datebox('hidePanel')// 隐藏日期对象    
                            .datebox('setValue', year + '-' + month); // 设置日期的值    
                        });    
                    }, 0);    
            },    
            parser : function(s) {// 配置parser，返回选择的日期    
                if (!s)    
                    return new Date();    
                var arr = s.split('-');    
                return new Date(parseInt(arr[0], 10), parseInt(arr[1], 10) - 1, 1);    
            },    
            formatter : function(d) {    
                var month = d.getMonth();  
                if(month<=10){  
                    month = "0"+month;  
                }  
                if (d.getMonth() == 0) {    
                    return d.getFullYear()-1 + '-' + 12;    
                } else {    
                    return d.getFullYear() + '-' + month;    
                }    
            }// 配置formatter，只返回年月    
        });    
        var p = $('#datetime1').datebox('panel'), // 日期选择对象    
        tds = false, // 日期选择对象中月份    
        span = p.find('span.calendar-text'); // 显示月份层的触发控件    
        
    });    
		
		$(function() {      
      		$('#datetime11').datebox({    
           		 onShowPanel : function() {// 显示日趋选择对象后再触发弹出月份层的事件，初始化时没有生成月份层    
                	span.trigger('click'); // 触发click事件弹出月份层    
                if (!tds)    
                    setTimeout(function() {// 延时触发获取月份对象，因为上面的事件触发和对象生成有时间间隔    
                        tds = p.find('div.calendar-menu-month-inner td');    
                        tds.click(function(e) {    
                            e.stopPropagation(); // 禁止冒泡执行easyui给月份绑定的事件    
                            var year = /\d{4}/.exec(span.html())[0]// 得到年份    
                            , month = parseInt($(this).attr('abbr'), 10) + 1; // 月份    
                            $('#datetime11').datebox('hidePanel')// 隐藏日期对象    
                            .datebox('setValue', year + '-' + month); // 设置日期的值    
                        });    
                    }, 0);    
            },    
            parser : function(s) {// 配置parser，返回选择的日期    
                if (!s)    
                    return new Date();    
                var arr = s.split('-');    
                return new Date(parseInt(arr[0], 10), parseInt(arr[1], 10) - 1, 1);    
            },    
            formatter : function(d) {    
                var month = d.getMonth();  
                if(month<=10){  
                    month = "0"+month;  
                }  
                if (d.getMonth() == 0) {    
                    return d.getFullYear()-1 + '-' + 12;    
                } else {    
                    return d.getFullYear() + '-' + month;    
                }    
            }// 配置formatter，只返回年月    
        });    
        var p = $('#datetime11').datebox('panel'), // 日期选择对象    
        tds = false, // 日期选择对象中月份    
        span = p.find('span.calendar-text'); // 显示月份层的触发控件    
        
    });  
  
		/* 验证函数 */
		$.extend($.fn.validatebox.defaults.rules, {
			maxLength : {
				validator : function(value, param) {
					return value.length <= param[0];
				},
				message : '输入内容长度必须不大于{0}'
			},
			number : {
				validator : function(value) {
					return /^\d+$/.test(value);
				},
				message : '输入内容必须为数字'
			},
		});
	</script>

</div>
