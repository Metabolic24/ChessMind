<%@ page import="score.Score" %>



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

<div class="fieldcontain ${hasErrors(bean: scoreInstance, field: 'user', 'error')} required">
	<label for="player">
		<g:message code="score.player.label" default="Player" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="player" name="player.id" from="${users.Player.list()}" optionKey="id" required="" value="${scoreInstance?.player?.id}" class="many-to-one"/>

</div>

