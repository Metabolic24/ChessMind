<!DOCTYPE html>
<!--[if lt IE 7 ]> <html lang="en" class="no-js ie6"> <![endif]-->
<!--[if IE 7 ]>    <html lang="en" class="no-js ie7"> <![endif]-->
<!--[if IE 8 ]>    <html lang="en" class="no-js ie8"> <![endif]-->
<!--[if IE 9 ]>    <html lang="en" class="no-js ie9"> <![endif]-->
<!--[if (gt IE 9)|!(IE)]><!--> <html lang="en" class="no-js"><!--<![endif]-->
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <title><g:layoutTitle default="Grails"/></title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="shortcut icon" href="${resource(dir: 'images', file: 'favicon.ico')}" type="image/x-icon">
    <link rel="apple-touch-icon" href="${resource(dir: 'images', file: 'apple-touch-icon.png')}">
    <link rel="apple-touch-icon" sizes="114x114" href="${resource(dir: 'images', file: 'apple-touch-icon-retina.png')}">
    <link rel="stylesheet" href="${resource(dir: 'css', file: 'main.css')}" type="text/css">
    <link rel="stylesheet" href="${resource(dir: 'css', file: 'mobile.css')}" type="text/css">
    <s2ui:resources module='spring-security-ui'/>
    <g:layoutHead/>
    <g:javascript library="application"/>
    <r:layoutResources/>
</head>

<body>
<div id="grailsLogo" role="banner"><a href="http://grails.org"><img
        src="${resource(dir: 'images', file: 'grails_logo.png')}" alt="Grails"/></a></div>
<div id='s2ui_header_body'>

    <span id='s2ui_login_link_container'>

        <nobr>
            <div id='loginLinkContainer'>
                <sec:ifLoggedIn>
                    Logged in as <sec:username/> (<g:link controller='logout'>Logout</g:link>)
                </sec:ifLoggedIn>
                <sec:ifNotLoggedIn>
                    <a href='#' id='loginLink'>Login</a>
                </sec:ifNotLoggedIn>

                <sec:ifSwitched>
                    <a href='${request.contextPath}/j_spring_security_exit_user'>
                        Resume as <sec:switchedUserOriginalUsername/>
                    </a>
                </sec:ifSwitched>
            </div>
        </nobr>

    </span>
</div>
<g:layoutBody/>
<div class="footer" role="contentinfo"></div>

<div id="spinner" class="spinner" style="display:none;"><g:message code="spinner.alt" default="Loading&hellip;"/></div>
<r:layoutResources/>
<g:render template='/includes/ajaxLogin' plugin='spring-security-ui'/>
<s2ui:showFlash/>
</body>
</html>
