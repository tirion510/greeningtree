<#macro page_setting_left selectedLink>
	<div class="column one-fourth" role="navigation">
		<nav class="menu" data-pjax="">
			<h3 class="menu-heading"> Personal settings </h3>
			<a class="<#if selectedLink == 'profile'>selected </#if>js-selected-navigation-item menu-item" data-selected-links="avatar_settings /setting/profile" href="setting/profile.shtml"><@spring.message "profile"/></a>
			<a class="<#if selectedLink == 'myOasis'>selected </#if>js-selected-navigation-item menu-item" data-selected-links="avatar_settings /setting/myOasis" href="setting/myOasis.shtml"><@spring.message "MyOasis"/></a>
			<a class="js-selected-navigation-item menu-item" data-selected-links=" /settings/admin" href="/settings/admin">Account settings</a>
			<a class="js-selected-navigation-item menu-item" data-selected-links=" /settings/emails" href="/settings/emails"> Emails </a>
			<a class="js-selected-navigation-item menu-item" data-selected-links=" /settings/notifications" href="/settings/notifications">Notification center</a>
			<a class="js-selected-navigation-item menu-item" data-selected-links="user_billing_settings /settings/billing" href="/settings/billing">Billing</a>
			<a class="js-selected-navigation-item menu-item" data-selected-links=" /settings/ssh" href="/settings/ssh">SSH keys</a>
			<a class="js-selected-navigation-item menu-item" data-selected-links=" /settings/security" href="/settings/security">Security</a>
			<a class="js-selected-navigation-item menu-item" data-selected-links="applications_settings /settings/applications" href="/settings/applications">Applications</a>
			<a class="js-selected-navigation-item menu-item" data-selected-links="oauth_tokens /settings/tokens" href="/settings/tokens">Personal access tokens</a>
			<a class="js-selected-navigation-item menu-item" data-selected-links=" /settings/repositories" href="/settings/repositories">Repositories</a>
			<a class="js-selected-navigation-item menu-item" data-selected-links=" /settings/organizations" href="/settings/organizations">Organizations</a>
		</nav>
	</div>
</#macro>