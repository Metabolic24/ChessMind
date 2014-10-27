<%@ page import="users.Player" %>



<div class="fieldcontain ${hasErrors(bean: playerInstance, field: 'mail', 'error')} required">
    <label for="mail">
        <g:message code="player.mail.label" default="Mail" />
        <span class="required-indicator">*</span>
    </label>
    <g:field type="email" name="mail" required="" value="${playerInstance?.mail}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: playerInstance, field: 'username', 'error')} required">
    <label for="username">
        <g:message code="player.login.username" default="Username" />
        <span class="required-indicator">*</span>
    </label>
    <g:textField name="username" required="" value="${playerInstance?.username}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: playerInstance, field: 'password', 'error')} required">
    <label for="password">
        <g:message code="player.password.label" default="Password" />
        <span class="required-indicator">*</span>
    </label>
    <g:textField name="password" required="" value="${playerInstance?.password}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: playerInstance, field: 'confirmpassword', 'error')} required">
    <label for="password">
        <g:message code="player.password.label" default="Confirm Password" />
        <span class="required-indicator">*</span>
    </label>
    <g:textField name="confirmPassword" required=""/>

</div>