<#macro date_range_selector start_date end_date search_by_bar extra_name>
	<#local today>
		${.now?string("yyyy-MM-dd")}
	</#local>
	<#local yesterday>
		${(.now?long?number-86400000)?number_to_date?string("yyyy-MM-dd")}
	</#local>
	<#local extra_name=extra_name/>
	<#local random_number="${texts}"/>
	<#local id="${random_number}date_range_start"/>
	<#local extra_html="class='date_range_start'"/>
	<#local style_html="style='width:85px;'"/>
	<#local constrain_input="false"/>
	<#local start_date_html><@date_pick name="${extra_name}date_range_start" value=start_date id=id style_html=style_html extra_html=extra_html constrain_input=constrain_input/></#local>
	
	<#local id="${random_number}date_range_end"/>
	<#local extra_html="class='date_range_end'"/>
	<#local style_html="style='width:85px;'"/>
	<#local constrain_input="false"/>
	<#local end_date_html><@date_pick name="${extra_name}date_range_end" value=end_date id=id style_html=style_html extra_html=extra_html constrain_input=constrain_input/></#local>
	
	<#local search_by_bar="${search_by_bar}"/>
	<#local date_range_selectors={}/>
	<#if is_agency_website=="1">
		<#local date_range_selectors={"1":"Custom","2":"Today","3":"Yesterday","5":"This Week (Sun - Today)","6":"This Week (Mon - Today)","13":"This Month","19":"Last 180 days","20":"Today & Last 180 days"}/>
	<#else>	
		<#local date_range_selectors={"1":"Custom","2":"Today","3":"Yesterday","4":"Yesterday $ Today","5":"This Week (Sun-Today)","6":"This Week (Mon - Today)","7":"Last 7 days","8":"Today & Last 7 days","9":"Last Week (Sun - Sat)","10":"Last Week (Mon - Sun)","11":"Last 14 days","12":"Today & Last 14 days","13":"This Month","14":"Last Month","15":"Last 30 days","16":"Today & Last 30 days","17":"Last 90 days","18":"Today & Last 90 days","19":"Last 180 days","20":"Today & Last 180 days"}/>
	</#if>
	<#local search_by=date_range_selectors[search_by_bar]/>
	<#local lan_to="to"/>
	<#if search_by_bar==1>
		<#local search_by=start_date+"${lan_to}"+end_date/>
	</#if>
	<#if (search_by_bar==2||search_by_bar==3)&& start_date>
		<#local search_by=search_by+' '+start_date/>
	</#if>
	<#local name="${extra_name}searchByBar"/>
	<div class="dateScopeS" style=" width:200px;">
		<span class="dateScopeC">${search_by}</span>
		<input type="hidden" id="searchByBar" name="${name}" value="${search_by_bar}"/>
		<div class="standardDilogBox" style=" max-height: 450px;top: 20px;">
			<ul class="no_list_style" style="">
				<#list date_range_selectors?keys as k>
					<#local seletor=date_range_selectors[k]/>
					<#local style_html=""/>
					<#if k==search_by_bar>
						<#local style_html="style='display:block;'"/>
					</#if>
					<#if k==1>
						<li class="date_custom">
							<div class="n_standardCheckbox">
								<div class="n_checkActive" ${style_html}></div>
							</div>
							<span class="spaceL5" seletor_tag="${k}">${seletor}</span>
							<span class="chooseDate" >
								${start_date_html}<span style="margin:0 5px">-</span>${end_date_html}
								<a class="standardBut_GrayLow standardButtonCustom spaceL10" href="javascript:void(0);" ><span>Go</span> </a>
							</span>
						</li>
					<#elseif k==2>
						<li>
							<div class="n_standardCheckbox">
								<div class="n_checkActive" ${style_html}></div>
							</div>
							<span class="spaceL5" seletor_tag="${k}" n_date="${today}">${seletor}</span>
						</li>
					<#elseif k==3>
						<li>
							<div class="n_standardCheckbox">
								<div class="n_checkActive" ${style_html}></div>
							</div>
							<span class="spaceL5" seletor_tag="${k}" n_date="${yesterday}">${seletor}</span>
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
			</ul>
		</div>
		<input type="hidden" id="search_by" value="${search_by}"/>
	</div>
</#macro>

