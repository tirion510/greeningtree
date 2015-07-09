<#--
UList

-->
<!--html-->
<#macro list list header_html pop_target_area_html toolbar_html body_html js_html>	
	<#if header_html> ${header_html}<#else><@list_header_html list=list/></#if>
	<#if pop_target_area_html> ${pop_target_area_html}<#else><@list_pop_target_area_html list=list/></#if>
	<#if toolbar_html> ${toolbar_html}<#else><@list_toolbar_html list=list/></#if>
	<#if body_html> ${body_html}<#else><@list_body_html list=list/></#if>
	<#if js_html> ${js_html}<#else><@list_js_html list=list/></#if>
	<input type="hidden" name="is_pagination" value="${list.pagination}"/>
</#macro>
<!--header_html-->
<#macro list_header_html list></#macro>
<!--pop_target_area_html-->
<#macro list_pop_target_area_html list>
	<#local html>
		<#if list && list.actionParams>			
			<#list list.actionParams as action>
				<#if list.targetAreaId && list.targetAreaId != ''>
					<div id="${list.targetAreaId}" class="n_actionCont" style="display: none;">
						${list.targetAreaHtml}
					</div>
				</#if>
			</#list>
		</#if>
	</#local>	
	<#if html != ''>
		<div class="n_actionBox" style="display: none;">
			<a id="colseAction" class="admin_del" title="Close" style="position:absolute; right:8px; top:5px;" href="javascript:void(0)"></a>
			${html}
		</div>	
	</#if>
</#macro>
<!--body_html-->
<#macro list_body_html list></#macro>
<!--js_html-->
<#macro list_js_html list>
	<#local list_table_id='tbl_p_list'/>
	<#if list.table>
		<#local list_table_id="${list.table.id}"/>
	</#if>
	<script type="text/javascript">
		$("document").ready(function(){
		public_filter_execute('${list_table_id}');
	});
	</script>
</#macro>
<!--toolbar_html-->
<#macro list_toolbar_html list selection_html actions_html group_html filter_html sort_by_html label_html search_html expand_collapse_html>
	
	
	<#if expand_collapse_html> ${expand_collapse_html}<#else><@list_expand_collapse_html list=list/></#if>
	<div class="tab_manageBox">
		<#if selection_html> ${selection_html}<#else><@list_selection_html list=list/></#if>
		<#if actions_html> ${actions_html}<#else><@list_actions_html list=list/></#if>
		<#if label_html> ${label_html}<#else><@list_label_html list=list/></#if>
		<#if group_html> ${group_html}<#else><@list_group_html list=list/></#if>
		<#if filter_html> ${filter_html}<#else><@list_filter_html list=list/></#if>
		<#if search_html> ${search_html}<#else><@list_search_html list=list/></#if>
		<#if sort_by_html> ${sort_by_html}<#else><@list_sort_by_html list=list/></#if>
		<div class="clear"></div>
	</div>	
</#macro>
<!--selection_html-->
<#macro list_selection_html list>
	<#if list && list.showSeletion>
		<div style="margin-right:2px;" class="standardSelect">
			<input type="checkbox" class="to_select_all" style="vertical-align:text-bottom; margin-right:7px;">
			<img align="absmiddle" src="/images/arrow_down_small.png">&nbsp;
			<div class="standardDilogBox" style="display: none;">
				<ul class="no_list_style">
					<li class="to_select_all_li">Select All</li>
					<li class="un_select_all_li">Unselect</li>
					<li class="reverse_select_li">Reverse</li>
				</ul>
			</div>
		</div>
	</#if>	
</#macro>

<!--list_actions UListAction-->
<#macro list_actions action>
	<#if action.targetLink && action.targetLink != ''>
			<li>
				<a href="${action.targetLink}" style="text-decoration:none;color:#000000" >${action.name}</a>
			</li>
	<#elseif action.targetEvent && action.targetEvent != ''>
			<li>
				<a href="javascript:void(0)" style="text-decoration:none;color:#000000" onclick="${action.targetEvent}">${action.name}</a>
			</li>
	<#elseif action.targetAreaId && action.targetAreaId != ''>
			<li target_area_id="${action.targetAreaId}" class="action_target">
			${action.name}
			<img align=" absmiddle" src="/images/uitk-popups.gif" style="margin-left:3px;">
			</li>
	</#if>
