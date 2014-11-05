<%@ page import="problems.Problem" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main">
    <g:set var="entityName" value="${message(code: 'problem.label', default: 'Problem')}" />
    <title><g:message code="default.edit.label" args="[entityName]" /></title>
</head>
<body>
<a href="#edit-problem" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
<div class="nav" role="navigation">
    <ul>
        <li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
        <li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
        <sec:ifAnyGranted roles='ROLE_ADMIN, ROLE_MODERATOR'>
            <li><g:link class="list" action="index"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
            <li><g:link action="problems_to_validate"><g:message code="Problems to validate" args="[entityName]" /></g:link></li>
        </sec:ifAnyGranted>
        <li><g:link action="valid_problems"><g:message code="All valids problems"  args="[entityName]" /></g:link></li>
        <li><g:link action="my_problems"><g:message code="My problems"  args="[entityName]" /></g:link></li>
    </ul>
</div>
<div id="edit-problem" class="content scaffold-edit" role="main">
    <h1><g:message code="default.edit.label" args="[entityName]" /></h1>
    <g:if test="${flash.message}">
        <div class="message" role="status">${flash.message}</div>
    </g:if>
    <g:hasErrors bean="${problemInstance}">
        <ul class="errors" role="alert">
            <g:eachError bean="${problemInstance}" var="error">
                <li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
            </g:eachError>
        </ul>
    </g:hasErrors>
    <g:form url="[resource:problemInstance, action:'update']" method="POST"  enctype="multipart/form-data">
        <g:hiddenField name="version" value="${problemInstance?.version}" />
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
