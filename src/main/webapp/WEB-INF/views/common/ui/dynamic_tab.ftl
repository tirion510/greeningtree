<#--
Example:
	<@form_ui.dynamic_tab id="testDynamicTab" map=tabmap type=1 ajax_cgi="" tab_menu_class="" language="en" bind_click="">
    </@form_ui.dynamic_tab>
-->
<#macro dynamic_tab uDynamicTab>
	<#local tabs = []>
	<#if uDynamicTab.tabList??>
		<#local tabs = uDynamicTab.tabList>
	</#if>
	<#local pr_tab_menu_class="xxk">
	<#if uDynamicTab.language=="cn">
		<#local pr_tab_menu_class="xxk1">
	</#if>
	<#local div_class="xxk_content">
	<#if uDynamicTab.type?? && uDynamicTab.type == 1>
		<#local pr_tab_menu_class="xxk2">
		<#local div_class="xxk2_content">
	</#if>
	<#if uDynamicTab.tabMenuClass??>
		<#local uDynamicTab = uDynamicTab + {"tabMenuClass":(pr_tab_menu_class+" "+uDynamicTab.tabMenuClass)}>
	<#else>
		<#local uDynamicTab = uDynamicTab + {"tabMenuClass":pr_tab_menu_class}>
	</#if>
	<div id="${uDynamicTab.id}" style="left:0;top:0;height:33px;clear:both;overflow:hidden;position:relative;width:100%">
		<div class="left_scroll"></div>
		<div style="float:left;overflow:hidden;position:relative;width:674px">
			<ul style="width:2000px;left:0px;" class="scrol no_list_style fixfloat ${uDynamicTab.tabMenuClass}">
				<#list uDynamicTab.tabList as tab>
					<#local class_html="">
					<#if tab.is_active>
						<#local class_html="active">
					</#if>
					<li old_index="${tab_index}" class="${class_html}" ${tab.event} ${tab.attrs}><span>${tab.title}</span><a class="edit_day_delete" href="javascript:void(0);"></a></li>
				</#list>
			</ul>
	    </div>
	    <div class="right_scroll"></div>
	    <div class="add_scroll" onclick="private_tour_add_tab(this);"></div>
	</div>
	<div class="tab_box ${div_class}">
		<#list uDynamicTab.tabList as tab>
			<#local style_html="style='display: none;'">
			<#if tab.is_active>
				<#local style_html="style='display: block;'">
			</#if>
			<div old_index="${tab_index}" ${style_html}>
				${tab.content}
			</div>
		</#list>
	</div>
	<script type="text/javascript">
			$("#${uDynamicTab.id} .right_scroll").click(function(){
    		if($(this).hasClass("disable_right_scroll"))
    		{
    			return;
    		}
    		var ul = $(this).parent().find(".scrol");
        if (!ul.is(":animated")) 
        {
          ul.animate({left: "-" + go_width(ul.get(0)) + "px"}, 0, undefined, function(){
          	var div_li = ul.find("li");	
          	var len = div_li.length;
          	if (next_li_index(ul.get(0)) > len) 
            {
              ul.stop();
            } 
          });
        }
        change_button_state(ul.get(0));
	    });
	    
	    $("#${uDynamicTab.id} .left_scroll").click(function() {
	    	if($(this).hasClass("disable_left_scroll"))
    		{
    			return;
    		}
    		var ul = $(this).parent().find(".scrol");
        if (!ul.is(":animated"))
        {
        	ul.animate({left: "+=" + back_width(ul.get(0)) + "px"}, 0, undefined, function(){
        	});
        }
        change_button_state(ul.get(0));
	    });
			
		$(document).ready(function(){
			$(document).on({
					click: function() {
						$(this).addClass("active").siblings().removeClass("active");
				    var div_index = $(this).attr("old_index");
				    $(this).parent().parent().parent().next().children("div[old_index='"+div_index+"']").show().siblings().hide();
				    if($(this).attr('callback'))
				    {
				    	eval($(this).attr('callback'));
				    }
				    ${uDynamicTab.bindClick}
					}
			}, "#${uDynamicTab.id} .scrol li");
			
			$(document).on({
					click: function(e) {
						var ul = $(this).closest("ul");
						var li_obj = $(this).closest("li");
						var div_index = $(this).parent().attr("old_index");
			      ul.parent().parent().next().children("div[old_index='"+div_index+"']").remove();
			      li_obj.remove();			      
			      if(ul.find("li.active").length <= 0)
			      {
			      	while(!ul.parent().prev().hasClass("disable_left_scroll"))
							{
								ul.parent().prev().click();
							}
			      	ul.find("li:first").click();
			      }
			      change_button_state($("#${uDynamicTab.id} .scrol").get(0));
			      e.stopPropagation();
			      process_private_tour_days(li_obj.get(0), 2, ul);
					}
			}, "#${uDynamicTab.id} .scrol li .edit_day_delete");
			change_button_state($("#${uDynamicTab.id} .scrol").get(0));
		});
		
		function next_li_index(ul)
		{
			var div_li = $(ul).find("li");
			var ul_parent = $(ul).parent();
			var ul_parent_width = ul_parent.width();
			var left = $(ul).css('left');
			left.replace("px","");
			left = parseInt(left);
			var total = ul_parent_width - left;
			var sum_width = 0;
			var next_index = 0;
			div_li.each(function(){
				var width = $(this).width();
				var w_left = sum_width + width + 26;
				if(w_left > total)
				{
					next_index = div_li.index(this) + 1;
					return false; 
				}
				else
				{
					next_index = div_li.index(this) + 2;
					sum_width = sum_width + width + 26;
				}
			});
			return next_index;
		};	
		
		function all_li_width(ul)
		{
			var div_li = $(ul).find("li");
			if(!$(ul).is(":visible"))
			{
				var clone = $(ul).clone().css("visibility", "hidden").appendTo(document.body);
				div_li = clone.find("li");
			}
			var sum_width = 0;
			div_li.each(function(){
				width = $(this).width();
				sum_width = sum_width + width + 26;
			});
			return sum_width;
		}
		
		function change_button_state(ul)
		{
			var ul_parent = $(ul).parent();
			var title_obj = ul_parent.parent();
			var ul_parent_width = ul_parent.width();
			var left = $(ul).css('left');
			left.replace("px","");
			left = parseInt(left);
			var total = ul_parent_width - left;
    	if(total > all_li_width($(ul).get(0)))
      {
      	title_obj.find(".right_scroll").addClass("disable_right_scroll");
      }
      else
      {
      	title_obj.find(".right_scroll").removeClass("disable_right_scroll");
      }
      if(left >= 0)
      {
      	title_obj.find(".left_scroll").addClass("disable_left_scroll");
      }
      else
      {
      	title_obj.find(".left_scroll").removeClass("disable_left_scroll");
      }
		}
		
		function go_width(ul)
		{
			var left = $(ul).css('left');
			left.replace("px","");
			left = parseInt(left);
			var ul_parent = $(ul).parent();
			var total = ul_parent.width() - left;
			var sum_width = 0;
			var go_width = 0;
			var div_li = $(ul).find("li");			
			div_li.each(function(){
				var width = $(this).width();
				var w_left = sum_width + width + 26;
				if(w_left > total)
				{
					last_index = div_li.index(this);
					go_width = sum_width;
					return false; 
				}
				else
				{
					sum_width = sum_width + width + 26;
				}
			});
			return go_width;
		};
		
		function back_width(ul)
		{
			var left = $(ul).css('left');
			left.replace("px","");
			left = parseInt(left);
			var total = 0 - left;
			var sum_width = 0;
			var last_index = 0;
			var first_index = 0;
			var temp_sum_width = 0;
			var div_li = $(ul).find("li");			
			var max_width = $(ul).parent().parent().width() - 56;
			div_li.each(function(){
				var width = $(this).width();
				var w_left = sum_width + width + 26;
				if(w_left > total)
				{
					last_index = div_li.index(this);
					return false; 
				}
				else
				{
					temp_sum_width = temp_sum_width + width + 26;
					if(temp_sum_width > max_width)
					{
						temp_sum_width = width + 26;
						first_index = div_li.index(this) + 1;
					}
					else
					{
						if(first_index == 0)
						{
							first_index = div_li.index(this) + 1;
						}
					}
					sum_width = sum_width + width + 26;
				}
			});
			var back_width = 0;
			for(var i = first_index -1; i <= last_index -1; i++)
			{
				var li = div_li.eq(i);
				back_width = back_width + li.width() + 26;
			}
			return back_width;
		};
		
		
		function private_tour_add_tab(obj)
		{
			var tab_index = -1;
			$(obj).prev().prev().find("ul li").each(function(){
				if($(this).attr("old_index") > tab_index)
				{
					tab_index = parseInt($(this).attr("old_index"));
				}
			});
			tab_index += 1;
			var booking_id = $(obj).parent().attr("id");
			var blocker;
			$.ajax({
				url: "${uDynamicTab.ajaxCgi}",
				data: {
					type: "private_tour_add_tab",
					tab_index: tab_index,
					booking_id: booking_id
				},
				beforeSend: function() {
					blocker = dispaly_sc_fade_block();
				},
				success: function(data) {
					if(data.match(/\berror\b/i))
					{
						alert(data);
					}
					else
					{
						data = eval("(" + data + ")");
						var li_html = data.li_html;
						var div_html = data.div_html;
						var day = data.day;
						$(obj).prev().prev().find("ul").append(li_html);
						$(obj).parent().next().append(div_html);
						change_button_state($(obj).prev().prev().find("ul").get(0));
						while(!$(obj).prev().hasClass("disable_right_scroll"))
						{
							$(obj).prev().click();
						}
						$(obj).prev().prev().find("ul li:last").click();
						enable_daily_content_box($("#trip_plan_day_" + day).get());
					}
				},
				complete: function() {
					if(blocker)
					{
						$(blocker).remove();
					}
				}
			});
		}
		</script>
		<script type="text/javascript">
			$("#${uDynamicTab.id} .scrol").sortable({
				receive: function(event, ui) {
				},
				update: function(event, ui) {
					process_private_tour_days(ui.item, 1);
				},
				over: function(event, ui) {
				},
				out: function(event, ui) {
				},
				stop: function(event, ui) {			
				}
			});
		</script>
</#macro>