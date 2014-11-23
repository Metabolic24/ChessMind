<%@ page import="problems.Solution" %>



<div class="fieldcontain ${hasErrors(bean: solutionInstance, field: 'answer', 'error')} required">
	<label for="answer">
		<g:message code="solution.answer.label" default="Answer" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="answer" required="" value="${solutionInstance?.answer}"/>

</div>