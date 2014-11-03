
<%@ page import="score.Score" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'score.label', default: 'Score')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-score" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-score" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
				<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
			<thead>
					<tr>
					
						<g:sortableColumn property="score1" title="${message(code: 'score.score1.label', default: 'Score1')}" />
					
						<g:sortableColumn property="score2" title="${message(code: 'score.score2.label', default: 'Score2')}" />
					
						<th><g:message code="score.player.label" default="Player" /></th>
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${scoreInstanceList}" status="i" var="scoreInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">

                        <td><g:link action="show" controller="Player" id="${scoreInstance.player.id}">${fieldValue(bean: scoreInstance, field: "user")}</g:link></td>

                        <td>${fieldValue(bean: scoreInstance, field: "score1")}</td>
					
						<td>${fieldValue(bean: scoreInstance, field: "score2")}</td>
					

					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${scoreInstanceCount ?: 0}" />
			</div>
		</div>
	</body>
</html>
