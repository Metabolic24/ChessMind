<%@ page import="users.Score" %>



<div class="fieldcontain ${hasErrors(bean: scoreInstance, field: 'score1', 'error')} required">
	<label for="score1">
		<g:message code="score.score1.label" default="Score1" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="score1" type="number" min="0" value="${scoreInstance.score1}" required=""/>

</div>

<div class="fieldcontain ${hasErrors(bean: scoreInstance, field: 'score2', 'error')} required">
	<label for="score2">
		<g:message code="score.score2.label" default="Score2" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="score2" type="number" min="0" value="${scoreInstance.score2}" required=""/>

</div>

