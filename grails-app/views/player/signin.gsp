<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main">
    <title>Signin ChessMind</title>
</head>
<body>
<div id="signin-player" class="content scaffold-create" role="main">
    <h1>Sign In</h1>
    <g:if test="${flash.message}">
        <div class="message" role="status">${flash.message}</div>
    </g:if>
    <g:if test="${flash.error}">
        <div class="errors" role="status"><li>${flash.error}</li></div>
    </g:if>
    <g:hasErrors bean="${playerInstance}">
        <ul class="errors" role="alert">
            <g:eachError bean="${playerInstance}" var="error">
                <li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
            </g:eachError>
        </ul>
    </g:hasErrors>
    <g:form url="[resource:playerInstance, action:'signinsave']" >
        <fieldset class="form">
            <g:render template="form_signin"/>
        </fieldset>
        <fieldset class="buttons">
            <g:submitButton name="signin" class="save" value="${"Sign In"}" />
        </fieldset>
    </g:form>
</div>
</body>
</html>
