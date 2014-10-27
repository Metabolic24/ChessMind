<%@ page import="users.Administrator" %>



<div class="fieldcontain ${hasErrors(bean: administratorInstance, field: 'name', 'error')} required">
	<label for="name">
		<g:message code="administrator.name.label" default="Name" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="name" required="" value="${administratorInstance?.name}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: administratorInstance, field: 'username', 'error')} required">
	<label for="login">
		<g:message code="administrator.login.label" default="Login" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="login" required="" value="${administratorInstance?.login}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: administratorInstance, field: 'password', 'error')} required">
	<label for="password">
		<g:message code="administrator.password.label" default="Password" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="password" required="" value="${administratorInstance?.password}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: administratorInstance, field: 'description', 'error')} ">
	<label for="description">
		<g:message code="administrator.description.label" default="Description" />
		
	</label>
	<g:textField name="description" value="${administratorInstance?.description}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: administratorInstance, field: 'mail', 'error')} required">
	<label for="mail">
		<g:message code="administrator.mail.label" default="Mail" />
		<span class="required-indicator">*</span>
	</label>
	<g:field type="email" name="mail" required="" value="${administratorInstance?.mail}"/>

</div>