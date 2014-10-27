<%@ page import="users.Moderator" %>



<div class="fieldcontain ${hasErrors(bean: moderatorInstance, field: 'name', 'error')} required">
	<label for="name">
		<g:message code="moderator.name.label" default="Name" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="name" required="" value="${moderatorInstance?.name}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: moderatorInstance, field: 'username', 'error')} required">
	<label for="login">
		<g:message code="moderator.login.label" default="Login" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="login" required="" value="${moderatorInstance?.login}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: moderatorInstance, field: 'password', 'error')} required">
	<label for="password">
		<g:message code="moderator.password.label" default="Password" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="password" required="" value="${moderatorInstance?.password}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: moderatorInstance, field: 'description', 'error')} ">
	<label for="description">
		<g:message code="moderator.description.label" default="Description" />
		
	</label>
	<g:textField name="description" value="${moderatorInstance?.description}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: moderatorInstance, field: 'mail', 'error')} required">
	<label for="mail">
		<g:message code="moderator.mail.label" default="Mail" />
		<span class="required-indicator">*</span>
	</label>
	<g:field type="email" name="mail" required="" value="${moderatorInstance?.mail}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: moderatorInstance, field: 'moderator', 'error')} ">
	<label for="moderator">
		<g:message code="moderator.moderator.label" default="Moderator" />
		
	</label>
	<g:checkBox name="moderator" value="${moderatorInstance?.isModerator()}" />

</div>