<#--
Example:
<@form_ui.button id="testbutton" name="testbutton" reference=12 display="Search"></@form_ui.button>
-->
<#macro button id name reference display event_html>
	<#local button_class="">
	<#if reference?exists>
	<#switch reference>
		<#case 1><#local button_class="sbutt_gray sbutt_s"><#break>
		<#case 2><#local button_class="sbutt_gray sbutt_m"><#break>
		<#case 3><#local button_class="sbutt_gray sbutt_l"><#break>
		<#case 4><#local button_class="sbutt_gray sbutt_h"><#break>
		<#case 5><#local button_class="sbutt_blue sbutt_s"><#break>
		<#case 6><#local button_class="sbutt_blue sbutt_m"><#break>
		<#case 7><#local button_class="sbutt_blue sbutt_l"><#break>
		<#case 8><#local button_class="sbutt_blue sbutt_h"><#break>
		<#case 9><#local button_class="sbutt_orange sbutt_s"><#break>
		<#case 10><#local button_class="sbutt_orange sbutt_m"><#break>
		<#case 11><#local button_class="sbutt_orange sbutt_l"><#break>
		<#case 12><#local button_class="sbutt_orange sbutt_h"><#break>
		<#case 13><#local button_class="sbutt_disable sbutt_s"><#break>
		<#case 14><#local button_class="sbutt_disable sbutt_m"><#break>
		<#case 15><#local button_class="sbutt_disable sbutt_l"><#break>
		<#case 16><#local button_class="sbutt_disable sbutt_h"><#break>
	</#switch>
	</#if>
	<input type="button" value="${display}" name="${name}" id="${id}" class="${button_class}" ${event_html}/>
</#macro>