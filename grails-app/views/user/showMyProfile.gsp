<%@ page import="users.User" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main">
    <g:set var="entityName" value="${message(code: 'user.label', default: 'User')}"/>
    <title><g:message code="default.show.label" args="[entityName]"/></title>
</head>

<body>
<a href="#show-user" class="skip" tabindex="-1"><g:message code="default.link.skip.label"
                                                           default="Skip to content&hellip;"/></a>

<div class="nav" role="navigation">
    <ul>
        <g:render template="/includes/commonMenu" />
        <li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]"/></g:link></li>
    </ul>
</div>

<div id="show-user" class="content scaffold-show" role="main">
    <h1><g:message code="default.show.label" args="[entityName]"/></h1>
    <g:if test="${flash.message}">
        <div class="message" role="status">${flash.message}</div>
    </g:if>
    <ol class="property-list user">

        <g:if test="${userInstance?.username}">
            <li class="fieldcontain">
                <span id="username-label" class="property-label"><g:message code="user.username.label"
                                                                            default="Username"/></span>

                <span class="property-value" aria-labelledby="username-label"><g:fieldValue bean="${userInstance}"
                                                                                            field="username"/></span>

            </li>
        </g:if>
        <g:if test="${userInstance?.score}">
            <span style='position: relative; margin-right: 30px; float: right; line-height: 0%; top: 10px'>${userInstance?.score?.score1} problèmes résolus </span>
        </g:if>

        <g:if test="${userInstance?.email}">
            <li class="fieldcontain">
                <span id="email-label" class="property-label"><g:message code="user.email.label"
                                                                         default="Email"/></span>

                <span class="property-value" aria-labelledby="email-label"><g:fieldValue bean="${userInstance}"
                                                                                         field="email"/></span>
            </li>
        </g:if>

        <g:if test="${userInstance?.score}">
            <span style='position: relative; margin-right: 30px; float: right; line-height: 0%; top: 10px'>${userInstance?.score?.score2} likes </span>
        </g:if>

        <g:if test="${userInstance?.name}">
            <li class="fieldcontain">
                <span id="name-label" class="property-label"><g:message code="user.name.label" default="Name"/></span>

                <span class="property-value" aria-labelledby="name-label"><g:fieldValue bean="${userInstance}"
                                                                                        field="name"/></span>

            </li>
        </g:if>

        <g:if test="${userInstance?.description}">
            <li class="fieldcontain">
                <span id="description-label" class="property-label"><g:message code="user.description.label"
                                                                               default="Description"/></span>

                <span class="property-value" aria-labelledby="description-label"><g:fieldValue bean="${userInstance}"
                                                                                               field="description"/></span>

            </li>
        </g:if>

    </ol>
    <g:form url="[resource: userInstance, action: 'delete']" method="DELETE">
        <%--
        <fieldset class="buttons">
            <g:link class="edit" action="edit" resource="${userInstance}"><g:message code="default.button.edit.label"
                                                                                     default="Edit"/></g:link>
            <g:actionSubmit class="delete" action="delete"
                            value="${message(code: 'default.button.delete.label', default: 'Delete')}"
                            onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');"/>
        </fieldset>
        --%>
        <fieldset class="buttons">
            <g:link class="edit" action="editPassword" >Edit password</g:link>

            <g:link class="edit" action="editName" resource="${userInstance}">Edit name</g:link>

            <g:link class="edit" action="editMail" resource="${userInstance}">Edit mail</g:link>
        </fieldset>
    </g:form>
</div>
</body>
</html>
