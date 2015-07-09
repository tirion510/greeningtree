<#--
Example:
	<#assign dragdropmap=[{"value":"value1","drag_title":"dragtitle1", "drag_text":"dragtext1", "drop_title":"droptitle1", "drop_text":"droptext1", "category":"category1", "sub_category":"subcategory1", "attributes":"attributes1", "category_value":"categoryvalue1","drop_extra_html":"drop_extra_html1","drag_extra_event":"drag_extra_event1"},{"value":"value2","drag_title":"dragtitle2", "drag_text":"dragtext2", "drop_title":"droptitle2", "drop_text":"droptext2", "category":"category2", "sub_category":"subcategory2", "attributes":"attributes2", "category_value":"categoryvalue2","drop_extra_html":"drop_extra_html2","drag_extra_event":"drag_extra_event2"}]>
    <@form_ui.drag_drop items=dragdropmap id="testdragdrop" name="testdragdrop" colum_count=2 values="value1;value2" drop_note="Drop select options here" separator=";" drop_edit_event="" filters_ref=[{"filter_attr":"label","default_value":"","filter_values":[],"filter_texts":[]}] selected_drap_first=true drag_max_height="395px" local_language="en">
    </@form_ui.drag_drop>
-->
<#macro drag_drop id name colum_count values items drop_note separator drop_edit_event filters_ref selected_drap_first drag_max_height drag_empty_flag local_language>
	<#local container_id="container_"+id>
	<#local need_hide_drap=1>
	<#if !colum_count??>
		<#local colum_count=1>
	</#if>
	<div class="dnd_box" id="${container_id}">
		<@left_html id=id name=name drop_note=drop_note colum_count=colum_count separator=separator need_hide_drap=need_hide_drap items=items values=values>
		</@left_html>
		<@right_html id=id name=name drop_note=drop_note colum_count=colum_count separator=separator need_hide_drap=need_hide_drap items=items values=values container_id=container_id filters_ref=filters_ref selected_drap_first=selected_drap_first drag_max_height=drag_max_height drag_empty_flag=drag_empty_flag>
		</@right_html>
		<div class="clear"></div>
	</div>
	<@js_html local_language=local_language container_id=container_id separator=separator>
	</@js_html>
</#macro>

<#macro left_html id name drop_note colum_count separator need_hide_drap items values>
	<#local drop_item_width="180px" drop_label_with="">
	<#if colum_count?? && colum_count!=0>
		<#local drop_item_width=(((405-colum_count*15)/colum_count)?int)+"px">
		<#local drop_label_with=((((405-colum_count*15)/colum_count)?int)-70)+"px">
	</#if>
	<#local drop_width="405px">
	<div class="drop_box" style="width:${drop_width};">
		<@drop_html id=id name=name drop_note=drop_note colum_count=colum_count separator=separator need_hide_drap=need_hide_drap items=items values=values drop_item_width=drop_item_width drop_label_with=drop_label_with>
		</@drop_html>
		<input class="drop_data" type="hidden" id="${id}" name="${name}" value=""/>
		<input type="hidden" name="drop_item_width" value="${drop_item_width}"/>
		<input type="hidden" name="drop_label_with" value="${drop_label_with}"/>
	</div>
</#macro>

