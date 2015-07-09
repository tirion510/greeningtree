<#--
Example:
	<#assign checkboxmap=[{"value":"1","text":"c4","is_checked":false,"event_html":"","attrs_html":""},{"value":"2","text":"c2","is_checked":true,"event_html":"","attrs_html":""},{"value":"3","text":"c3","is_checked":false,"event_html":"","attrs_html":""},{"value":"4","text":"c6","is_checked":false,"event_html":"","attrs_html":""},{"value":"5","text":"c7","is_checked":false,"event_html":"","attrs_html":""},{"value":"6","text":"c1","is_checked":false,"event_html":"","attrs_html":""}]>
    <@form_ui.checkbox_group map=checkboxmap column_count=2 name="testcheckboxgroup">
    </@form_ui.checkbox_group>
-->
<#macro checkbox_group map name column_count>
	<#if map?exists>
		<#local width=((100/column_count)?int)+"%">
		<#if (map?size<(column_count*2))>
			<@form_ui.common_checkbox map=map name="${name}" single=false>
    		</@form_ui.common_checkbox>
    	<#else>
    		<div class="clearfix">
    			<#local sortmap=map>
    			<#if (map?size>5)>
    				<#local sortmap=map?sort_by("text")>
    			</#if>
    			<#list sortmap as checkbox>
    				<#local ch_checked="" ch_value=(checkbox.value!"") ch_text=(checkbox.text!"") ch_event_html=(checkbox.event_html!"") ch_attrs_html=(checkbox.attrs_html!"")>
					<#if checkbox.is_checked>
						<#local ch_checked="checked='checked'">
					</#if>
					<div class="floatL ckgroup" style="width:${width}">
						<input type="checkbox" ${ch_checked} name="${name}" value="${ch_value}" ${ch_event_html} ${ch_attrs_html}>
						<span class="spaceR15">${ch_text}</span>
					</div>
				</#list>
    		</div>
		</#if>
	</#if>
</#macro>