<%@ page language="java" pageEncoding="UTF-8"%>

<style type="text/css">
.tg {
	border-collapse: collapse;
	border-spacing: 0;
	margin: 0px auto;
}

.tg td {
	font-family: Arial, sans-serif;
	font-size: 14px;
	padding: 8px 5px;
	border-style: solid;
	border-width: 1px;
	overflow: hidden;
	word-break: normal;
}

.tg th {
	font-family: Arial, sans-serif;
	font-size: 14px;
	font-weight: normal;
	padding: 8px 5px;
	border-style: solid;
	border-width: 1px;
	overflow: hidden;
	word-break: normal;
}
</style>

<div id="traffic_panel" class="easyui-panel"
	data-options="fit:true,border:false">

	<p class="zooqi-head-text"
		style="margin-top: 20px; text-align: center;">车流管理</p>

	<div style="margin: 20px 30px auto 30px;">
		<table id="traffic_datagrid"></table>

		<!-- 工具栏按钮 -->
		<div id="traffic_toolbar">
			<a id="traffic_reload" href="javascript:void(0)"
				class="easyui-linkbutton"
				data-options="iconCls:'icon-reload',plain:true">显示所有</a> <a
				id="traffic_edit" href="javascript:void(0)"
				class="easyui-linkbutton"
				data-options="iconCls:'icon-edit',plain:true">编辑</a> <a
				id="traffic_delete" href="javascript:void(0)"
				class="easyui-linkbutton"
				data-options="iconCls:'icon-remove',plain:true">删除</a> <a
				id="traffic_search" href="javascript:void(0)"
				class="easyui-linkbutton"
				data-options="iconCls:'icon-search',plain:true">搜索</a>
		</div>
	</div>

	<!-- Dialog -->
	<div id="traffic_dlg" class="easyui-dialog"
		data-options="closed:true,buttons:'#traffic_dlg-buttons'">
		<form id="traffic_fm"></form>
	</div>
	<div id="traffic_dlg-buttons">
		<a id="traffic_update_button" href="javascript:void(0)"
			class="easyui-linkbutton c6" data-options="iconCls:'icon-ok'"
			style="width: 90px">保存</a> <a href="javascript:void(0)"
			class="easyui-linkbutton" data-options="iconCls:'icon-cancel'"
			onclick="javascript:$('#traffic_dlg').dialog('close');"
			style="width: 90px">取消</a>
	</div>

	<script type="text/javascript">
		$('#traffic_datagrid').datagrid({
			url : 'trafficReach',
			fitColumns : true,
			singleSelect : true,
			pagination : true,
			rownumbers : true,
			toolbar : '#traffic_toolbar',
			remoteSort : false,

			columns : [ [ {
				field : 'logId',
				hidden : true
			}, {
				title : '合同编号',
				field : 'logContractNum',
				align : 'center',
				sortable : true,
				width : 100
			}, {
				title : '车流类型',
				field : 'logType',
				align : 'center',
				sortable : true,
				width : 100,
				formatter : function(value, row, index) {
					switch (row.logType) {
					case 0:
						return '发车';
					case 1:
						return '到车';
					default:
						return value;
					}
				}
			}, {
				title : '发车日期',
				field : 'logSendDate',
				align : 'center',
				sortable : true,
				width : 100
			}, {
				title : '起点',
				field : 'logSiteStart',
				align : 'center',
				sortable : true,
				width : 100
			}, {
				title : '终点',
				field : 'logSiteEnd',
				align : 'center',
				sortable : true,
				width : 100
			}, {
				title : '车牌号',
				field : 'logCarLicense',
				align : 'center',
				sortable : true,
				width : 100
			}, {
				title : '司机',
				field : 'logCarDriver',
				align : 'center',
				sortable : true,
				width : 100
			}, {
				title : '司机电话',
				field : 'logCarPhone',
				align : 'center',
				sortable : true,
				width : 100
			}, {
				title : '车费',
				field : 'logCarPay',
				align : 'center',
				sortable : true,
				width : 100
			}, {
				title : '客户',
				field : 'logPartner',
				align : 'center',
				sortable : true,
				width : 150
			} ] ]
		});

		/* 显示所有 */
		$('#traffic_reload').click(function() {
			$('#traffic_panel').panel('refresh', 'traffic.jsp');
		});

		var url;
		/* 弹出编辑对话框 */
		$('#traffic_edit').click(function() {
			var row = $('#traffic_datagrid').datagrid('getSelected');
			if (row) {
				$('#traffic_dlg').dialog('open').dialog('setTitle', '编辑');
				$('#traffic_fm').form('clear');
				$('#traffic_fm').form('load', row);
				url = 'trafficUpdate?logId=' + row.logId;
			} else {
				$.messager.alert('提示', '请选择数据！');
			}
		});
		/* 保存 */
		$('#traffic_update_button').click(function() {
			if (!$('#traffic_fm').form('validate')) {
				$.messager.alert('提示', '请正确填写信息！');
				return;
			}
			$.messager.confirm('确认', '确认保存吗？', function(r) {
				if (r) {
					$.ajax({
						type : 'POST',
						url : url,
						data : $('#traffic_fm').serialize(),
						success : function(data) {
							if (data.success) {
								$.messager.alert('提示', '保存成功！');
								$('#traffic_dlg').dialog('close');
								$("#traffic_datagrid").datagrid("reload");
							} else {
								$.messager.alert('提示', '保存失败，请稍后再试！');
							}
						},
						error : function(request, error) {
							$.messager.alert('提示', '保存失败，请稍后再试！');
						}
					});
				} else {
					$('#traffic_dlg').dialog('close');
				}
			});
		});

		/* 删除 */
		$('#traffic_delete').click(function() {
			var row = $('#traffic_datagrid').datagrid('getSelected');
			if (row) {
				$.messager.confirm('确认', '确认删除吗？', function(r) {
					if (r) {
						$.ajax({
							type : 'POST',
							url : 'goodsDelete',
							data : {
								goId : row.goId
							},
							success : function(data) {
								if (data.success) {
									$.messager.alert('提示', '删除成功！');
									$("#traffic_datagrid").datagrid("reload");
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

		/* 搜索功能按钮 */
		$('#traffic_search').click(function() {
			$('#traffic_search_dlg').dialog('open').dialog('setTitle', '搜索');
		});
		/* 搜索 */
		$('#traffic_search_button').click(function() {
			if (!$('#traffic_search_fm').form('validate')) {
				$.messager.alert('提示', '请正确填写信息！');
				return;
			}
			$('#traffic_datagrid').datagrid('load', {});
			$('#traffic_search_dlg').dialog('close');
		});
	</script>
</div>