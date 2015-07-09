<#macro date_pick name value id style_html event_html extra_html constrain_input>
	<#local date_pick_js><@get_date_pick_js constrain_input=constrain_input id=id/></#local>
	<#local date_pick_js>
		$(function(){${date_pick_js}});
	</#local>
	<#local input_html>
		<#local style_html=style_html/>
		<#local event_html=event_html/>
		<#local extra_html=extra_html/>
		<#local name=name/>
		<#local id=id/>
		<#local value=value/>
		<input name="${name}" id="${id}" type="text" value="${value}" ${style_html} ${event_html} ${extra_html}>
	</#local>
		${input_html}
		<script type="text/javascript">
		${date_pick_js}
		</script>
</#macro>

<#macro get_date_pick_js element constrain_input id>
	<#local id=id/>
	<#local button_image=button_image/>
	<#local buttin_image_only=button_image_only/>
	<#local change_text=change_text/>
	<#local change_month=change_month/>
	<#local change_year=change_year/>
	<#local constrain_input=constrain_input/>
	<#local date_format=date_format/>
	<#local duration=duration/>
	<#local number_of_months=number_of_months/>
	<#local show_anim=show_anim/>
	<#local show_button_panel=show_button_panel/>
	<#local show_on=show_on/>
	<#local on_select=on_select/>
	<#local before_show=before_show/>
	<#local before_show_day=before_show_day/>
	<#local min_date=min_date/>
	<#local max_date=max_date/>
	<#local show_anim=show_anim/>
	<#local show_anim=show_anim/>
	<#local show_anim=show_anim/>
	<#local date_pick_js=""/>
	<#if button_image?if_exists>
		<#local date_pick_js="buttonImage:'${button_image}'"/>
	</#if>
	<#if button_image_only?if_exists>
		<#if date_pick_js=="">
			<#local date_pick_js="\n"/>
		</#if>
		<#local date_pick_js="${date_pick_js}buttonImageOnly: ${button_image_only}"/>
	</#if>
	<#if button_text?if_exists>
		<#if date_pick_js=="">
			<#local date_pick_js="${date_pick_js}\n"/>
		</#if>
		<#local date_pick_js="${date_pick_js}buttonText: '${button_text}'"/>
	</#if>
	<#if change_month?if_exists>
		<#if date_pick_js=="">
			<#local date_pick_js="${date_pick_js}\n"/>
		</#if>
		<#local date_pick_js="${date_pick_js}changeMonth: ${change_month}"/>
	</#if>
	<#if change_year?if_exists>
		<#if date_pick_js=="">
			<#local date_pick_js="${date_pick_js}\n"/>
		</#if>
		<#local date_pick_js="${date_pick_js}changeYear: ${change_year}"/>
	</#if>
	<#if constrain_input?if_exists>
		<#if date_pick_js=="">
			<#local date_pick_js="${date_pick_js}\n"/>
		</#if>
		<#local date_pick_js="${date_pick_js}constrainInput: ${constrain_input},\n"/>
	</#if>
	<#if date_format?if_exists>
		<#if date_pick_js=="">
			<#local date_pick_js="${date_pick_js}\n"/>
		</#if>
		<#local date_pick_js="${date_pick_js}dateFormat: '${date_format}'"/>
	</#if>
	<#if duration?if_exists>
		<#if date_pick_js=="">
			<#local date_pick_js="${date_pick_js}\n"/>
		</#if>
		<#local date_pick_js="${date_pick_js}duration: '${duration}'"/>
	</#if>
	<#if number_of_months?if_exists>
		<#if date_pick_js=="">
			<#local date_pick_js="${date_pick_js}\n"/>
		</#if>
		<#local date_pick_js="${date_pick_js}numberOfMonths: ${number_of_months}"/>
	</#if>
	<#if show_anim?if_exists>
		<#if date_pick_js=="">
			<#local date_pick_js="${date_pick_js}\n"/>
		</#if>
		<#local date_pick_js="${date_pick_js}showAnim: '${show_anim}'"/>
	</#if>
	<#if show_button_panel?if_exists>
		<#if date_pick_js=="">
			<#local date_pick_js="${date_pick_js}\n"/>
		</#if>
		<#local date_pick_js="${date_pick_js}showButtonpanel: ${show_button_panel}"/>
	</#if>
	<#if show_on?if_exists>
		<#if date_pick_js=="">
			<#local date_pick_js="${date_pick_js}\n"/>
		</#if>
		<#local date_pick_js="${date_pick_js}showOn: '${show_on}'"/>
	</#if>
	<#if on_select?if_exists>
		<#if date_pick_js=="">
			<#local date_pick_js="${date_pick_js}\n"/>
		</#if>
		<#local date_pick_js="${date_pick_js}onSelect: ${on_select}"/>
	</#if>
	<#if before_show?if_exists>
		<#if date_pick_js=="">
			<#local date_pick_js="${date_pick_js}\n"/>
		</#if>
		<#local date_pick_js="${date_pick_js}beforeShow: ${before_show}"/>
	</#if>
	<#if before_show_day?if_exists>
		<#if date_pick_js=="">
			<#local date_pick_js="${date_pick_js}\n"/>
		</#if>
		<#local date_pick_js="${date_pick_js}beforeShowDay: ${before_show_day}"/>
	</#if>
	<#if min_date?if_exists>
		<#if date_pick_js=="">
			<#local date_pick_js="${date_pick_js}\n"/>
		</#if>
		<#local date_pick_js="${date_pick_js}minDate: ${min_date}"/>
	</#if>
	<#if max_date==null||max_date=="">
		<#local max_date="new Date(2100,11,12)"/>
	</#if>
	<#if date_pick_js=="">
		<#local date_pick_js="${date_pick_js}\n"/>
	</#if>
	<#local date_pick_js="${date_pick_js}maxDate: ${max_date}"/>
	<#if element?exists>
		<#local date_pick_js="$(\"${element}\").not(\".hasDatepicker\").datepick({${date_pick_js}});"/>
	<#else>
		<#local date_pick_js="var obj=document.getElementById(\"${id}\");$(obj).not(\".hasDatepicker\").datepick({${date_pick_js}});"/>
	</#if>
	${date_pick_js}
</#macro>