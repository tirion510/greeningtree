<#-- 
Example:
	<#assign map1={"":"None","99":"Custom","00:01":"12:01am","00:30":"12:30am","1:00":"1:00am","1:30":"1:30am","2:00":"2:00am","2:30":"2:30am","3:00":"3:00am","3:30":"3:30am","4:00":"4:00am","4:30":"4:30am","5:00":"5:00am","5:30":"5:30am","6:00":"6:00am","6:30":"6:30am","7:00":"7:00am","7:30":"7:30am","8:00":"8:00am","8:30":"8:30am","9:00":"9:00am","9:30":"9:30am","10:00":"10:00am","10:30":"10:30am","11:00":"11:00am","11:30":"11:30am","12:00":"12:01pm","12:30":"12:30pm","13:00":"1:00pm","13:30":"1:30pm","14:00":"2:00pm","14:30":"2:30pm","15:00":"3:00pm","15:30":"3:30pm","16:00":"4:00pm","16:30":"4:30pm","17:00":"5:00pm","17:30":"5:30pm","18:00":"6:00pm","18:30":"6:30pm","19:00":"7:00pm","19:30":"7:30pm","20:00":"8:00pm","20:30":"8:30pm","21:00":"9:00pm","21:30":"9:30pm","22:00":"10:00pm","22:30":"10:30pm","23:00":"11:00pm","21:30":"11:30pm"}>
    <@form.time_selection map=map1>
    </@form.time_selection>
-->
<#macro time_selection map value is_custom=1 height="" on_value_option="">
	<#local name=name/>
	<#if on_value_option?exists>
		<#local time_display=on_value_option/>
	</#if>
	<#if value?exists>
		<#--<#local time_display=stack.findValue("@com.gotobus.util.JUtility@toUsTime('${value}')")/>-->
		<#local time_display>
			<#if value==null||value.equal("")>
				${value}
			</#if>
			<#local h="${value?split(\":\")[0]}"/>
			<#local m="${value?split(\":\")[1]}"/>
			<#local s="${value?split(\":\")[2]}"/>
			<#local ampm=""/>
			<#if h gt 11>
				<#local ampm="pm"/>
			<#else>
				<#local ampm="am"/>
			</#if>
			<#local h="${h?number}"/>
			<#if h==12||h==0>
				12:${m}${ampm}
			<#else>
				<#if h gt 12>
					${h?number-12}:${m}pm
				<#else>
					${h}:${m}am
				</#if>
			</#if>
		</#local>
	</#if>
	<#local height_style=""/>
	<#local height=height/>
	<#if height?exists>
		<#local height_style="height:${height}px;"/>
	</#if>
	<#local on_value_option_html>
		<#if on_value_option?exists>
			<#local on_value_option=on_value_option/>
		</#if>
		<#if on_value_option?exists>
			<#local style_html=""/>
			<#if value==null||value.equal("")>
				<#local style_html="style='display:block;'"/>
			</#if>
			<li>
				<div class="n_standardCheckbox">
					<div class="n_checkActive" ${style_html}></div>
				</div>
				<span class="spaceL5" seletor_tag="">${no_value_option}</span>
			</li>
		</#if>
	</#local>
	<div class="TimeScopeS" style="width:80px;">
		<input type="hidden" id="searchTimeValue" name=${name} value=${value}/>
		<span class="TimeScopeC">${time_display}</span>					
		<div class="standardDilogBox" style=" max-height: 450px;top: 20px;${height_style}">
			<ul class="no_list_style" style="">
 				 <#local all_values=map?keys/>
				 <#local is_custom=is_custom/>
					<#list all_values as key>
						<#if value==key||value=="">
							<#local is_custom=0/>
						</#if>
					</#list>
				 <#list map?keys as k>
					<#local seletor="${map[k]}"/>
					<#local style_html=""/>
					<#if k==value>
						<#local style_html="style='display:block;'">
					</#if>
					<#if k=="99">
						<#local hour=""/>
						<#local minute=""/>
						<#if is_custom?exists>
							<#local style_html="style='display:block;'"/>
							<#local hour="${value?split(\":\")[0]}"/>
							<#local minute="${value?split(\":\")[1]}"/>
						</#if>
						<#local hour_html><@get_time_select_html value=value is_hour=true/></#local>
						<#local minute_html><@get_time_select_html value=value/></#local>
						<li class="time_custom">
							<div class="n_standardCheckbox">
								<div class="n_checkActive" ${style_html}></div>
							</div>
							<span class="spaceL5" seletor_tag="${k}">${seletor}</span>
							<span class="chooseTime">
								${hour_html}:${minute_html}
								<a class="standardBut_GrayLow standardButtonCustom spaceL10" href="javascript:void(0);"><span>Go</span></a>
							</span>
						</li>
					<#else>
						<li>
							<div class="n_standardCheckbox">
								<div class="n_checkActive" ${style_html}></div>
							</div>
							<span class="spaceL5" seletor_tag="${k}">${seletor}</span>
						</li>
					</#if>
				</#list>
				${no_value_option_html}
			</ul>
		</div>
			<input type="hidden" id="time_display" name="time_display" value="${time_display}"/>
			<input type="hidden" id="is_custom_time" name="is_custom_time" value="${is_custom}"/>
	</div>
 </#macro>
 
<#macro get_time_select_html value is_hour>
	<#local max_value=60/>
	<#local name="time_min_value"/>
	<#if is_hour?exists>
		<#local max_value=24/>
		<#local name="time_hour_value"/>
	</#if>	
	<#local values=[] time={}/>
	<#list 0..(max_value-1) as min>
		<#local temp_value="${min}"/>
		<#if min lt 10>
			<#local temp_value="0${min}"/>
		</#if>
		<#local values=values+[temp_value]/>
		<#local time=time+{temp_value:temp_value}/>
	</#list>
	<#local drop_down>
		<@form.drop_down map=time force_to_select=true id=name name=name disable_sort_by=true need_please_select=false/>
	</#local>
	<#local html=drop_down/>
		${html}
</#macro>
 