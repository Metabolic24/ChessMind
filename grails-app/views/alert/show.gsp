
<%@ page import="alert.Alert" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'alert.label', default: 'Alert')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-alert" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="custom_index"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
                <li><a class="problem" href="${createLink(uri: '/problem/index')}"><g:message code="Problem List"/></a></li>
                <li><a class="problem" href="${createLink(uri: '/problem/problems_to_validate')}"><g:message code="Problems to validate"/></a></li>
                <li><a class="problem" href="${createLink(uri: '/problem/valid_problems')}"><g:message code="All valids problems"/></a></li>
                <li><a class="problem" href="${createLink(uri: '/problem/my_problems')}"><g:message code="My problems"/></a></li>
			</ul>
		</div>
		<div id="show-alert" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list alert">
			
				<g:if test="${alertInstance?.description}">
				<li class="fieldcontain">
					<span id="description-label" class="property-label"><g:message code="alert.description.label" default="Description" /></span>
					
						<span class="property-value" aria-labelledby="description-label"><g:fieldValue bean="${alertInstance}" field="description"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${alertInstance?.problem}">
				<li class="fieldcontain">
					<span id="problem-label" class="property-label"><g:message code="alert.problem.label" default="Problem" /></span>
					
						<span class="property-value" aria-labelledby="problem-label"><g:link controller="problem" action="show" id="${alertInstance?.problem?.id}">${alertInstance?.problem?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${alertInstance?.user}">
				<li class="fieldcontain">
					<span id="user-label" class="property-label"><g:message code="alert.user.label" default="User" /></span>
					
						<span class="property-value" aria-labelledby="user-label"><g:link controller="user" action="show" id="${alertInstance?.user?.id}">${alertInstance?.user?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
			</ol>
			<g:form url="[resource:alertInstance, action:'delete']" method="DELETE">
				<fieldset class="buttons">
					<g:link class="edit" action="edit" resource="${alertInstance}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
