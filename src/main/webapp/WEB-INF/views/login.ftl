<@page.html> 
<div class="site clearfix" role="main">
	<div id="site-container" class="context-loader-container" data-pjax-container="">
		<div id="login" class="auth-form">
			<form method="post" action="login.do" accept-charset="UTF-8">
				<div style="margin:0;padding:0;display:inline">
					<input type="hidden" id="token" name="token" value="${token}">
				</div>
				<div class="auth-form-header">
					<h1><@spring.message "login"/></h1>
				</div>
				<div class="auth-form-body">
					<#if errorCode?exists>
						<label for="login_field"><font color="red"> <@spring.message "error_content"+errorCode/> </font></label></br>
					</#if>
					<label for="login_field"> <@spring.message "email"/> </label>
					<input id="email" class="input-block" type="text" tabindex="1" name="email" autofocus="autofocus" autocorrect="off" autocapitalize="off">
					<label for="password">
						<@spring.message "password"/>
						<a href="forgot_password.shtml">(<@spring.message "forgot_password"/>)</a>
					</label>
					<input id="password" class="input-block" type="password" tabindex="2" name="password">
					<input class="btn" type="submit" value="<@spring.message "login"/>" tabindex="3" name="commit" data-disable-with="<@spring.message "login"/>..." onclick="return buttonSubmit(this);">
				</div>
			</form>
			<script>
			buttonAbled();
		</script>
		</div>
	</div>
</div>
</@page.html>