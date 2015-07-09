<#--
Example:
<@form_ui.radio map=map name="testradio" value="3"></@form_ui.radio>
-->
<#macro radio name value map event_html readonly>
	<#if map?exists>
		<#local attrs_html="">
		<#if readonly><#local attrs_html="readonly='readonly'"></#if>
		<div class="clearfix">
		<#list map?keys as key>
			<#local checked="">
			<#if value?exists && value==key>
				<#local checked="checked='checked'">
			</#if>
			<div class="floatL ckcheck">
				<input type="radio" name="${name}" value="${key}" ${checked} ${event_html} ${attrs_html}>
				<span class="spaceR15">${map[key]}</span>
			</div>
		</#list>
		</div>
	</#if>
</#macro>