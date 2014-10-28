
<%@ page import="users.Moderator" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'moderator.label', default: 'Moderator')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-moderator" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
                <li><g:link class="create" action="create"><g:message code="default.new.label" args="['User']" /></g:link></li>
                <li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
                <li><g:link class="list" action="index"><g:message code="default.list.label" args="['User']" /></g:link></li>
                <li><g:link class="list" action="moderators"><g:message code="default.list.label" args="['Moderator']" /></g:link></li>
			</ul>
		</div>
		<div id="show-moderator" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list moderator">
			
				<g:if test="${moderatorInstance?.name}">
				<li class="fieldcontain">
					<span id="name-label" class="property-label"><g:message code="moderator.name.label" default="Name" /></span>
					
						<span class="property-value" aria-labelledby="name-label"><g:fieldValue bean="${moderatorInstance}" field="name"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${moderatorInstance?.username}">
				<li class="fieldcontain">
					<span id="username-label" class="property-label"><g:message code="moderator.username.label" default="username" /></span>
					
						<span class="property-value" aria-labelledby="username-label"><g:fieldValue bean="${moderatorInstance}" field="username"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${moderatorInstance?.password}">
				<li class="fieldcontain">
					<span id="password-label" class="property-label"><g:message code="moderator.password.label" default="Password" /></span>
					
						<span class="property-value" aria-labelledby="password-label"><g:fieldValue bean="${moderatorInstance}" field="password"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${moderatorInstance?.description}">
				<li class="fieldcontain">
					<span id="description-label" class="property-label"><g:message code="moderator.description.label" default="Description" /></span>
					
						<span class="property-value" aria-labelledby="description-label"><g:fieldValue bean="${moderatorInstance}" field="description"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${moderatorInstance?.score}">
				<li class="fieldcontain">
					<span id="score-label" class="property-label"><g:message code="moderator.score.label" default="Score" /></span>

                    <span class="property-value" aria-labelledby="score-label">${fieldValue(bean: moderatorInstance, field: "score.score1")} / ${fieldValue(bean: moderatorInstance, field: "score.score2")}</span>
					
				</li>
				</g:if>
			
				<g:if test="${moderatorInstance?.mail}">
				<li class="fieldcontain">
					<span id="mail-label" class="property-label"><g:message code="moderator.mail.label" default="Mail" /></span>
					
						<span class="property-value" aria-labelledby="mail-label"><g:fieldValue bean="${moderatorInstance}" field="mail"/></span>
					
				</li>
				</g:if>
			
			</ol>
			<g:form url="[resource:moderatorInstance, action:'delete']" method="DELETE">
				<fieldset class="buttons">
					<g:link class="edit" action="edit" resource="${moderatorInstance}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
