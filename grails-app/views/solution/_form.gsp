<%@ page import="problems.Solution" %>



<div class="fieldcontain ${hasErrors(bean: solutionInstance, field: 'answer', 'error')} required">
	<label for="answer">
		<g:message code="solution.answer.label" default="Answer" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="answer" required="" value="${solutionInstance?.answer}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: solutionInstance, field: 'player', 'error')} required">
	<label for="player">
		<g:message code="solution.player.label" default="Player" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="player" name="player.id" from="${users.User.list()}" optionKey="id" required="" value="${solutionInstance?.player?.id}" class="many-to-one"/>

</div>

<div class="fieldcontain ${hasErrors(bean: solutionInstance, field: 'problem', 'error')} required">
	<label for="problem">
		<g:message code="solution.problem.label" default="Problem" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="problem" name="problem.id" from="${problems.Problem.list()}" optionKey="id" required="" value="${solutionInstance?.problem?.id}" class="many-to-one"/>

</div>

