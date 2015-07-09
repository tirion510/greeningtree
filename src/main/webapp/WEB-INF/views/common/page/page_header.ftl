<#macro page_header>
	<header class="<#if !username?exists>header-logged-out</#if>">
		<div class="container clearfix">
			<a class="header-logo-invertocat" data-ga-click="Header, go to dashboard, icon:tree" aria-label="Homepage" data-hotkey="g d" href="https://github.com/">
				<span class="mega-octicon octicon-mark-github"></span>
			</a>
			<ul class="header-nav left" role="navigation">
				<li class="header-nav-item">
					<img class="avatar" width="20" height="20" src="/images/tree.ico">
				</li>
				<li class="header-nav-item">
					<a class="header-nav-link" data-ga-click="(Logged out) Header, go to explore, text:explore" href="">GreenningTree</a>
				</li>
			</ul>
			<div class="site-search" role="search">
				<form method="get" data-repo-search-url="" data-global-search-url="/search" action="/search" accept-charset="UTF-8">
					<input class="" type="text" autocapitalize="off" tabindex="1" placeholder="Search GreeningTree" name="q" data-hotkey="s">
				</form>
			</div>
			<#if !username?exists>
				<div class="header-actions" role="navigation">
					<a class="btn btn-primary" data-ga-click="(Logged out) Header, clicked Sign up, text:sign-up" href="register.shtml"><@spring.message "register"/></a>
					<a class="btn" data-ga-click="(Logged out) Header, clicked Sign in, text:sign-in" href="login.shtml"><@spring.message "login"/></a>
				</div>
			</#if>
			<ul class="header-nav left" role="navigation">
				<li class="header-nav-item">
					<a class="header-nav-link" data-ga-click="(Logged out) Header, go to explore, text:explore" href="">Explore</a>
				</li>
				<li class="header-nav-item">
					<a class="header-nav-link" data-ga-click="(Logged out) Header, go to explore, text:explore" href="">Blog</a>
				</li>
				<li class="header-nav-item">
					<a class="header-nav-link" data-ga-click="(Logged out) Header, go to explore, text:explore" href="">Help</a>
				</li>
			</ul>
			<#if username?exists>
			<ul id="user-links" class="header-nav user-nav right">
				<li class="header-nav-item dropdown js-menu-container">
					<a class="header-nav-link name" data-ga-click="Header, go to profile, text:username" href="/alexmomo">
						<img class="avatar" width="20" height="20" src="/images/usericon.jpg" data-user="9276604" alt="@alexmomo">
						<span class="css-truncate">
						<span class="css-truncate-target">${username}</span>
						</span>
					</a>
				</li>
				<li class="header-nav-item dropdown js-menu-container">
					<a class="header-nav-link name" data-ga-click="Header, go to profile, text:username" href="/alexmomo">
						<img class="avatar" width="20" height="20" src="/images/add.ico" data-user="9276604" alt="@alexmomo">
					</a>
				</li>
				<li class="header-nav-item dropdown js-menu-container">
					<a class="header-nav-link name" data-ga-click="Header, go to profile, text:username" href="/alexmomo">
						<img class="avatar" width="20" height="20" src="/images/mail.ico" data-user="9276604" alt="@alexmomo">
					</a>
				</li>
				<li class="header-nav-item dropdown js-menu-container">
					<a class="header-nav-link name" data-ga-click="Header, go to profile, text:username" href="setting.shtml">
						<img class="avatar" width="20" height="20" src="/images/setting.ico" data-user="9276604" alt="@alexmomo">
					</a>
				</li>
				<li class="header-nav-item dropdown js-menu-container">
					<a class="header-nav-link name" data-ga-click="Header, go to profile, text:username" href="logout.shtml">
						<img class="avatar" width="20" height="20" src="/images/exit.ico" data-user="9276604" alt="@alexmomo">
					</a>
				</li>
			</ul>
			</#if>
		</div>
	</header>
</#macro>