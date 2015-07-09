<#--
<input type="drop_down"/>

Example:
<#assign map={"1":"1212","2":"asdf","3":"werqwr","4":"121qwerqwe221","5":"121qwer23221","6":"2341431","7":"hdfghdgh","8":"retwtwertwert","9":"dfgdsg","10":"wertewt","11":"gjfgjjhg","12":"dsfgsdg","13":"ghjkghjk","14":"ewqwre","15":"ffgsdfg","16":"sfdgsdfgdfs"}>
<@form_ui.drop_down map=map id="test" name="test" disable_sort_by=true need_please_select=true>
</@form_ui.drop_down>  
-->
<#macro drop_down map id name value force_to_select disable_sort_by need_please_select event_html width>
	<#if map?exists>
		<#local size=map?size>
		<#if (size<5) && !force_to_select>
			<#list map?keys as key>
				<#local checked="">
				<#if value?exists && value==key>
					<#local checked="checked='checked'">
				</#if>
				<input type="radio" name="${name}" value="${key}" $checked $event_html/> ${map[key]}
			</#list>
		<#else> 
		    <#if (size>15) && (!(force_to_select?exists) || !force_to_select)>
		    	<#local width_class="">
				<#if width?exists>
					<#local width_class=".width${width}">
					<style type="text/css">
						${width_class} .ui-widget-content{width:${width}px}
					</style>
				</#if>
				<#local margin_style="">
				<#if (size<500) && (!(force_to_select?exists) || !force_to_select)>
					<#local margin_style="margin-right:30px">
				</#if>
		    	<div style="display:inline-block;${margin_style}" class="ivy_combobox ui-widget ${width_class}">
		    	<select combobox="combobox" name="${name}" id="${id}" ${event_html}>
		    <#else>
		    	<select name="${name}" id="${id}" ${event_html}>
		    </#if>
			<#if need_please_select>
				<option value=''>--<@spring.message "pleaseSelect" />--</option>
			</#if>
			<#if disable_sort_by>
				<#list map?keys as key>
					<#local seleted="">
					<#if value?exists && value==key>
						<#local seleted="selected='selected'">
					</#if>
					<option value="${key}" ${seleted}>${map[key]}</option>
				</#list>
			<#else>
				<#-- no finish--->
				<#list map?keys?sort as key>
					<#local seleted="">
					<#if value?exists && value==key>
						<#local seleted="selected='selected'">
					</#if>
					<option value="${key}" ${seleted}>${map[key]}</option>
				</#list>
			</#if>	
			</select>
			
			<#if (size>15) && (!(force_to_select?exists) || !force_to_select)>
				</div>
			</#if>		
		</#if>		
	</#if>
 </#macro>