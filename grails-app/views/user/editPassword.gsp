<%@ page import="users.User" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main">
    <g:set var="entityName" value="${message(code: 'problem.label', default: 'User')}"/>
    <title>Changing your Password</title>
</head>

<body>
<a href="#edit-problem" class="skip" tabindex="-1"><g:message code="default.link.skip.label"
                                                              default="Skip to content&hellip;"/></a>

<div class="nav" role="navigation">
    <ul>
        <li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
    </ul>
</div>

<g:if test="${flash.message}">
    <li class="errors">${flash.message}</li>
</g:if>

<g:form url="[action:'editPassword']" method="POST">

    <div class="fieldcontain required">
        <label for="newPassword">
            <g:message code="problem.newPassword.label" default="New Password"/>
        </label>
        <g:textField name="newPassword" value="" required="required"/>

    </div>

    <div class="fieldcontain required">
        <label for="confirmPassword">
            <g:message code="problem.confirmationPassword.label" default="Confirm Password"/>
        </label>
        <g:textField name="confirmPassword" value="" required="required"/>
    </div>

    <fieldset class="buttons">
        <g:actionSubmit class="save" action="editPassword" value="${message(code: 'default.button.update.label', default: 'Update')}"/>
        <g:actionSubmit class="cancel" action="showMyProfile" value="${message(code: 'default.button.cancel.label', default: 'Cancel')}" />
    </fieldset>
</g:form>

</div>
</body>
</html>
