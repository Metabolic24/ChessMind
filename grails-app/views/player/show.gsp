
<%@ page import="users.Player" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'player.label', default: 'Player')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-player" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="index"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-player" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list player">
			
				<g:if test="${playerInstance?.name}">
				<li class="fieldcontain">
					<span id="name-label" class="property-label"><g:message code="player.name.label" default="Name" /></span>
					
						<span class="property-value" aria-labelledby="name-label"><g:fieldValue bean="${playerInstance}" field="name"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${playerInstance?.login}">
				<li class="fieldcontain">
					<span id="login-label" class="property-label"><g:message code="player.login.label" default="Login" /></span>
					
						<span class="property-value" aria-labelledby="login-label"><g:fieldValue bean="${playerInstance}" field="login"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${playerInstance?.password}">
				<li class="fieldcontain">
					<span id="password-label" class="property-label"><g:message code="player.password.label" default="Password" /></span>
					
						<span class="property-value" aria-labelledby="password-label"><g:fieldValue bean="${playerInstance}" field="password"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${playerInstance?.description}">
				<li class="fieldcontain">
					<span id="description-label" class="property-label"><g:message code="player.description.label" default="Description" /></span>
					
						<span class="property-value" aria-labelledby="description-label"><g:fieldValue bean="${playerInstance}" field="description"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${playerInstance?.score}">
				<li class="fieldcontain">
					<span id="score-label" class="property-label"><g:message code="player.score.label" default="Score" /></span>
					
						<span class="property-value" aria-labelledby="score-label"><g:link controller="score" action="show" id="${playerInstance?.score?.id}">${playerInstance?.score?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${playerInstance?.mail}">
				<li class="fieldcontain">
					<span id="mail-label" class="property-label"><g:message code="player.mail.label" default="Mail" /></span>
					
						<span class="property-value" aria-labelledby="mail-label"><g:fieldValue bean="${playerInstance}" field="mail"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${playerInstance?.problems}">
				<li class="fieldcontain">
					<span id="problems-label" class="property-label"><g:message code="player.problems.label" default="Problems" /></span>
					
						<g:each in="${playerInstance.problems}" var="p">
						<span class="property-value" aria-labelledby="problems-label"><g:link controller="problem" action="show" id="${p.id}">${p?.encodeAsHTML()}</g:link></span>
						</g:each>
					
				</li>
				</g:if>
			
			</ol>
			<g:form url="[resource:playerInstance, action:'delete']" method="DELETE">
				<fieldset class="buttons">
					<g:link class="edit" action="edit" resource="${playerInstance}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
