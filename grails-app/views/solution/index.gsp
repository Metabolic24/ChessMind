
<%@ page import="problems.Solution" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'solution.label', default: 'Solution')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-solution" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-solution" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
				<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
			<thead>
					<tr>
					
						<g:sortableColumn property="answer" title="${message(code: 'solution.answer.label', default: 'Answer')}" />
					
						<th><g:message code="solution.player.label" default="Player" /></th>
					
						<th><g:message code="solution.problem.label" default="Problem" /></th>
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${solutionInstanceList}" status="i" var="solutionInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${solutionInstance.id}">${fieldValue(bean: solutionInstance, field: "answer")}</g:link></td>
					
						<td>${fieldValue(bean: solutionInstance, field: "user")}</td>
					
						<td>${fieldValue(bean: solutionInstance, field: "problem")}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${solutionInstanceCount ?: 0}" />
			</div>
		</div>
	</body>
</html>
