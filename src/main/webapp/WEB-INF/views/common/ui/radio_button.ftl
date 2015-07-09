<#--
Example:
	<#assign map={"1":"1212","2":"asdf","3":"werqwr","4":"121qwerqwe221","5":"121qwer23221","6":"2341431","7":"hdfghdgh","8":"retwtwertwert","9":"dfgdsg","10":"wertewt","11":"gjfgjjhg","12":"dsfgsdg","13":"ghjkghjk","14":"ewqwre","15":"ffgsdfg","16":"sfdgsdfgdfs"}>
	<@form_ui.radio_button map=map name="testradiobutton" value="2">
	</@form_ui.radio_button>
-->
<#macro radio_button name value map event_html readonly>
	<#if map?exists>
		<#local attrs_html="">
		<#if readonly><#local attrs_html="readonly='readonly'"></#if>
		<ul class="editDest_Pier no_list_style" modern="modern" inputName="${name}" ${attrs_html}>
		<#list map?keys as key>
			<#local checked="">
			<#if value?exists && value==key>
				<#local checked="class='destActive'">
			</#if>
			<li ${checked} value="${key}" li_value="${key}" ${event_html}>${map[key]}</li>
		</#list>
		</ul>
		<input type="hidden" name="${name}" value="${value}" old_value="${value}"/>
	</#if>
</#macro>