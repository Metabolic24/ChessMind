<%@ page import="alert.Alert" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'alert.label', default: 'Alert')}" />
		<title><g:message code="default.edit.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#edit-alert" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
            <ul>
                <li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
                <li><a class="problem" href="${createLink(uri: '/problem/index')}"><g:message code="Problem List"/></a></li>
                <li><a class="problem" href="${createLink(uri: '/problem/problems_to_validate')}"><g:message code="Problems to validate"/></a></li>
                <li><a class="problem" href="${createLink(uri: '/problem/valid_problems')}"><g:message code="All valids problems"/></a></li>
                <li><a class="problem" href="${createLink(uri: '/problem/my_problems')}"><g:message code="My problems"/></a></li>
                <li><g:link class="list" action="custom_index"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
            </ul>
		</div>
		<div id="edit-alert" class="content scaffold-edit" role="main">
			<h1><g:message code="default.edit.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<g:hasErrors bean="${alertInstance}">
			<ul class="errors" role="alert">
				<g:eachError bean="${alertInstance}" var="error">
				<li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
				</g:eachError>
			</ul>
			</g:hasErrors>
			<g:form url="[resource:alertInstance, action:'update']" method="PUT" >
				<g:hiddenField name="version" value="${alertInstance?.version}" />
				<fieldset class="form">
					<g:render template="form"/>
				</fieldset>
				<fieldset class="buttons">
					<g:actionSubmit class="save" action="update" value="${message(code: 'default.button.update.label', default: 'Update')}" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
