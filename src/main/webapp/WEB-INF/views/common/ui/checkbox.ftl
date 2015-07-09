<#--
Example:
	<#assign checkboxmap=[{"value":"1","text":"c4","event_html":"","attrs_html":""},{"value":"2","text":"c2","is_checked":true,"event_html":"","attrs_html":""},{"value":"3","text":"c3","is_checked":false,"event_html":"","attrs_html":""},{"value":"4","text":"c6","is_checked":false,"event_html":"","attrs_html":""},{"value":"5","text":"c7","is_checked":false,"event_html":"","attrs_html":""},{"value":"6","text":"c1","is_checked":false,"event_html":"","attrs_html":""}]>
    <@form_ui.checkbox map=checkboxmap name="testcheckbox" single=false>
    </@form_ui.checkbox>
    
    <@form_ui.checkbox name="testSingleCheckbox" value="xxx" text="testSingleCheckbox" style="" event_html="" single=true>
    </@form_ui.checkbox>
-->
<#macro checkbox name value text style event_html map single>
	<#if single>
		<#local checked="">
		<#if value?exists>
			<#local checked="checked='checked'">
		<#else>
		</#if>
		<div class="ckgroup">
			<input moderncheckbox="modern_checkbox" ${checked} type="checkbox" ${style} ${event_html} inputName="${name}"/><span class="spaceR15">${text}</span>
			<input type="hidden" name="${name}" value="${value}" old_value="${value}"/>
		</div>
	<#else>
		<#if map?exists>
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
					<div class="floatL ckcheck">
						<input type="checkbox" ${ch_checked} name="${name}" value="${ch_value}" ${ch_event_html} ${ch_attrs_html}>
						<span class="spaceR15">${ch_text}</span>
					</div>
				</#list>	
			</div>
		</#if>
	</#if>
</#macro>