</#macro>
<!--list_actions_html-->
<#macro list_actions_html list>
	<#local limit_css=""/>
	<#if list && list.soryByWidthLimit>
		<#local limit_css="selectCon"/>
	</#if>
	<#local above_ul_html=""/>
	<#local below_ul_html=""/>	
	<#if list?exists && list.actionParams>			
		<#list list.actionParams as action>
			<#local temp_html><@list_actions action=action/></#local>
			<#if action.targetLink != '' || action.targetEvent != ''>				
				<#local above_ul_html='${temp_html + above_ul_html}'/>
			<#elseif action.targetAreaId != ''>
				<#local below_ul_html='${temp_html + below_ul_html}'/>
			</#if>
		</#list>
	</#if>
	<div class="standardSelect" style="margin-right:2px;"><span class="${limit_css}">Actions</span> <img align="absmiddle" src="/images/arrow_down_small.png">&nbsp;
		<div style="display: none;" class="standardDilogBox">
			<#if above_ul_html != ''>
				<ul class="no_list_style" style="padding-bottom:10px;">
					${above_ul_html}
				</ul>
			</#if>
			<#if below_ul_html != ''>
				<ul class="no_list_style" style=" border-top: 1px solid #dedede; padding:10px 0;">
					${below_ul_html}
				</ul>
			</#if>
		</div>
	</div>
</#macro>
<!--group_html-->
<#macro list_group_html list></#macro>

<#macro list_filters filter>
	<#local span_class_name="${filter.filterAttr}_filter_span"/>
	<#local span_class_name_text="${filter.filterAttr}_filter_span_text"/>
	<#local filter_handler><#if filter.filterHandler?exists && filter.filterHandler != ''>${filter.filterHandler}<#else>public_filter(this);</#if></#local>
	<#local filter_event><#if filter.filterEvent?exists && filter.filterEvent != ''>${filter.filterEvent}<#else>onclick="${filter.filterBefore}${filter_handler}${filter.filterAfter}"</#if></#local>
	<#local list_id><#if filter.list>${filter.list.listId}</#if></#local>
	<#local i=0>
	<#local li_html="">
	<#local default_text="">
	<#list filter.filterValues as value>
		<#local props="${filter.filterProps[i]}">
		<#local texts="${filter.filterTexts[i]}">
		<#if filter.disabledValues && filter.disabledValues?seq_contains(value)>
			<#local li_html>${li_html}<li class="disabled">${texts}</li></#local>
		<#else>
			<#if filter.pagination>
				<#local li_html>${li_html}<li need_submit=1 class="current_filter" filter_type="${filter.filterAttr}" ${filter.filterAttr}="${value}" ${filter_event} table_id="${filter.list.listId}" ${props}>${texts}</li></#local>
			<#else>
				<#local li_html>${li_html}<li class="current_filter" filter_type="${filter.filterAttr}" ${filter.filterAttr}="${value}" ${filter_event} table_id="${filter.list.listId}" ${props}>${texts}</li></#local>
			</#if>
		</#if>
		<#if value=="${filter.defaultvalue}">
			<#local default_text="${texts}">
		</#if>
		<#local i=i+1>
	</#list>
	<#local limit_class><#if filter.filterWidthLimit>selectCon</#if></#local>
	<#local maxH_class><#if filter.filterHeightLimit>listMaxH</#if></#local>	
	<div style="border-radius:2px 0 0 2px;" class="standardSelect">
		<span class="${span_class_name} ${limit_class}" $filter_attr='${filter.defaultvalue}'  filter_type="${filter.filterAttr}" >${default_text}</span>
		<input type="hidden" name="${span_class_name}" value="${filter.defaultvalue}" >
		<input type="hidden" name="${span_class_name_text}" value="${default_text}">
		<img align="absmiddle" src="/images/arrow_down_small.png">&nbsp;
		<div class="standardDilogBox" style="display: none;">
			<ul class="no_list_style ${maxH_class}">
				${li_html}		
			</ul>
			<#local extra_html="">
			<#if reqestParametersMap?exists>
				<#list reqestParametersMap?keys as key>
					<#if key != filter.filterAttr && key?lower_case != "submit">
						<#local temp_value="${reqestParametersMap[key]}"/>
						<#local extra_html>${extra_html}<input type="hidden" name="${key}" value="${temp_value}"></#local>
					</#if>
				</#list>
				<#if extra_html != ''>
					<form method="post" id="filter_form_${filter.filterAttr}">
						${extra_html}
					</form>
				</#if>
			</#if>
		</div>
	</div>
</#macro>
<!--filter_html-->
<#macro list_filter_html list>
	<#if list && list.showFilter>
		<#local _list_filter_html=""/>
		<#list list.filterParams as filter>
			<#local temp_html><@list_filters filter=filter/></#local>
			<#local _list_filter_html='${_list_filter_html + temp_html}'/>
		</#list>
		<#local _list_style="margin-right:5px;"/>
		<#if list.showSeletion>
			<#local _list_style="margin-left:15px; margin-right:5px;"/>
		</#if>
		<#if _list_filter_html != ''>
			<label class="floatL" style="${_list_style}">Filter: </label>
			${_list_filter_html}
		</#if>
	</#if>	
