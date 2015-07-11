<@page.html>
<div class="site clearfix" role="main">
	<div id="site-container" class="context-loader-container" data-pjax-container="">
		<div class="container">
			<div class="columns">
				<@form_page.page_setting_left selectedLink="myOasis"/>
				<div class="column three-fourths">
					<div class="boxed-group">
						<h3>My Oasis</h3>
						<div class="boxed-group-inner clearfix">
							<ul class="boxed-group-list">
								<#list settingOasis.accountOasisInfo.oasisInfos as oasisInfo>
									<div id="tf-99" class="js-topic-item topic-item zg-clear" data-id="99">
										<div class="topic-avatar">
											<a href="/oasis/${oasisInfo.oasisType.oasisTypeId}">
												<img class="topic-avatar-img" alt="" src="/images/internet.png">
											</a>
										</div>
										<div class="topic-item-content">
											<div>
												<h3 class="topic-item-title">
												<a class="topic-item-title-link" href="/oasis/${oasisInfo.oasisType.oasisTypeId}">${oasisInfo.oasisType.oasisTypeName}</a>
												<a class="zg-gray pin topic-hover-content" data-action="pin-topic" href="javascript:;">
													<i class="z-icon-pin"></i>
													set special focus
												</a>
												<a id="ft-99" class="right zg-gray unfollow topic-hover-content" data-action="unfollow" href="setting/unfocus_oasis_type.do?oasis_type_id=${oasisInfo.oasisType.oasisTypeId}"><@spring.message "Following"/></a>
												</h3>
											</div>
											<div class="topic-item-feed-digest">
												<div class="topic-feed-item">
													<a href="/question/31952696">${oasisInfo.oasisType.oasisTypeName}topic1</a>
													<span class="zg-gray time">23 seconds ago</span>
												</div>
												<div class="topic-feed-item">
													<a href="/question/22083698">${oasisInfo.oasisType.oasisTypeName}topic2</a>
													<span class="zg-gray time">3 hours ago</span>
												</div>
												<div class="topic-feed-item">
													<a href="/question/31923973">${oasisInfo.oasisType.oasisTypeName}topic3</a>
													<span class="zg-gray time">3 hours ago</span>
												</div>
												<a class="zg-link-litblue" href="/oasis/${oasisInfo.oasisType.oasisTypeId}">check all 13447 topic</a>
											</div>
										</div>
									</div>
								</#list>
								<#list settingOasis.otherOasisTypes as otherOasisType>
									<div id="tf-99" class="js-topic-item topic-item zg-clear" data-id="99">
										<div class="topic-avatar">
											<a href="/oasis/${otherOasisType.oasisTypeId}">
												<img class="topic-avatar-img" alt="" src="/images/internet.png">
											</a>
										</div>
										<div class="topic-item-content">
											<div>
												<h3 class="topic-item-title">
												<a class="topic-item-title-link" href="/oasis/${otherOasisType.oasisTypeId}">${otherOasisType.oasisTypeName}</a>
												</h3>
												<div class="right" style="margin-top: -26px;">
													<a class="btn btn-primary" style="padding: 2px 10px;" href="setting/focus_oasis_type.do?oasis_type_id=${otherOasisType.oasisTypeId}"><@spring.message "Follow"/></a>
												</div>
											</div>
											<div class="topic-item-feed-digest">
												<div class="topic-feed-item">
													<a href="/question/31952696">${otherOasisType.oasisTypeName}topic1</a>
													<span class="zg-gray time">2 seconds ago</span>
												</div>
												<div class="topic-feed-item">
													<a href="/question/22083698">${otherOasisType.oasisTypeName}topic2</a>
													<span class="zg-gray time">15 seconds ago</span>
												</div>
												<div class="topic-feed-item">
													<a href="/question/31923973">${otherOasisType.oasisTypeName}topic3</a>
													<span class="zg-gray time">18 seconds ago</span>
												</div>
												<a class="zg-link-litblue" href="/oasis/${otherOasisType.oasisTypeId}">check all 13382 topic</a>
											</div>
										</div>
									</div>
								</#list>
							</ul>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
</@page.html>