<#macro drop_html id name drop_note colum_count separator need_hide_drap items values drop_item_width drop_label_with>
	<#local hash={} categorys=[] sub_categorys=[] category_hash={}>
	<#list items as item>
		<#local hash=hash+{item.value:item.drag_title}>
		<#if item.category??>
			<#local categorys=categorys+[item.category]>
		</#if>
		<#if item.sub_category??>
			<#local sub_categorys=sub_categorys+[item.sub_category]>
		</#if>
		<#local cats=[]>
		<#if category_hash?keys?seq_contains(item.category)>
			<#local cats=category_hash[item.category]>
		</#if>
		<#local cats=cats+[item.sub_category]>
		<#local category_hash=category_hash+{item.category:cats}>
	</#list>
	<#local distinct_categorys=[]>
	<#list categorys as distinct_category>
		<#if !distinct_categorys?seq_contains(distinct_category)>
			<#local distinct_categorys=distinct_categorys+[distinct_category]>
		</#if>
	</#list>
	<#local categorys=distinct_categorys>
	<#local distinct_sub_categorys=[]>
	<#list sub_categorys as distinct_sub_category>
		<#if !distinct_sub_categorys?seq_contains(distinct_sub_category)>
			<#local distinct_sub_categorys=distinct_sub_categorys+[distinct_sub_category]>
		</#if>
	</#list>
	<#local sub_categorys=distinct_sub_categorys>
	<#local separator_values=values?split(separator)>
	<#local selected_values=[]>
	<#list separator_values as separator_value>
		<#if hash?keys?seq_contains(separator_value)>
			<#local selected_values=selected_values+[separator_value]>
		</#if>
	</#list>
	<#local drag_hash={} drop_hash={} selected_category_hash={}>
	<#local addtional_drop_label_style="style=\"width:${drop_label_with};\"">
	<#list items as item>
		<#if selected_values?seq_contains(item.value)>
			<#local category_values=[]>
			<#local category_connect_sub_category="${item.category}-${item.sub_category}">
			<#if selected_category_hash?keys?seq_contains(category_connect_sub_category)>
				<#local category_values=selected_category_hash[category_connect_sub_category]>
			</#if>
			<#local category_values=category_values+[item.value]>
			<#local selected_category_hash=selected_category_hash+{category_connect_sub_category:category_values}>
			<#local drop_hash_value="">
			<#if item.drop_text??>
				<#local drop_hash_value="\lli class=\"dnd_item dnd_item_floor\" category=\"${item.category}\" sub_category=\"${item.sub_category}\" ${item.attrs} \g
						\linput class=\"dnd_item_value\" type=\"hidden\" value=\"${item.value}\"\g
						\llabel class=\"dnd_item_label\" title=\"${item.drop_title}\"\g${item.drop_title}\l/label\g
						\la class=\"delete_picture img_delete1 arrow_downpng\" style=\"display: none;\"\g\l/a\g
						\ldiv class=\"item_info\"\g
							${item.drop_text}
						\l/div\g
					\l/li\g">
			<#else>
				<#local drop_hash_value="\lli class=\"dnd_item dnd_item_options\" category=\"${item.category}\" sub_category=\"${item.sub_category}\" ${item_attrs} style=\"width:${drop_item_with};\"\g
						\linput class=\"dnd_item_value\" type=\"hidden\" value=\"${item.value}\"\g
						\lspan class=\"dnd_item_span\" style=\"display:none;float: left;\"\g\l/span\g
						\llabel class=\"dnd_item_label\" title=\"${item.drop_title}\" ${addtional_drop_label_style}\g${item.drop_title}\l/label\g
						\la class=\"delete_picture img_delete1\" style=\"display: none;\"\g\l/a\g
						\ldiv class=\"clear\"\g\l/div\g
					\l/li\g">
			</#if>
			<#local drop_hash=drop_hash+{item.value:drop_hash_value}>
		</#if>
	</#list>
	<div style="padding-bottom:10px; margin-bottom:10px;font-size:16px; font-weight:bold; border-bottom:1px solid #CCC">You have selected</div>
	<div style="position:relative;">
		<ol class="dnd_items">
			<#if (categorys?size>0)>
				<#list categorys as category>
					<li class="dnd_item dnd_item_city category_item" category="${category}">
					<label class="dnd_item_label" title="${category}">${category}</label>
					<a class="delete_picture img_delete1" style="display:none;"></a>
					<div class="clear"></div>
					<#if (sub_categorys?size>0)>
						<#if category_hash?keys?seq_contains(category)>
							<#local current_sub_categorys=category_hash[category]>
							<#local distinct_current_sub_categorys=[]>
							<#list current_sub_categorys as distinct_current_sub_category>
								<#if !distinct_current_sub_categorys?seq_contains(distinct_current_sub_category)>
									<#local distinct_current_sub_categorys=distinct_current_sub_categorys+[distinct_current_sub_category]>
								</#if>
							</#list>
							<#local current_sub_categorys=distinct_current_sub_categorys>
							<div class="dnd_items_category">
							<#list current_sub_categorys as current_sub_category>
								<#local sv=[]>
								<#if selected_category_hash?keys?seq_contains(category+"-"+current_sub_category)>
									<#local sv=selected_category_hash[category+"-"+current_sub_category]>
								</#if>
								<dl>
									<dd class="sub_category_item" sub_category="${current_sub_category}" category="${category}">
										${current_sub_category}
										<a class="delete_picture img_delete1 arrow_downpng" style="display:none;"></a>
									</dd>
									<dt class="sub_category_item dnd_third" sub_category="${current_sub_category}">
										<ul class="dnd_items_sub" sub_category="${current_sub_category}" category="${category}" >
											<#list sv as v>
												${drop_hash[v]}
											</#list>
											<div class="clear"></div>
										</ul>
										<div class="clear"></div>
			                  				<div class="drop_block" style="display: none;">
											<div class="drop_overlay"></div>
											<p class="drop_note">${drop_note}</p>
										</div>
									</dt>
								</dl>
							</#list>
						</div>	
						</#if>
					<#else>
						<#local sv=[]>
						<#if selected_category_hash?keys?seq_contains(category+"-")>
								<#local sv=selected_category_hash[category+"-"]>
						</#if>
						<div class="dnd_third">
						<ul class="dnd_items_sub" category="${category}">
							<#list sv as v>
								${drop_hash[v]}
							</#list>
						</ul>	
						<div class="clear"></div>
            			<div class="drop_block" style="display: none;">
							<div class="drop_overlay"></div>
							<p class="drop_note">${drop_note}</p>
						</div>
					</div>
					</#if>
					</li>
				</#list>
			<#else>
				<#list selected_values as selected_value>
					${drop_hash[selected_value]}
				</#list>
			</#if>
		</ol>
		<#if (categorys?size>0) && (sub_categorys?size>0)>
			<div class="drop_block" style="display:none;">
				<div class="drop_overlay"></div>
				<p class="drop_note">${drop_note}</p>
			</div>
		</#if>
	</div>