</#macro>

<!--UListSortBy-->
<#macro list_sort_by sort_by>
	<#local _list_sort_by_html>
		<#if sort_by.hasUpDown>
			<#if sort_by.upDownDefault =='up'>
			<span class="n_sortArrowUp">${sort_by.name}</span>
			<#else>
			<span class="n_sortArrowDown">${sort_by.name}</span>
			</#if>
		<#else>
			${sort_by.name}
		</#if>
	</#local>
	<#if sort_by.defaultSortBy>
		${_list_sort_by_html}
	<#else>
		<#local is_sort_by_letter=0/>
		<#if sort_by.sortByLetter><#local is_sort_by_letter=1/></#if>
		<#if sort_by.pagination>
			<li need_submit=1 class="list_sort_by" sort_by='${sort_by.sortByAttr}' up_down="${sort_by.upDownDefault}" is_sort_by_letter="${is_sort_by_letter}" >${_list_sort_by_html}</li>
		<#else>
			<li class="list_sort_by" sort_by='${sort_by.sortByAttr}' up_down="${sort_by.upDownDefault}" is_sort_by_letter="${is_sort_by_letter}" >${_list_sort_by_html}</li>
		</#if>		
	</#if>
</#macro>

<!--sort_by_html-->
<#macro list_sort_by_html list>
	<#if list && list.showSortBy && list.sortByParams?exists>
		<#local _list_sort_by_html=""/>
		<#list list.sortByParams as s>
			<#local temp_html><@list_sort_by sort_by=s/></#local>
			<#local _list_sort_by_html=_list_sort_by_html + temp_html/>
		</#list>		
		<#local limit_class><#if list.soryByWidthLimit>selectCon</#if></#local>
		<#local params_hidden_area=""/>
		<#local sort_by_attr=""/>
		<#local up_down=""/>
		<#local is_sort_by_letter=""/>
		<#local sort_by_default_html=""/>
		<#if list.sortByDefault?exists>
			<#local sort_by_attr="${list.sortByDefault.sortByAttr}"/>
			<#local up_down="${list.sortByDefault.upDown}"/>
			<#if list.sortByDefault.sortByLetter>
				<#local is_sort_by_letter="1"/>
			</#if>			
			<#local sort_by_default_html><@list_sort_by sort_by=list.sortByDefault/></#local>
		</#if>
		<#if reqestParametersMap?exists>
			<#list reqestParametersMap?keys as key>
				<#if key != filter.filterAttr && key?lower_case != "submit">
					<#local temp_value="${reqestParametersMap[key]}"/>
					<#local params_hidden_area>${params_hidden_area}<input type="hidden" name="${key}" value="${temp_value}"></#local>
				</#if>
			</#list>
		</#if>
		<#if list.pagination>			
			<#local params_hidden_area>
				<form method="post" id="list_sort_by_from">
				 <input type="hidden" name="sort_by_attr" value="${sort_by_attr}">
				 <input type="hidden" name="sort_by_up_down" value="${up_down}">
				 <input type="hidden" name="sort_by_is_letter" value="${is_sort_by_letter}">
				 <input type="hidden" name="second_sort_by" value="${list.secondSortBy}"/>
				 <input type="hidden" name="is_pagination" value="1"/>
				 ${params_hidden_area}
				</form>
			</#local>						
		<#else>
			<#local params_hidden_area>
				 <input type="hidden" name="sort_by_attr" value="${sort_by_attr}">
				 <input type="hidden" name="sort_by_up_down" value="${up_down}">
				 <input type="hidden" name="sort_by_is_letter" value="${is_sort_by_letter}">
				 <input type="hidden" name="second_sort_by" value="${list.secondSortBy}"/>
			</#local>	
		</#if>
		<#if _list_sort_by_html != ''>
			<div style=" float:right" class="standardSelect">
				 <span class="sort_by_span $limit_class">${sort_by_default_html}</span>
				 <img align="absmiddle" src="/images/arrow_down_small.png">&nbsp;
				 <div class="standardDilogBox" style="display: none;">
					<ul class="no_list_style">
						${_list_sort_by_html}
					</ul>
				</div>
			</div>
			<label class="floatR" style="margin-right:5px;">Sort By: </label>
		</#if>
		${params_hidden_area}
	</#if>
</#macro>
<!--label_html-->
<#macro list_label_html list></#macro>
<!--search_html-->
<#macro list_search_html list></#macro>
<!--expand_collapse_html -->
<#macro list_expand_collapse_html list></#macro>








