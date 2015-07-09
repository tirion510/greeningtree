<#macro table table>
	<#if table??>
		<#if !table.sortOrder?? || table.sortOrder == "">
			<#local table = table + {"sortOrder":"asc"}>
		</#if>
		<#local n_sortables=[]>
		<#if !table.disableSortable>
			<#list table.columnList as column>
				<#if !column.sortable>
					<#local n_sortables = n_sortables + [column_index]>
				</#if>
			</#list>
		</#if>
		<#local columndefs=[]>
		<#if (n_sortables?size>0)>
			<#local string="">
			<#list n_sortables as n_sortable>
				<#local string=string+n_sortable>
				<#if n_sortable_has_next>
					<#local string=string+",">
				</#if>
			</#list>
			<#local sortables_attrs="\"bSortable\": false,\"aTargets\": [${string}]">
			<#local columndefs=columndefs+[sortables_attrs]>
		</#if>
		<#list table.columnList as column>
			<#if column.specialSortType??>
				<#local columndefs=columndefs+["\"type\": \"${column.specialSortType}\",\"targets\":${column_index}"]>
			</#if>
		</#list>
		<#local sortables_attrs="">
		<#if (columndefs?size>0)>
			<#local string="">
			<#list columndefs as columndef>
				<#local string=string+columndef>
				<#if columndef_has_next>
					<#local string=string+",">
				</#if>
			</#list>
			<#local sortables_attrs="\"aoColumnDefs\": [${string}],">
		</#if>
		<#local default_order="">
		<#if (table.sortColumn >= 0)>
			<#local default_order="\"order\": [[ ${table.sortColumn}, \"${table.sortOrder}\" ]],">
		<#else>
			<#local default_order="\"order\": [],">
		</#if>
		<#local table_name="dataTable${table.id}">
		<#local script="">
		<#if table.fullData && table.pagination>
			<#local script="
				\lscript type=\"text/javascript\"\g
				var ${table_name};
				$(function() {
					${table_name} = $(\"#${table.id}\").DataTable({
		        \"stateSave\": false,
		        \"bLengthChange\": false,
		        \"displayLength\": 30,
		        \"bAutoWidth\": false,
		        ${default_order}
						${sortables_attrs}
		        \"fnDrawCallback\": function () {
		          this.autoalign();
		        }
	    		});
				});
				\l/script\g
				">
		<#else>
			<#local script="
				\lscript type=\"text/javascript\"\g
				var ${table_name};
				 $(function() {
					 ${table_name} = $(\"#${table.id}\").DataTable({
				        \"stateSave\": false,
				        \"bLengthChange\": false,
				        \"info\": false,
				        \"bAutoWidth\": false,
				        ${default_order}
						\"paging\": false,
						${sortables_attrs}
			        	\"fnDrawCallback\": function () {
			          		this.autoalign();
			        	}
	    			});
				});
				\l/script\g
			">
		</#if>
		${script}
		<#if table.globalTableSearchId??>
			<script type="text/javascript">
				function filter_table_content() {
				    dataTabletbl_p_list.search(
				        $("#${table.globalTableSearchId}").val(),
				        true,
				        true
				    ).draw();
				}
				$(document).ready(function(){
					$("#${table.globalTableSearchId}").on('keyup click', function(){
					    filter_table_content();
					}).blur();
				});
			</script>
		</#if>
		<#local width = "">
		<#if table.widthAuto>
			<#local width = "width=\"100%\"">
		</#if>
		<#if table.export>
			<#if table.parameterInfo??>
				<@export_html parameter_info=table.parameterInfo></@export_html>
			<#else>
				<@export_html parameter_info={}></@export_html>
			</#if>
		</#if>
		<table id="${table.id}" ${width} cellspacing="1" cellpadding="3" border="0" bgcolor="#cccccc" class="dataTable" not_need_summary="${table.notNeedSummary}">
			<#if table.columnList?? && (table.columnList?size>0)>
				<@thead_html colums_ref = table.columnList></@thead_html>
			</#if>
			<@body_html></@body_html>
			<@foot_html remove_tfoot_html=table.removeTfootHtml tfoot_html=table.tfootHtml></@foot_html>
		</table>
	</#if>
</#macro>

<#macro thead_html colums_ref>
	<#if colums_ref?? && (colums_ref?size>0)>
		<#local colums=colums_ref>
		<#local is_double_line=false>
		<#local first_line_hash={} colum_hash={}>
		<#list colums as colum>
			<#local colum_hash=colum_hash+{colum.name:colum}>
			<#if colum.caption??>
				<#local is_double_line=true>
			</#if>
		</#list>
		<#local first_tr="" second_tr="" first_line=[]>
		<#list colums as colum>
			<#if is_double_line>
				<#local caption=colum.caption>
				<#if caption??>
					<#if first_line_hash?keys?seq_contains(caption.name)>
						<#local first_line=first_line+[colum.caption]>
					</#if>
					<#local count=0>
					<#if first_line_hash?keys?seq_contains(caption.name)>
						<#local count=first_line_hash[caption.name]>
					</#if>
					<#local count=count+1>
					<#local first_line_hash=first_line_hash+{caption.name:count}>
					<#local second_tr=second_tr+"\lth width=\"${colum.width}\" data_type=\"${colum.data_type}\" title=\"${colum.title}\"\g${colum.name}\l/th\g">
				<#else>
					<#local caption={"name":colum.name,"title":colum.title}>
					<#local first_line=first_line+[caption]>
				</#if>
			<#else>
				<#local second_tr=second_tr+"\lth width=\"${colum.width}\" data_type=\"${colum.data_type}\" title=\"${colum.title}\"\g${colum.name}\l/th\g">
			</#if>
		</#list>
		<#list first_line as cap>
			<#local col=first_line_hash[cap.name]>
			<#if (col>0)>
				<#local first_tr=first_tr+"\lth colspan=\"${col}\" title=\"${cap.title}\"\g${cap.name}\l/th\g">
			<#else>
				<#local colum=colum_hash[cap.name]>
				<#local first_tr=first_tr+"\lth rowspan=\"2\" width=\"${colum.width}\" data_type=\"${colum.data_type}\" title=\"${colum.title}\"\g${colum.name}\l/th\g">
			</#if>
		</#list>
		<#if first_tr!="">
			<#local first_tr="\ltr\g${first_tr}\l/tr\g">
		</#if>
		<#if second_tr!="">
			<#local second_tr="\ltr\g${second_tr}\l/tr\g">
		</#if>
		<thead>
			${first_tr}
			${second_tr}
		</thead>
	</#if>
</#macro>

<#macro body_html tbody_html>
	<tbody>
		${tbody_html}
	</tbody>
</#macro>

<#macro foot_html remove_tfoot_html tfoot_html>
	<#if !remove_tfoot_html>
		<tfoot>
		<#if tfoot_html??>
			${tfoot_html}
		</#if>
		</tfoot>
	</#if>
</#macro>

<#macro export_html parameter_info>
	<div style="float:right;padding-bottom:2px">
		<form method="post">
		<input type="hidden" name="export_excel" value="1">
			<#list parameter_info?keys as key>
				<input type="hidden" name="${key}" value="${parameter_info[key]}">
			</#list>
			<@form_ui.button display="Export to Excel" reference=1>
			</@form_ui.button>
		</form>
	</div>
</#macro>