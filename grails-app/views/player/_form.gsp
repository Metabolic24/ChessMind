<%@ page import="users.Player" %>



<div class="fieldcontain ${hasErrors(bean: playerInstance, field: 'name', 'error')} required">
	<label for="name">
		<g:message code="player.name.label" default="Name" />
	</label>
	<g:textField name="name" value="${playerInstance?.name}"/>

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

<div class="fieldcontain ${hasErrors(bean: playerInstance, field: 'description', 'error')} ">
	<label for="description">
		<g:message code="player.description.label" default="Description" />
		
	</label>
	<g:textField name="description" value="${playerInstance?.description}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: playerInstance, field: 'score', 'error')} required">
	<label for="score">
		<g:message code="player.score.label" default="Score" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="score" name="score.id" from="${users.Score.list()}" optionKey="id" required="" value="${playerInstance?.score?.id}" class="many-to-one"/>

</div>

<div class="fieldcontain ${hasErrors(bean: playerInstance, field: 'mail', 'error')} required">
	<label for="mail">
		<g:message code="player.mail.label" default="Mail" />
		<span class="required-indicator">*</span>
	</label>
	<g:field type="email" name="mail" required="" value="${playerInstance?.mail}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: playerInstance, field: 'moderator', 'error')} ">
	<label for="moderator">
		<g:message code="player.moderator.label" default="Moderator" />
		
	</label>
	<g:checkBox name="moderator" value="${playerInstance?.isModerator()}" disable="${playerInstance?.isAdministrator()}" />

</div>