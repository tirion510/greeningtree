<@page.html>
<div class="site clearfix" role="main">
	<div id="site-container" class="context-loader-container" data-pjax-container="">
		<div class="container">
			<div class="columns">
				<@form_page.page_setting_left selectedLink="profile"/>
				<div class="column three-fourths">
					<div class="boxed-group">
						<h3>Public profile</h3>
						<div class="boxed-group-inner clearfix">
						<form id="profile" class="setting_form columns js-uploadable-container js-upload-avatar-image is-default" method="post" data-upload-policy-url="/upload/policies/avatars" action="setting/profile.do" accept-charset="UTF-8">
							<div class="column two-thirds">
							<dl class="form ideal-wrap">
								<dt>
									<label for="user_profile_name"><@spring.message "username"/></label>
								</dt>
								<dd>
									<input id="username" class="input-block" type="text" tabindex="1" name="username" autofocus="autofocus" autocorrect="off" autocapitalize="off" value="${profile.username}" size="30">
								</dd>
							</dl>
							<dl class="form ideal-wrap">
								<dt>
									<label for="user_profile_name"><@spring.message "Sex"/></label>
								</dt>
								<dd>
									<select id="sex" name="sex">
										<option value=0><@spring.message "unknown"/></option>
										<option value=1 <#if profile.sex == 1>selected="selected"</#if>><@spring.message "man"/></option>
										<option value=2 <#if profile.sex == 2>selected="selected"</#if>><@spring.message "women"/></option>
									</select>
								</dd>
							</dl>
							<dl class="form ideal-wrap">
								<dt>
									<label for="user_profile_location"><@spring.message "Location"/></label>
								</dt>
								<dd>
									<script type="text/javascript" src="${basePath}js/city_map.js" charset="gbk"></script>
									<select id="province" name="province" onchange="changeCity('province','city','region',1,'${profile.defaultArea}');">
									</select>
									<select id="city" name="city" onchange="changeCity('province','city','region',2,'${profile.defaultArea}');">
									</select>
									<select id="region" name="region">
									</select>
									<script type="text/javascript">
										changeCity('province','city','region',0,'${profile.defaultArea}');
									</script>
									<p class="note">
										<@spring.message "profile_location_note"/>
									</p>
								</dd>
							</dl>
							<dl class="form ideal-wrap">
								<dt>
									<label for="user_profile_name"><@spring.message "real_name"/></label>
								</dt>
								<dd>
									<input id="realName" type="text" value="${profile.realName}" size="30" name="realName">
								</dd>
							</dl>
							<dl class="form ideal-wrap">
								<dt>
									<label for="user_profile_name"><@spring.message "id_card"/></label>
								</dt>
								<dd>
									<input id="idCard" type="text" value="${profile.idCard}" size="30" name="idCard">
									<p class="note">
										<@spring.message "profile_id_card_note"/>
									</p>
								</dd>
							</dl>
							<dl class="form ideal-wrap">
								<dt>
									<label for="user_profile_name"><@spring.message "zhifubao"/></label>
								</dt>
								<dd>
									<input id="zhifubao" type="text" value="${profile.zhifubao}" size="30" name="zhifubao">
								<p class="note">
									<@spring.message "profile_zhifubao_note"/>
								</p>
								</dd>
							</dl>
							<p>
							<input class="btn btn-primary" type="submit" value="<@spring.message "update_profile"/>" tabindex="5" name="commit" data-disable-with="<@spring.message "update_profile"/>..." onclick="return submitUpdateProfile(this);">
							</p>
							</div>
							</form>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<script type="text/javascript">
	var checkArray = ['username'];
	
	var ideals_options = {
      	'username': {
        	filters: 'required username',
        	data: {
          		ajax: { url:'usernameValidateExist' },
          		defaultValue: '${profile.username}'
        	}
      	}
	}
	
	idealform_init(checkArray,ideals_options,true);
	$(function(){
		for(var i = 0;i<checkArray.length;i++){
			$('#'+checkArray[i]).focus(function(){
				checkForm($(this));
			});
			$('#'+checkArray[i]).blur(function(){
				checkForm($(this));
			});
		}
	});
	
	function submitUpdateProfile(obj){
		for(var i = 0;i<checkArray.length;i++){
			if(!$('#'+checkArray[i]+'_ideal_icon').hasClass('ideal-icon-valid')){
				$('#'+checkArray[i]).focus();
				return false;
			}
		}
		buttonSubmit(obj);
	}
</script>
</@page.html>