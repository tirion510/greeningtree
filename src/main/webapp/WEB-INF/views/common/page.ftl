<#macro html>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<!--[if IE 8 ]> <html lang="en" class="ie8"> <![endif]-->
<!--[if IE 9 ]> <html lang="en" class="ie9"> <![endif]-->
<!--[if (gt IE 9)|!(IE)]><!--> <html lang="en"> <!--<![endif]-->
 <html>
	 <head>
	    <meta http-equiv="Content-Type" content="text/html; charset=${charset}"/>
	    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
	    <meta charset="utf-8"/>
	    <base href="${basePath}" />
		<title>${title}</title>
		<meta name="keywords" content="${keywords}"/>
		<meta name="description" content="${description}"/>
		<link rel="shortcut icon" href="${ico}" type="image/x-icon"/>	
		<link href="${basePath}css/1140.css" rel="stylesheet"/>
		<link href="${basePath}css/normalize.css" rel="stylesheet"/>
		<link href="${basePath}css/jquery-ui.css" rel="stylesheet"/>
		<link href="${basePath}css/styles.css" rel="stylesheet" media="all"/>
		<script src="${basePath}js/jquery-1.8.2.min.js"></script>
		<script src="${basePath}js/jquery-ui.min.js"></script>
		<script src="${basePath}js/jquery.idealforms.js" charset="gbk"></script>
		<script src="${basePath}js/form.js"></script>
	 </head>
	 <body>
		<@form_page.page_header/>
	 	<#nested>
	 	<@form_page.page_bottom/>
	 </body>
 </html>
 </#macro>