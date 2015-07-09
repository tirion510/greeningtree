<#macro silde_tab uSlideTab>
	<#if uSlideTab?exists>
	<#local pr_tab_menu_class="xxk">
	<#if uSlideTab.language=="cn">
		<#local pr_tab_menu_class="xxk1">
	</#if>
	<#local div_class="xxk_content">
	<#if uSlideTab.type?? && uSlideTab.type == 1>
		<#local pr_tab_menu_class="xxk2">
		<#local div_class="xxk2_content">
	</#if>
	<#if uSlideTab.tabMenuClass??>
		<#local uSlideTab = uSlideTab + {"tabMenuClass":(pr_tab_menu_class+" "+uSlideTab.tabMenuClass)}>
	<#else>
		<#local uSlideTab = uSlideTab + {"tabMenuClass":pr_tab_menu_class}>
	</#if>
	<div style="left:0;top:0;height:31px;clear:both;overflow:hidden;position:relative;width:100%">
		<div class="left_scroll"></div>
	    <div style="float:left;overflow:hidden;position:relative">
			<ul style="width:2000px;left:0px;" class="scrol tab_menu no_list_style fixfloat ${uSlideTab.tabMenuClass}">
				<#list uSlideTab.tabList as tab>
					<#local class_html="">
					<#if tab.tabIsActive>
						<#local class_html="active">
					</#if>
					<li class="${class_html}" ${tab.event} ${tab.attrs}>${tab.title}</li>
				</#list>
			</ul>
	    </div>
	    <div class="right_scroll"></div>
	</div>
	<div class="tab_box ${div_class}">
		<#list uSlideTab.tabList as tab>
			<#local style_html="style='display: none;'">
			<#if tab.tabIsActive>
				<#local style_html="style='display: block;'">
			</#if>
			<div ${style_html}>
				${tab.content}
			</div>
		</#list>
	</div>
	<script type="text/javascript">
			$(document).ready(function(){
				$(".scrol.tab_menu").bind('slidetab',function(){
						if(!$(this).is(":visible") || $(this).attr("has_slide_tab"))
						{
							return false;
						}
						$(this).attr("has_slide_tab", true);
						var ul = $(this);
				  	var div_li = ul.find("li");			
				  	var first_li = div_li.eq(0);
			   		var max_width = ul.parent().parent().width() - 56;
						var len = div_li.length;
		   			var ul_parent = ul.parent();
		   			var title_obj = ul_parent.parent();
						ul.pre_set_ul_parent_width = function(){
							var sum_width = 0;
							var left = ul.css('left');
							left.replace("px","");
							left = parseInt(left);						
							div_li.each(function(){
								var width = $(this).width();
								var left_w = sum_width + width + 26;
								var right_w = max_width - left;
								if(left_w < right_w)
								{
									sum_width = sum_width + width + 26;
								}
							});
							sum_width += left;
							ul_parent.width(sum_width);
						};
						ul.active_index = function(){
							var the_index = 0;
							div_li.each(function(){
								if($(this).hasClass('active'))
								{
									 the_index = div_li.index(this);
									 return false;
								}
							});
							return the_index + 1;
						};
						ul.pre_set_ul_parent_width();
						ul.next_li_index = function(){
							var ul_parent_width = ul_parent.width();
							var left = ul.css('left');
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
						ul.back_width = function(){
							var left = ul.css('left');
							left.replace("px","");
							left = parseInt(left);
							var total = 0 - left;
							var sum_width = 0;
							var last_index = 0;
							var first_index = 0;
							var temp_sum_width = 0;
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
						ul.first_li_click = function(){
							var left = ul.css('left');
							left.replace("px","");
							left = parseInt(left);
							var total = 0 - left;
							var sum_width = 0;
							var first_index = 0;
							div_li.each(function(){
								var width = $(this).width();
								sum_width = sum_width + width + 26;
								if(sum_width > total)
								{
									first_index = div_li.index(this);
									return false; 
								}
							});
							var li = div_li.eq(first_index).click();
						};
				  	div_li.click(function(){
			     		$(this).addClass("active").siblings().removeClass("active");
					    var div_index = div_li.index(this);
					    ul.parent().parent().next().children("div").eq(div_index).show().siblings().hide();
					    if($(this).attr('callback'))
					    {
					    	eval($(this).attr('callback'));
					    }
					    ${uSlideTab.bindClick}
					  }).hover(function(){
			        $(this).addClass("hover");
			   		},function(){
			 		    $(this).removeClass("hover");
			 			});
			    	title_obj.find(".right_scroll").click(function(){
			        if (!ul.is(":animated")) 
			        {
	              ul.animate({left: "-=" + ul.parent().width() + "px"}, 0, undefined, function(){
	              	ul.pre_set_ul_parent_width();
	              	title_obj.find(".left_scroll").show();
	              	if (ul.next_li_index() > len) 
			            {
		                ul.stop();
		                title_obj.find(".right_scroll").hide();
			            } 
			            ul.first_li_click();
	              });
			        }
				    });
				    title_obj.find(".left_scroll").click(function() {
			        if (!ul.is(":animated"))
			        {
	            	ul.animate({left: "+=" + ul.back_width() + "px"}, 0, undefined, function(){
	            		ul.pre_set_ul_parent_width();
	            		title_obj.find(".right_scroll").show();
	            		if(first_li.is(":visible"))
		              {
		              	title_obj.find(".left_scroll").hide();
		              }
		              ul.first_li_click();
	            	});
			        }
				    });
				    var active_index = ul.active_index(); 
				    ul.pre_set_active = function(){
				    	if(ul.next_li_index() > len)
				    	{
				    		title_obj.find(".right_scroll").hide();
				    	}
				    	if(ul.next_li_index() > active_index)
							{
								title_obj.find(".left_scroll").hide();
							}
							else
							{
								while(ul.next_li_index() <= active_index)
								{
									 ul.animate({left: "-=" + ul.parent().width() + "px"}, 0, undefined, function(){
		              	ul.pre_set_ul_parent_width();
		              	title_obj.find(".left_scroll").show();
		              	if (ul.next_li_index() > len) 
				            {
			                ul.stop();
			                title_obj.find(".right_scroll").hide();
				            } 
		              });
								}
							}
				    };
				    ul.pre_set_active();
				 });
				$(".scrol,.tab_menu").trigger("slidetab");
		});
		</script>
	</#if>
</#macro>