
<%@ page import="score.Score" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'score.label', default: 'Score')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-score" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="index"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-score" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list score">
			
				<g:if test="${scoreInstance?.score1}">
				<li class="fieldcontain">
					<span id="score1-label" class="property-label"><g:message code="score.score1.label" default="Score1" /></span>
					
						<span class="property-value" aria-labelledby="score1-label"><g:fieldValue bean="${scoreInstance}" field="score1"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${scoreInstance?.score2}">
				<li class="fieldcontain">
					<span id="score2-label" class="property-label"><g:message code="score.score2.label" default="Score2" /></span>
					
						<span class="property-value" aria-labelledby="score2-label"><g:fieldValue bean="${scoreInstance}" field="score2"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${scoreInstance?.player}">
				<li class="fieldcontain">
					<span id="player-label" class="property-label"><g:message code="score.player.label" default="Player" /></span>
					
						<span class="property-value" aria-labelledby="player-label"><g:link controller="player" action="show" id="${scoreInstance?.player?.id}">${scoreInstance?.player?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
			</ol>
			<g:form url="[resource:scoreInstance, action:'delete']" method="DELETE">
				<fieldset class="buttons">
					<g:link class="edit" action="edit" resource="${scoreInstance}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
