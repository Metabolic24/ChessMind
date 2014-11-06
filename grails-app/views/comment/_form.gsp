<%@ page import="problems.Comment" %>



<div class="fieldcontain ${hasErrors(bean: commentInstance, field: 'text', 'error')} required">
	<label for="text">
		<g:message code="comment.text.label" default="Text" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="text" required="" value="${commentInstance?.text}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: commentInstance, field: 'solution', 'error')} required">
	<label for="solution">
		<g:message code="comment.solution.label" default="Solution" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="solution" name="solution.id" from="${problems.Solution.list()}" optionKey="id" required="" value="${commentInstance?.solution?.id}" class="many-to-one"/>

</div>

<div class="fieldcontain ${hasErrors(bean: commentInstance, field: 'user', 'error')} required">
	<label for="user">
		<g:message code="comment.user.label" default="User" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="user" name="user.id" from="${users.User.list()}" optionKey="id" required="" value="${commentInstance?.user?.id}" class="many-to-one"/>

</div>

