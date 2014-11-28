
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

                <g:render template="/shared/commonMenu" />

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
                        <g:sortableColumn property="user.username" title="${message(code:"score.player.label", default:"Membre")}" />

                        <g:sortableColumn property="score1" title="${message(code: 'score.score1.label', default: 'Score 1 </br> Problèmes résolus ')}" />
					
						<g:sortableColumn property="score2" title="${message(code: 'score.score2.label', default: 'Score 2 </br> Likes')}" />

					</tr>
				</thead>
				<tbody>
				<g:each in="${scoreInstanceList}" status="i" var="scoreInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">

                        <td><g:link action="show" controller="user" id="${scoreInstance.user.id}">${fieldValue(bean: scoreInstance, field: "user.username")}</g:link></td>

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
