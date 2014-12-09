<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main">
    <g:set var="entityName" value="${message(code: 'alert.label', default: 'Alert')}"/>
</head>

<body>
<a href="#create-alert" class="skip" tabindex="-1"><g:message code="default.link.skip.label"
                                                              default="Skip to content&hellip;"/></a>

<div id="create-alert" class="content scaffold-create" role="main">
    <h1>Créer une alerte</h1>
    <g:if test="${flash.message}">
        <div class="message" role="status">${flash.message}</div>
    </g:if>
    <g:hasErrors bean="${alertInstance}">
        <ul class="errors" role="alert">
            <g:eachError bean="${alertInstance}" var="error">
                <li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message
                        error="${error}"/></li>
            </g:eachError>
        </ul>
    </g:hasErrors>
    <g:form url="[resource: alertInstance, action: 'save']">
        <g:textArea name="description" value="${comment}" rows="5" columns="30"/>
        <g:if test="${params.problemId != null}">
            <g:hiddenField name="problemId" value="${params.problemId}"/>
        </g:if>
        <g:else>
            <g:hiddenField name="commentId" value="${params.commentId}"/>
        </g:else>
        <fieldset class="buttons">
            <g:submitButton name="create" class="save"
                            value="${message(code: 'default.button.create.label', default: 'Create')}"/>
        </fieldset>
    </g:form>
</div>
</body>
</html>
