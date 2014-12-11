<html>
<head>
    <title><g:layoutTitle default="ChessMind" /></title>
    <link rel="stylesheet" href="${resource(dir:'css',file:'main.css')}" />
    <link rel="stylesheet" href="${resource(dir:'css',file:'jqModal.css')}" />
    <link rel="shortcut icon" type="image/x-icon"
          href="${resource(dir:'images',file:'favicon.ico')}" />
    <g:layoutHead />
    <g:javascript library="jquery"/>
    <r:layoutResources />
</head>

<body>

<div id="spinner" class="spinner" style="display:none;">
    <img src="${resource(dir:'images',file:'spinner.gif')}" alt="Spinner" />
</div>

<div id="grailsLogo" class="logo">
    <a href="${createLink(uri: '/problem/valid_problems')}">
        <img src="${resource(dir:'images',file:'grails_logo.png')}" alt="Grails" border="0" />
    </a>

    <span id='loginLink' style='position: relative; margin-right: 30px; float: right; line-height: 0%; top: 10px'>
        <sec:ifLoggedIn>
            <div style="margin-bottom: 0px">
                Connecté en tant que<g:link controller="user" action="showMyProfile"><sec:username/></g:link>(<g:link controller='logout'>Déconnexion</g:link>)
            </div>
        </sec:ifLoggedIn>
        <sec:ifNotLoggedIn>
            <a href='#' onclick='showLogin(); return false;'>Connexion</a>
        </sec:ifNotLoggedIn>
    </span>

</div>
<!-- http://dev.iceburg.net/jquery/jqModal/ -->
<g:javascript src='jqModal.js' />

<g:render template='/includes/ajaxLogin'/>

<div class="nav" role="navigation">
    <ul><g:render template="/includes/commonMenu"/></ul>
</div>
<g:layoutBody />
<r:layoutResources />
</body>
</html>