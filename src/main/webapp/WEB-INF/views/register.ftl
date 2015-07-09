<@page.html> 
<div class="site clearfix" role="main">
	<div id="site-container" class="context-loader-container" data-pjax-container="">
		<div id="login" class="auth-form">
			<form class="register_form" method="post" action="register.do" accept-charset="UTF-8">
				<div style="margin:0;padding:0;display:inline">
					<input type="hidden" id="token" name="token" value="${token}">
				</div>
				<div class="auth-form-header">
					<h1><@spring.message "register"/></h1>
				</div>
				<div class="auth-form-body">
					<#if errorCode?exists>
						<label for="login_field"><font color="red"> <@spring.message "error_content"+errorCode/> </font></label></br>
					</#if>
					<dl class="form ideal-wrap">
						<dt>
							<label for="login_field"> <@spring.message "email"/></label>
						</dt>
						<dd>
							<input id="email" class="input-block" type="text" tabindex="1" name="email" autofocus="autofocus" autocorrect="off" autocapitalize="off">
						</dd>
					</dl>
					<dl class="form ideal-wrap">
						<dt>
							<label for="login_field"> <@spring.message "username"/></label>
						</dt>
						<dd>
							<input id="username" class="input-block" type="text" tabindex="2" name="username" autofocus="autofocus" autocorrect="off" autocapitalize="off">
						</dd>
					</dl>
					<dl class="form ideal-wrap">
						<dt>
							<label for="password"><@spring.message "password"/></label>
						</dt>
						<dd>
							<input id="password" class="input-block" type="password" tabindex="3" name="password">
						</dd>
					</dl>
					<dl class="form ideal-wrap">
						<dt>
							<label for="password"><@spring.message "re_password"/></label>
						</dt>
						<dd>
							<input id="rePassword" class="input-block" type="password" tabindex="4" name="rePassword" data-copy-with="password">
						</dd>
					</dl>
					<input class="btn" type="submit" value="<@spring.message "register"/>" tabindex="5" name="commit" data-disable-with="<@spring.message "register"/>..." onclick="return submitRegister(this);">
				</div>
			</form>
			<script>
				buttonAbled();
			</script>
		</div>
	</div>
</div>
<script type="text/javascript">
	var checkArray = ['email','username','password','rePassword'];
	
	var ideals_options = {
		'email': {
        	filters: 'required email',
      	},
      	'username': {
        	filters: 'required username',
        	data: {
          		ajax: { url:'usernameValidateExist' }
        	}
      	},
		'password': {
        	filters: 'required pass',
      	},
      	'rePassword': {
        	filters: 'required pass',
      	},
	}
	idealform_init(checkArray,ideals_options,false);
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
	
	function submitRegister(obj){
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