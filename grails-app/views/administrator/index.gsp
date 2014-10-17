
<%@ page import="users.Administrator" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'administrator.label', default: 'Administrator')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-administrator" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-administrator" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
				<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
			<thead>
					<tr>
					
						<g:sortableColumn property="name" title="${message(code: 'administrator.name.label', default: 'Name')}" />
					
						<g:sortableColumn property="login" title="${message(code: 'administrator.login.label', default: 'Login')}" />
					
						<g:sortableColumn property="password" title="${message(code: 'administrator.password.label', default: 'Password')}" />
					
						<g:sortableColumn property="description" title="${message(code: 'administrator.description.label', default: 'Description')}" />
					
						<th><g:message code="administrator.score.label" default="Score" /></th>
					
						<g:sortableColumn property="mail" title="${message(code: 'administrator.mail.label', default: 'Mail')}" />
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${administratorInstanceList}" status="i" var="administratorInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${administratorInstance.id}">${fieldValue(bean: administratorInstance, field: "name")}</g:link></td>
					
						<td>${fieldValue(bean: administratorInstance, field: "login")}</td>
					
						<td>${fieldValue(bean: administratorInstance, field: "password")}</td>
					
						<td>${fieldValue(bean: administratorInstance, field: "description")}</td>
					
						<td>${fieldValue(bean: administratorInstance, field: "score")}</td>
					
						<td>${fieldValue(bean: administratorInstance, field: "mail")}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${administratorInstanceCount ?: 0}" />
			</div>
		</div>
	</body>
</html>
