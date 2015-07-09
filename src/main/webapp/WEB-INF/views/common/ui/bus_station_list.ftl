<#--
-->

<#macro busstationlist list>
	<!-- extends list's js_html start-->
	<#local js_html>
		<@uilist.list_js_html list=list/>
		<script type="text/javascript">
			function cache_products_by_busstations()
			{
				var arrChk=$("input[name='chk_list']:checked");
				var bid_string = ""; 
				for(var i=0; i<arrChk.length; i++)
				{
					bid_string +=arrChk[i].value+";";
				}
				if(bid_string == "")
				{
					alert("Please select at least one Bus Station!");
					return false;
				} 
				var fadeBlock = dispaly_sc_fade_block();
				$.get("$ajax_cgi", {type:'cache_products_by_busstations',busstation_ids:bid_string}, function(data){	
					fadeBlock.remove();
					if(data.indexOf("error") != -1) {
						alert(data);
					}
					else
					{
						alert("Cache Successfully!");
					}
				});
			}
		</script>
	</#local>
	<!-- extends list's js_html end-->
	<!--extends list's header_html start-->
	<#local header_html>
		<h2 class="n_adminTitle">Manage Bus Stations
			<#if list.vendor?exists>
				<input type="button" class="standardBut_GrayLow" onclick="window.location.href = '$v_cgi?a=busstation_add_page&vendor=${list.vendor.id}'" value="Add Bus Station">
			</#if>
				
		</h2>
		<div class="vendorDetail" >
				<a href="$o_cgi?a=edit_vendor_page&vendor=${list.vendor.id}" class="font16"><strong>${list.vendor.display}</strong></a>
				<#if list.vendor.suspend==1>
					<font color="red">(Suspended)</font>
				</#if>
			</div>
	</#local>	
	<!--extends list's header_html end-->
	<!--extends list's body_html start--->	
	<#local body_html><@busstaion_body_html list=list/></#local>	
	<!--extends list's body_html end--->	
	<@uilist.list list=list js_html=js_html body_html=body_html header_html=header_html/>
</#macro>

<#macro busstaion_body_html list>
	<#if list?exists>
		<table id="tbl_p_list" border=0 bgcolor="#cccccc" width="100%" cellspacing=1 cellpadding=3>
			<thead>
			<tr>
				<td width="6%" bgcolor="#ffffff" align="center"></td>
			  <td bgcolor="#ffffff" width="52%" align="center"><b><@spring.message "lan_bus_station_view" /></b></td>
			  <td bgcolor="#ffffff" width="36%" align="center"><b><@spring.message "lan_action" /></b></td>
			  <td bgcolor="#ffffff" width="6%" align="center"><b><@spring.message "lan_status" /></b></td>
			</tr>
			</thead>
		<tbody>
		<#local in_working_html=""/>
		<#list list.busStations as b>
			<#local style="#ffffff"/>
			<#if b.status != 1><#local style="#ffffcc"/></#if>
			<#local temp_html>
				<tr align="left" last_update="${b.lastUpdate}" count="$count" cities="${b.stationCity}" class="list_item" status="${b.status}">
				<td bgcolor="${style}" align="center"><input id="chk_list" type="checkbox" value="$aid" name="chk_list"></td>
			  	<td bgcolor="${style}"><a href="${domain}${b.staticUrl}">${b.stationNameCity}</a> (${b.aid})</td>
			  	<td bgcolor="${style}" align="center"><a href="busstation/edit_page.shtml?busstation_id=${b.aid}" title="<@spring.message "lan_edit" />"><img alt="<@spring.message "lan_edit" />" border="0" src="/images/edit_details.gif"></a> | <a href="$remove" title="remove"><img border="0" alt="remove" src="/images/delete_new.gif"></a> | Products [ <a href="$product_list_url">Who Use</a> | <a href="$cache_product_list_url">Cache</a> ] </td>
			  	<td bgcolor="${style}" align="center">${b.shortStatusName}</td>
				</tr>
			</#local>
			<#if b.status == 1>${temp_html} <#else> <#local in_working_html=in_working_html+temp_html/></#if>
		</#list>
		${in_working_html}
		</tbody></table>
	</#if>
</#macro>