</#macro>

<#macro right_html id name drop_note colum_count separator need_hide_drap items values container_id filters_ref drop_edit_event selected_drap_first drag_max_height drag_empty_flag>
	<div class="drag_box" style="background-color:#f2f2f2;border-radius: 4px;float: right;margin: 0 5px 0 5px;max-height: none;min-height: none;overflow: visible;padding: 12px 10px;width:320px; height:100%;">
		<@drag_html id=id name=name drop_note=drop_note colum_count=colum_count separator=separator need_hide_drap=need_hide_drap items=items values=values container_id=container_id filters_ref=filters_ref drop_edit_event=drop_edit_event selected_drap_first=selected_drap_first drag_max_height=drag_max_height drag_empty_flag=drag_empty_flag>
		</@drag_html>
	</div>
</#macro>

<#macro drag_html id name drop_note colum_count separator need_hide_drap items values container_id filters_ref drop_edit_event selected_drap_first drag_max_height drag_empty_flag>
	<#local hash={} categorys=[] sub_categorys=[] category_hash={} sub_category_item_hash={} category_item_hash={}>
	<#list items as item>
		<#local hash=hash+{item.value:item.drag_title}>
		<#if item.category??>
			<#local categorys=categorys+[item.category]>
		</#if>
		<#if item.sub_category??>
			<#local sub_categorys=sub_categorys+[item.sub_category]>
		</#if>
		<#local cats=[]>
		<#if category_hash?keys?seq_contains(item.category)>
			<#local cats=category_hash[item.category]>
		</#if>
		<#local cats=cats+[item.sub_category]>
		<#local category_hash=category_hash+{item.category:cats}>
		<#local sub_items=[]>
		<#if sub_category_item_hash?keys?seq_contains(item.category+"-"+item.sub_category)>
			<#local sub_items=sub_category_item_hash[item.category+"-"+item.sub_category]>
		</#if>
		<#local sub_items=sub_items+[item]>
		<#local sub_category_item_hash=sub_category_item_hash+{(item.category+"-"+item.sub_category):sub_items}>
		<#local cat_items=[]>
		<#if category_item_hash?keys?seq_contains(item.category)>
			<#local cat_items=category_item_hash[item.category]>
		</#if>
		<#local cat_items=cat_items+[item]>
		<#local category_item_hash=category_item_hash+{item.category:cat_items}>
	</#list>
	<#local distinct_categorys=[]>
	<#list categorys as distinct_category>
		<#if !distinct_categorys?seq_contains(distinct_category)>
			<#local distinct_categorys=distinct_categorys+[distinct_category]>
		</#if>
	</#list>
	<#local categorys=distinct_categorys>
	<#local distinct_sub_categorys=[]>
	<#list sub_categorys as distinct_sub_category>
		<#if !distinct_sub_categorys?seq_contains(distinct_sub_category)>
			<#local distinct_sub_categorys=distinct_sub_categorys+[distinct_sub_category]>
		</#if>
	</#list>
	<#local sub_categorys=distinct_sub_categorys>
	<#local separator_values=values?split(separator)>
	<#local selected_values=[]>
	<#list separator_values as separator_value>
		<#if hash?keys?seq_contains(separator_value)>
			<#local selected_values=selected_values+[separator_value]>
		</#if>
	</#list>
	<#if (categorys?size>0) && (sub_categorys?size>0)>
		<div style="margin-bottom: 8px;">
			<ul class="editDest_Pier no_list_style category_ul">
				<#list categorys as cat>
					<#local class="">
					<#if cat_index==0>
						<#local class="destActive">
					</#if>
					<#local index=index+1>
					<li class="${class}" category="${cat}" onclick="change_category(this);">${cat}</li>
				</#list>
			</ul>
			<div class="clear"></div>
		</div>	
		<#list categorys as cat>
			<div class="category_div" category="${cat}">
				<#local tabs=[] subs=category_hash[cat]>	
				<#local distinct_subs=[]>
				<#list subs as distinct_sub>
					<#if !distinct_subs?seq_contains(distinct_sub)>
						<#local distinct_subs=distinct_subs+[distinct_sub]>
					</#if>
				</#list>
				<#local subs=distinct_subs>
				<#list subs as current_sub>
					<#local is_active=false>
					<#if current_sub_index==0>
						<#local is_active=true>
					</#if>
					<#local sub_items=sub_category_item_hash[cat+"-"+current_sub]>
					<@drag_tab sub_items=sub_items filters_ref=filters_ref selected_values=selected_values need_hide_drap=need_hide_drap drop_edit_event=drop_edit_event selected_drap_first=selected_drap_first drag_max_height=drag_max_height drag_empty_flag=drag_empty_flag>
					</@drag_tab>
					<#local tab={"title":sub_item,"content":drag_tab_html,"is_active":is_active,"attrs":"sub_category=\"${sub_item}\" category=\"${cat}\""}>
					<#local tabs=tabs+[tab]>
				</#list>
				<@form_ui.tab map=tabs type=1 tab_menu_class="sub_category_ul" bind_click="drap_filter_execute($(this))">
				</@form_ui.tab>
			</div>
		</#list>
	<#elseif (categorys?size>0) && !(sub_categorys?size>0)>
		<div style="margin-bottom: 8px;">
			<ul class="editDest_Pier no_list_style category_ul">
				<#list categorys as cat>
					<#local class="">
					<#if cat_index==0>
						<#local class="destActive">
					</#if>
					<li class="${class}" category="${cat}" onclick="change_category(this);">${cat}</li>
				</#list>
			</ul>
			<div class="clear"></div>
		</div>	
		<#list categorys as cat>
			<#local cat_items=category_item_hash[cat]>
			<div class="category_div" category="${cat}">
				<@drag_tab sub_items=cat_items filters_ref=filters_ref selected_values=selected_values need_hide_drap=need_hide_drap drop_edit_event=drop_edit_event selected_drap_first=selected_drap_first drag_max_height=drag_max_height drag_empty_flag=drag_empty_flag>
				</@drag_tab>
				${drag_tab_html}
			</div>
		</#list>
	<#elseif !(categorys?size>0) && !(sub_categorys?size>0)>
		<@drag_tab sub_items=map filters_ref=filters_ref selected_values=selected_values need_hide_drap=need_hide_drap drop_edit_event=drop_edit_event selected_drap_first=selected_drap_first drag_max_height=drag_max_height drag_empty_flag=drag_empty_flag>
		</@drag_tab>
		${drag_tab_html}
	</#if>
