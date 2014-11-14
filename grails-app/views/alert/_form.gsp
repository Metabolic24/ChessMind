<%@ page import="alert.Alert" %>



<div class="fieldcontain ${hasErrors(bean: alertInstance, field: 'description', 'error')} required">
	<label for="description">
		<g:message code="alert.description.label" default="Description" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="description" required="" value="${alertInstance?.description}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: alertInstance, field: 'problem', 'error')} required">
	<label for="problem">
		<g:message code="alert.problem.label" default="Problem" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="problem" name="problem.id" from="${problems.Problem.list()}" optionKey="id" required="" value="${alertInstance?.problem?.id}" class="many-to-one"/>

</div>

<div class="fieldcontain ${hasErrors(bean: alertInstance, field: 'user', 'error')} required">
	<label for="user">
		<g:message code="alert.user.label" default="User" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="user" name="user.id" from="${users.User.list()}" optionKey="id" required="" value="${alertInstance?.user?.id}" class="many-to-one"/>

</div>

