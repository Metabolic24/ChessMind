
<%@ page import="alert.Alert" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'alert.label', default: 'Alert')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-alert" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-alert" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
				<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
			<thead>
					<tr>
					
						<g:sortableColumn property="description" title="${message(code: 'alert.description.label', default: 'Description')}" />
					
						<th><g:message code="alert.problem.label" default="Problem" /></th>
					
						<th><g:message code="alert.user.label" default="User" /></th>
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${alertInstanceList}" status="i" var="alertInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${alertInstance.id}">${fieldValue(bean: alertInstance, field: "description")}</g:link></td>
					
						<td>${fieldValue(bean: alertInstance, field: "problem")}</td>
					
						<td>${fieldValue(bean: alertInstance, field: "user")}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${alertInstanceCount ?: 0}" />
			</div>
		</div>
	</body>
</html>