</#macro>

<#macro drag_tab sub_items filters_ref selected_values need_hide_drap drop_edit_event selected_drap_first drag_max_height drag_empty_flag>
	<#local drop_edit_html="">
	<#if drop_edit_event??>
		<#local drop_edit_html="\la class=\"img_edit1\" style=\"display:none;\" ${drop_edit_event}\g\l/a\g">
	</#if>
	<#local toolbar_html="">
	<#if (sub_items?size>0)>
		<#local filter_html="">
		<#if filters_ref?? && (filters_ref?size>0)>
			<#list filters_ref as filters>
				<#local current_filter_html="">
				<#local span_class_name = filters.filter_attr+"_filter_span">
				<#local span_class_name_text = filters.filter_attr+"_filter_span_text">
				<#local li_html="" default_text="">
				<#if filters.filter_values?? && filters.filter_values?is_sequence>
					<#list filters.filter_values as filter_value>
						<#local filter_text="">
						<#if (filter_value_index<(filters.filter_values?size))>
							<#local filter_text=filters.filter_texts[filter_value_index]>
						</#if>
						<#local li_html=li_html+"\lli class=\"drag_filter\" filter_type=\"${filters.filter_attr}\" ${filters.filter_attr}=\"${filter_value}\" onclick=\"drap_filter(this);\"\g${filter_text}\l/li\g">
						<#if filter_value==filters.default_value>
							<#local default_text=filter_text>
						</#if>
					</#list>
				</#if>
				<#local current_filter_html="\ldiv class=\"standardSelect\" style=\"height:auto; text-align:left; margin-bottom:5px; width:99.1%; background:#fff;border: 1px solid rgba(0, 0, 0, 0.1);padding:0px;\"\g
										\lspan class=\"${span_class_name}\" filter_attr='${filters.default_value}'  filter_type=\"${filters.filter_attr}\" \g${default_text}\l/span\g
										\linput type=\"hidden\" name=\"${span_class_name}\" value=\"${filters.default_value}\" \g
										\linput type=\"hidden\" name=\"${span_class_name_text}\" value=\"${default_text}\"\g
										\limg align=\"absmiddle\" src=\"/images/arrow_down_small.png\" class=\"arrow_downpng\"\g&nbsp;
										\ldiv class=\"standardDilogBox\" style=\"display: block; width:100%;display: none;\"\g
											\lul class=\"no_list_style listMaxH\"\g
												${li_html}		
											\l/ul\g
										\l/div\g
									\l/div\g">
				<#local filter_html=filter_html+current_filter_html>
			</#list>
		</#if> 
		<#local search_html="\ldiv style=\"margin:10px auto;width:100%; position:relative;\"\g
								${filter_html}
								\l/div\g
								\ldiv class=\"optsearch\"\g
									\linput class=\"search_box\" type=\"text\" style=\"width: 97.8%; padding-left: 5px; height: 26px; line-height: 26px; border: 1px solid rgb(242, 242, 242); background-color: rgb(255, 255, 255); color: rgb(153, 153, 153);\" value=\"Keywords\" data-placeholder=\"Keywords\" onkeyup=\"drap_filter_execute(this);\" autocomplete=\"off\"\g
								\l/div\g">
		<#local toolbar_html=toolbar_html+search_html>
	</#if>
	<#local drag_hash={}>
	<#list sub_items as sub_item>
		<#local category = sub_item.category>
		<#local drag_text = sub_item.drag_text>
		<#if sub_item.category_value?? && sub_item.category_value!="">
			<#local category = sub_item.category_value>
		</#if>
		<#if selected_values?seq_contains(sub_item.value)>
			<#local li_display="">
			<#if need_hide_drap==1>
				<#local li_display = "display:none;">
			</#if>
			<#if drag_text!="">
				<#if drag_text="&nbsp;">
					<#local drag_text = "">
				</#if>
				<#local drop_item_html="\ldiv style=\"display:none;\" class=\"drop_display_html\"\g
											\linput class=\"dnd_item_value\" type=\"hidden\" value=\"${sub_item.value}\"\g
											\llabel class=\"dnd_item_label\" title=\"${sub_item.drop_title}\"\g${sub_item.drop_title}\l/label\g
											\la class=\"delete_picture img_delete1\" style=\"display: none;\"\g\l/a\g
											${sub_item.drop_edit_html}
											${sub_item.drop_extra_html}
											\ldiv class=\"item_info\"\g
												${sub_item.drop_text}
											\l/div\g
											\l/div\g">
				<#local drag_hash_value="\lli class=\"dnd_item dnd_item_city\" style=\"${li_display}\" is_selected=\"1\" ${sub_item.attributes} category=\"${category}\" sub_category=\"${sub_item.sub_category}\"\g
												\ldiv class=\"dnd_item_info\"\g	
													\linput class=\"dnd_item_value\" type=\"hidden\" value=\"${sub_item.value}\" category=\"${category}\" sub_category=\"${sub_item.sub_category}\" \g
													\lspan class=\"dnd_item_span\" style=\"display:none;float:left;\"\g\l/span\g
													\llabel style=\"color:#333;font-weight:bold;margin-bottom:5px\" title=\"${sub_item.drag_title}\"\g${sub_item.drag_title}\l/label\g
													\la class=\"delete_picture img_delete1\" style=\"display:block;\"\g\l/a\g
														${sub_item.drag_extra_event_html}
													\ldiv class=\"clear\"\g\l/div\g
													\ldiv class=\"item_info\" style=\"color:#666;line-height:150%\"\g${drag_text}\l/div\g
												\l/div\g	
												${drop_item_html}
											\l/li\g">
									
			<#else>
				<#local drag_hash_value="\lli class=\"dnd_item\" style=\"${li_display}\" is_selected=\"1\" ${sub_item.attributes} category=\"${category}\" sub_category=\"${sub_item.sub_category}\" \g
																	\linput class=\"dnd_item_value\" type=\"hidden\" value=\"${sub_item.value}\"\g
																	\lspan class=\"dnd_item_span\" style=\"display:none;float:left;\"\g\l/span\g
																	\llabel class=\"dnd_item_label\" title=\"${sub_item.drag_title}\"\g${sub_item.drag_title}\l/label\g
																	\la class=\"delete_picture img_delete1\" style=\"display:block;\"\g\l/a\g
																	\ldiv class=\"clear\"\g\l/div\g
																\l/li\g">
			</#if>
		<#else>
			<#if drag_text!="">
				<#if drag_text="&nbsp;">
					<#local drag_text = "">
				</#if>
				<#local drop_item_html="\ldiv style=\"display:none;\" class=\"drop_display_html\"\g
											\linput class=\"dnd_item_value\" type=\"hidden\" value=\"${sub_item.value}\"\g
											\llabel class=\"dnd_item_label\" title=\"${sub_item.drop_title}\"\g${sub_item.drop_title}\l/label\g
											\la class=\"delete_picture img_delete1\" style=\"display: none;\"\g\l/a\g
											${sub_item.drop_edit_html}
											${sub_item.drop_extra_html}
											\ldiv class=\"item_info\"\g
												${sub_item.drop_text}
											\l/div\g
											\l/div\g">
				<#local drag_hash_value="\lli class=\"dnd_item dnd_item_city\" ${sub_item.attributes} category=\"${category}\" sub_category=\"${sub_item.sub_category}\"\g
												\ldiv class=\"dnd_item_info\"\g	
													\linput class=\"dnd_item_value\" type=\"hidden\" value=\"${sub_item.value}\" category=\"${category}\" sub_category=\"${sub_item.sub_category}\" \g
													\lspan class=\"dnd_item_span\" style=\"display:none;float:left;\"\g\l/span\g
													\llabel style=\"color:#333;font-weight:bold;margin-bottom:5px\" title=\"${sub_item.drag_title}\"\g${sub_item.drag_title}\l/label\g
													\la class=\"delete_picture img_delete1\" style=\"display:block;\"\g\l/a\g
														${sub_item.drag_extra_event_html}
													\ldiv class=\"clear\"\g\l/div\g
													\ldiv class=\"item_info\" style=\"color:#666;line-height:150%\"\g${drag_text}\l/div\g
												\l/div\g	
												${drop_item_html}
											\l/li\g">
			<#else>
				<#local drag_hash_value="\lli class=\"dnd_item\" ${sub_item.attributes} category=\"${category}\" sub_category=\"${sub_item.sub_category}\" \g
																	\linput class=\"dnd_item_value\" type=\"hidden\" value=\"${sub_item.value}\" category=\"${category}\" sub_category=\"${sub_item.sub_category}\" \g
																	\lspan class=\"dnd_item_span\" style=\"display:none;float:left;\"\g\l/span\g
																	\llabel class=\"dnd_item_label\" title=\"${sub_item.drag_title}\"\g${sub_item.drag_title}\l/label\g
																	\la class=\"delete_picture img_delete1\" style=\"display:block;\"\g\l/a\g
																	\ldiv class=\"clear\"\g\l/div\g
																\l/li\g">
			</#if>
		</#if>
		<#local drag_hash=drag_hash+{sub_item.value:drag_hash_value}>
	</#list>
	<#local drag_html="">
	<#if selected_drap_first>
		<#local selected_items=[]>
		<#local unselected_items=[]>
		<#list sub_items as sub_item>
			<#if selected_values?seq_contains(sub_item.value)>
				<#local selected_items=selected_items+[sub_item]>
			<#else>
				<#local unselected_items=unselected_items+[sub_item]>
			</#if>
			<#list selected_items?sort_by("drag_title") as selected_item>
				<#local drag_html=drag_html+drag_hash[selected_item.value]>
			</#list>
			<#list unselected_items?sort_by("drag_title") as unselected_item>
				<#local drag_html=drag_html+drag_hash[unselected_item.value]>
			</#list>
		</#list>
	<#else>
		<#list sub_items?sort_by("drag_title") as sub_item>
			<#local drag_html=drag_html+drag_hash[sub_item.value]>
		</#list>
	</#if>
	<#if !drag_max_height??>
		<#local drag_max_height="400px">
	</#if>
	<#local drag_flag_html="You\'ve selected all.">
	<#if drag_empty_flag?? && sub_items?is_sequence && sub_items?size==0>
		<#local drag_flag_html=drag_empty_flag>
	</#if>
	<#assign drag_tab_html="\ldiv class=\"optfilter\"\g
													${toolbar_html}
												\l/div\g
												\ldiv class=\"clear\"\g\l/div\g		 
											 	\ldiv class=\"dragopts\"\g
													\lul id=\"sucai\" class=\"dnd_items\" style=\"max-height: $drag_max_height; overflow: hidden;overflow-y: auto;\" tabindex=\"5000\"\g
														${drag_html}
													\l/ul\g
													\lp class=\"drag_flag\"\g${drag_flag_html}\l/p\g
												\l/div\g	
												\linput type=\"hidden\" name=\"need_hide_drap\" value=\"${need_hide_drap}\"/\g">
