
<%@ page import="problems.Comment" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'comment.label', default: 'Comment')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-comment" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div id="list-comment" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
				<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
			<thead>
					<tr>
					
						<g:sortableColumn property="text" title="${message(code: 'comment.text.label', default: 'Text')}" />
					
						<th><g:message code="comment.solution.label" default="Solution" /></th>
					
						<th><g:message code="comment.user.label" default="User" /></th>
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${commentInstanceList}" status="i" var="commentInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${commentInstance.id}">${fieldValue(bean: commentInstance, field: "text")}</g:link></td>
					
						<td>${fieldValue(bean: commentInstance, field: "solution")}</td>
					
						<td>${fieldValue(bean: commentInstance, field: "user")}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${commentInstanceCount ?: 0}" />
			</div>
		</div>
	</body>
</html>
