
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'player.label', default: 'Player')}" />
        <g:set var="playerList" value="${users.Player.list().findAll {player -> !player.isAdministrator() && !player.isModerator()}}" />

		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-player" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
                <li><g:link class="create" action="create"><g:message code="default.new.label" args="['User']" /></g:link></li>
                <li><g:link class="list" action="index"><g:message code="default.list.label" args="['User']" /></g:link></li>
                <li><g:link class="list" action="moderators"><g:message code="default.list.label" args="['Moderator']" /></g:link></li>
                <li><g:link class="list" action="administrators"><g:message code="default.list.label" args="['Administrator']" /></g:link></li>
			</ul>
		</div>
		<div id="list-player" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
				<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
			<thead>
					<tr>
					
						<g:sortableColumn property="name" title="${message(code: 'player.name.label', default: 'Name')}" />
					
						<g:sortableColumn property="login" title="${message(code: 'player.username.label', default: 'Login')}" />
					
						<g:sortableColumn property="password" title="${message(code: 'player.password.label', default: 'Password')}" />
					
						<g:sortableColumn property="description" title="${message(code: 'player.description.label', default: 'Description')}" />
					
						<th><g:message code="player.score.label" default="Score" /></th>
					
						<g:sortableColumn property="mail" title="${message(code: 'player.mail.label', default: 'Mail')}" />
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${playerList}" status="i" var="playerInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${playerInstance.id}">${fieldValue(bean: playerInstance, field: "name")}</g:link></td>
					
						<td>${fieldValue(bean: playerInstance, field: "username")}</td>
					
						<td>${fieldValue(bean: playerInstance, field: "password")}</td>
					
						<td>${fieldValue(bean: playerInstance, field: "description")}</td>
					
						<td>${fieldValue(bean: playerInstance, field: "score.score1")} / ${fieldValue(bean: playerInstance, field: "score.score2")}</td>
					
						<td>${fieldValue(bean: playerInstance, field: "mail")}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${playerList.size() ?: 0}" />
			</div>
		</div>
	</body>
</html>