</#macro>

<#macro js_html local_language container_id separator>
	<#local standard_list_js="http://www.taketours.com/js/${local_language}/standard_list.js">
	<script src="${standard_list_js}" type="text/javascript"></script>
		<script type="text/javascript">
			$(document).ready(function() {
				display_draggable_tooltip($("#${container_id}").get());
				handle_droppable_number($("#${container_id}").get());
				handle_droppable_data($("#${container_id}").get(), "${separator}");
				bind_hover();
				$(document).on({
					click: function() {
						if($(this).parent().hasClass("category_item") || $(this).parent().hasClass("sub_category_item"))
						{
							var category = $(this).parent().attr("category");
							var sub_category = $(this).parent().attr("sub_category");
							$("#${container_id} .drop_box .dnd_items .dnd_item_floor").each(function(){
								if($(this).attr("category") == category)
								{
									if(sub_category && $(this).attr("sub_category") == sub_category)
									{
										$(this).find(".delete_picture").click();
									}
									else if(!sub_category)
									{
										$(this).find(".delete_picture").click();
									}
								}
							});
						}
						else
						{
							$("#${container_id} .drag_box .dnd_item .dnd_item_value[value='" + $(this).closest(".dnd_item").find(".dnd_item_value").val() + "']").closest(".dnd_item").attr("is_selected", 0);
							$(this).closest(".dnd_item").remove();
							display_draggable_tooltip($("#${container_id}").get());
							handle_droppable_number($("#${container_id}").get());
							handle_droppable_data($("#${container_id}").get(), "${separator}");
							drap_filter_execute($("#${container_id}").find(".drag_box"));
						}
					}
				}, "#${container_id} .drop_box .delete_picture");
				
				$("#${container_id} .drag_box .dnd_items").each(function(){
					var category = $(this).find(".dnd_item:first").attr("category");
					var sortable_obj = "#${container_id} .drop_box .dnd_items";
					if(category)
					{
						var sub_category = $(this).find(".dnd_item:first").attr("sub_category");
						if(sub_category)
						{
							sortable_obj = "#${container_id} .drop_box ul[category='"+category+"'][sub_category='"+sub_category+"']";
						}
						else
						{
							sortable_obj = "#${container_id} .drop_box ul[category='"+category+"']";
						}
					}
					$(this).find(".dnd_item").draggable({
						addClasses: false,
						connectToSortable: sortable_obj,
						helper: "clone",
						start: function(event, ui) {
							var item_w = $("#${container_id} .drag_box:first ").width() * 0.99;
							ui.helper.width(item_w);
							ui.helper.height(ui.helper.height());
							$(sortable_obj).parent().find(".drop_block").show();
						},						
						stop: function(event, ui) {
							$("#${container_id} .drop_block").hide();
							$(".drop_box .delete_picture").parent().unbind('hover');
							bind_hover();
						}
					});
				});
				
				$("#${container_id} .drop_box .dnd_items").sortable({
					receive: function(event, ui) {
						if($("#${container_id}").find("input[name='need_hide_drap']").val() == 1)
						{
							ui.sender.hide();
						}
						ui.sender.attr("is_selected", 1);
						display_draggable_tooltip($("#${container_id}").get());
					},
					update: function(event, ui) {
						handle_droppable_number($("#${container_id}").get());
						handle_droppable_data($("#${container_id}").get(), "${separator}");
					},
					over: function(event, ui) {
						$("#${container_id} .drop_note").hide();
						$("#${container_id} .drop_overlay").addClass("semi");
					},
					out: function(event, ui) {
						$("#${container_id} .drop_note").show();
						$("#${container_id} .drop_overlay").removeClass("semi");
					}
				});
				
				$("#${container_id} .drop_box .dnd_items_category").sortable({
					receive: function(event, ui) {
						if($("#${container_id}").find("input[name='need_hide_drap']").val() == 1)
						{
							ui.sender.hide();
						}
						ui.sender.attr("is_selected", 1);
						display_draggable_tooltip($("#${container_id}").get());
					},
					update: function(event, ui) {
						handle_droppable_number($("#${container_id}").get());
						handle_droppable_data($("#${container_id}").get(), "${separator}");
					},
					over: function(event, ui) {
						$("#${container_id} .drop_note").hide();
						$("#${container_id} .drop_overlay").addClass("semi");
					},
					out: function(event, ui) {
						$("#${container_id} .drop_note").show();
						$("#${container_id} .drop_overlay").removeClass("semi");
					}
				});
				
				$("#${container_id} .drop_box .dnd_items_sub").sortable({
					receive: function(event, ui) {
						if($("#${container_id}").find("input[name='need_hide_drap']").val() == 1)
						{
							ui.sender.hide();
						}
						ui.sender.attr("is_selected", 1);
						display_draggable_tooltip($("#${container_id}").get());
					},
					update: function(event, ui) {
						handle_droppable_number($("#${container_id}").get());
						handle_droppable_data($("#${container_id}").get(), "${separator}");
					},
					over: function(event, ui) {
						$("#${container_id} .drop_note").hide();
						$("#${container_id} .drop_overlay").addClass("semi");
					},
					out: function(event, ui) {
						$("#${container_id} .drop_note").show();
						$("#${container_id} .drop_overlay").removeClass("semi");
					}
				});
				
				$("#${container_id} .drag_box .dnd_items .dnd_item").dblclick(function(){
					if($(this).is(":visible") && (!$(this).attr("is_selected") || $(this).attr("is_selected") == 0))
					{
						var category = $(this).attr('category');
						var sub_category = $(this).attr('sub_category');
						if(category)
						{
							if(sub_category)
							{
								$(this).closest(".dnd_box").find(".drop_box ul[category='"+category+"'][sub_category='"+sub_category+"']").append($(this).closest(".dnd_item").clone(false));
							}
							else
							{
								$(this).closest(".dnd_box").find(".drop_box ul[category='"+category+"']").append($(this).closest(".dnd_item").clone(false));
							}
						}
						else
						{
							$(this).closest(".dnd_box").find(".drop_box ol").append($(this).closest(".dnd_item").clone(false));
						}
						if($("#${container_id}").find("input[name='need_hide_drap']").val() == 1)
						{
							$(this).hide();
						}
						$(this).attr("is_selected", 1);
						handle_droppable_number($("#${container_id}").get());
						handle_droppable_data($("#${container_id}").get(), "${separator}");
						display_draggable_tooltip($("#${container_id}").get());
						$(".drop_box .delete_picture").parent().unbind('hover');
						bind_hover();
					}
				});
				
				$("#${container_id} .drag_box .dnd_items .delete_picture").click(function(){
					if($(this).closest(".dnd_item").is(":visible") && (!$(this).closest(".dnd_item").attr("is_selected") || $(this).closest(".dnd_item").attr("is_selected") == 0))
					{
						var category = $(this).closest(".dnd_item").attr('category');
						var sub_category = $(this).closest(".dnd_item").attr('sub_category');
						if(category)
						{
							if(sub_category)
							{
								$(this).parent().closest(".dnd_box").find(".drop_box ul[category='"+category+"'][sub_category='"+sub_category+"']").append($(this).closest(".dnd_item").clone(false));
							}
							else
							{
								$(this).parent().closest(".dnd_box").find(".drop_box ul[category='"+category+"']").append($(this).closest(".dnd_item").clone(false));
							}
						}
						else
						{
							$(this).parent().closest(".dnd_box").find(".drop_box ol").append($(this).closest(".dnd_item").clone(false));
						}
						if($("#${container_id}").find("input[name='need_hide_drap']").val() == 1)
						{
							$(this).closest(".dnd_item").hide();
						}
						$(this).closest(".dnd_item").attr("is_selected", 1);
						handle_droppable_number($("#${container_id}").get());
						handle_droppable_data($("#${container_id}").get(), "${separator}");
						display_draggable_tooltip($("#${container_id}").get());
						$(".drop_box .delete_picture").parent().unbind('hover');
						bind_hover();
					}
				});
			});
						
			$(document).ready(function() {
				change_category($("#${container_id}").get());
				change_filter_item($("#${container_id}").get());
			});
		</script>
</#macro>