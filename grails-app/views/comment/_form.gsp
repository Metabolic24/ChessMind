<%@ page import="problems.Comment" %>



<div class="fieldcontain ${hasErrors(bean: commentInstance, field: 'text', 'error')} required">
	<label for="text">
		<g:message code="comment.text.label" default="Text" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="text" required="" value="${commentInstance?.text}"/>

</div>

