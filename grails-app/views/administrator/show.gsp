
<%@ page import="users.Administrator" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'administrator.label', default: 'Administrator')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-administrator" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
                <li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
                <li><g:link class="create" action="create"><g:message code="default.new.label" args="['User']" /></g:link></li>
                <li><g:link class="list" action="index"><g:message code="default.list.label" args="['User']" /></g:link></li>
                <li><g:link class="list" action="administrators"><g:message code="default.list.label" args="['Administrator']" /></g:link></li>
			</ul>
		</div>
		<div id="show-administrator" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list administrator">
			
				<g:if test="${administratorInstance?.name}">
				<li class="fieldcontain">
					<span id="name-label" class="property-label"><g:message code="administrator.name.label" default="Name" /></span>
					
						<span class="property-value" aria-labelledby="name-label"><g:fieldValue bean="${administratorInstance}" field="name"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${administratorInstance?.login}">
				<li class="fieldcontain">
					<span id="login-label" class="property-label"><g:message code="administrator.login.label" default="Login" /></span>
					
						<span class="property-value" aria-labelledby="login-label"><g:fieldValue bean="${administratorInstance}" field="login"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${administratorInstance?.password}">
				<li class="fieldcontain">
					<span id="password-label" class="property-label"><g:message code="administrator.password.label" default="Password" /></span>
					
						<span class="property-value" aria-labelledby="password-label"><g:fieldValue bean="${administratorInstance}" field="password"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${administratorInstance?.description}">
				<li class="fieldcontain">
					<span id="description-label" class="property-label"><g:message code="administrator.description.label" default="Description" /></span>
					
						<span class="property-value" aria-labelledby="description-label"><g:fieldValue bean="${administratorInstance}" field="description"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${administratorInstance?.score}">
				<li class="fieldcontain">
					<span id="score-label" class="property-label"><g:message code="administrator.score.label" default="Score" /></span>
					
						<span class="property-value" aria-labelledby="score-label"><g:link controller="score" action="show" id="${administratorInstance?.score?.id}">${administratorInstance?.score?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${administratorInstance?.mail}">
				<li class="fieldcontain">
					<span id="mail-label" class="property-label"><g:message code="administrator.mail.label" default="Mail" /></span>
					
						<span class="property-value" aria-labelledby="mail-label"><g:fieldValue bean="${administratorInstance}" field="mail"/></span>
					
				</li>
				</g:if>
			
			</ol>
			<g:form url="[resource:administratorInstance, action:'delete']" method="DELETE">
				<fieldset class="buttons">
					<g:link class="edit" action="edit" resource="${administratorInstance}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
