<@page.html> 
	<form method="post" action="${controlDomain}/forgot_password.do" id="forgot_password" name="forgot_password">
	注册使用的邮箱/手机:<input type="text" id="accountId" name="accountId"></br>
	现在使用的邮箱/手机:<input type="text" id="newAccountId" name="newAccountId">(相同可不填)</br>
	描述:<input type="textarea" id="content" name="content"></br>
	(请将您的注册时间，任务记录，曾填写的身份信息等提交以便人工审核，工作人员会在1-2个工作日内与您联系)
	<input type="submit" value="提交">
	</form>
	<a href="${controlDomain}/register.shtml">注册新账号</a>
</@page.html>