<#macro get_date_pick_js element id constrain_input>
	<#local id=id/>
	<#local button_image=button_image/>
	<#local buttin_image_only=button_image_only/>
	<#local change_text=change_text/>
	<#local change_month=change_month/>
	<#local change_year=change_year/>
	<#local constrain_input=false/>
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
	<#if button_image?exists>
		<#local date_pick_js="buttonImage:'${button_image}'"/>
	</#if>
	<#if button_image_only?exists>
		<#if date_pick_js=="">
			<#local date_pick_js="${date_pick_js},\n"/>
		</#if>
		<#local date_pick_js="${date_pick_js}buttonImageOnly: ${button_image_only}"/>
	</#if>
	<#if button_text?exists>
		<#if date_pick_js=="">
			<#local date_pick_js="${date_pick_js},\n"/>
		</#if>
		<#local date_pick_js="${date_pick_js}buttonText: '${button_text}'"/>
	</#if>
	<#if change_month?exists>
		<#if date_pick_js=="">
			<#local date_pick_js="${date_pick_js},\n"/>
		</#if>
		<#local date_pick_js="${date_pick_js}changeMonth: ${change_month}"/>
	</#if>
	<#if change_year?exists>
		<#if date_pick_js=="">
			<#local date_pick_js="${date_pick_js},\n"/>
		</#if>
		<#local date_pick_js="${date_pick_js}changeYear: ${change_year}"/>
	</#if>
	<#if constrain_input?exists>
		<#if date_pick_js=="">
			<#local date_pick_js="${date_pick_js},\n"/>
		</#if>
		<#local date_pick_js="${date_pick_js}constrainInput: ${constrain_input}"/>
	</#if>
	<#if date_format?exists>
		<#if date_pick_js=="">
			<#local date_pick_js="${date_pick_js},\n"/>
		</#if>
		<#local date_pick_js="${date_pick_js}dateFormat: '${date_format}'"/>
	</#if>
	<#if duration?exists>
		<#if date_pick_js=="">
			<#local date_pick_js="${date_pick_js},\n"/>
		</#if>
		<#local date_pick_js="${date_pick_js}duration: '${duration}'"/>
	</#if>
	<#if number_of_months?exists>
		<#if date_pick_js=="">
			<#local date_pick_js="${date_pick_js},\n"/>
		</#if>
		<#local date_pick_js="${date_pick_js}numberOfMonths: ${number_of_months}"/>
	</#if>
	<#if show_anim?exists>
		<#if date_pick_js=="">
			<#local date_pick_js="${date_pick_js},\n"/>
		</#if>
		<#local date_pick_js="${date_pick_js}showAnim: '${show_anim}'"/>
	</#if>
	<#if show_button_panel?exists>
		<#if date_pick_js=="">
			<#local date_pick_js="${date_pick_js},\n"/>
		</#if>
		<#local date_pick_js="${date_pick_js}showButtonpanel: ${show_button_panel}"/>
	</#if>
	<#if show_on?exists>
		<#if date_pick_js=="">
			<#local date_pick_js="${date_pick_js},\n"/>
		</#if>
		<#local date_pick_js="${date_pick_js}showOn: '${show_on}'"/>
	</#if>
	<#if on_select?exists>
		<#if date_pick_js=="">
			<#local date_pick_js="${date_pick_js},\n"/>
		</#if>
		<#local date_pick_js="${date_pick_js}onSelect: ${on_select}"/>
	</#if>
	<#if before_show?exists>
		<#if date_pick_js=="">
			<#local date_pick_js="${date_pick_js},\n"/>
		</#if>
		<#local date_pick_js="${date_pick_js}beforeShow: ${before_show}"/>
	</#if>
	<#if before_show_day?exists>
		<#if date_pick_js=="">
			<#local date_pick_js="${date_pick_js},\n"/>
		</#if>
		<#local date_pick_js="${date_pick_js}beforeShowDay: ${before_show_day}"/>
	</#if>
	<#if min_date?exists>
		<#if date_pick_js=="">
			<#local date_pick_js="${date_pick_js},\n"/>
		</#if>
		<#local date_pick_js="${date_pick_js}minDate: ${min_date}"/>
	</#if>
	<#if max_date==null||max_date=="">
		<#local max_date="new Date(2100,11,12)"/>
	</#if>
	<#if date_pick_js=="">
		<#local date_pick_js="${date_pick_js},\n"/>
	</#if>
	<#local date_pick_js="${date_pick_js}maxDate: ${max_date}"/>
	<#if element?exists>
		<#local date_pick_js="$(\"${element}\").not(\".hasDatepicker\")datepick({${date_pick_js}});"/>
	<#else>
		<#local date_pick_js="var obj=document.getElementById(\"${id}\");$(obj).not(\".hasDatepicker\")datepick({${date_pick_js}});"/>
	</#if>
	${date_pick_js}
</#macro>