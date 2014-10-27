
<%@ page import="users.Moderator" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'moderator.label', default: 'Moderator')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-player" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
                <li><g:link class="create" action="create"><g:message code="default.new.label" args="['User']" /></g:link></li>
                <li><g:link class="list" action="index"><g:message code="default.list.label" args="['User']" /></g:link></li>
                <li><g:link class="list" action="players"><g:message code="default.list.label" args="['Player']" /></g:link></li>
                <li><g:link class="list" action="administrators"><g:message code="default.list.label" args="['Administrator']" /></g:link></li>
			</ul>
		</div>
		<div id="list-moderator" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
				<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
			<thead>
					<tr>
					
						<g:sortableColumn property="name" title="${message(code: 'moderator.name.label', default: 'Name')}" />
					
						<g:sortableColumn property="login" title="${message(code: 'moderator.username.label', default: 'Login')}" />
					
						<g:sortableColumn property="password" title="${message(code: 'moderator.password.label', default: 'Password')}" />
					
						<g:sortableColumn property="description" title="${message(code: 'moderator.description.label', default: 'Description')}" />
					
						<th><g:message code="moderator.score.label" default="Score" /></th>
					
						<g:sortableColumn property="mail" title="${message(code: 'moderator.mail.label', default: 'Mail')}" />
					
					</tr>
				</thead>
				<tbody>
                <g:each in="${moderatorInstanceList}" status="i" var="moderatorInstance">
                    <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">

                        <td><g:link action="show" id="${moderatorInstance.id}">${fieldValue(bean: moderatorInstance, field: "name")}</g:link></td>

                        <td>${fieldValue(bean: moderatorInstance, field: "username")}</td>

                        <td>${fieldValue(bean: moderatorInstance, field: "password")}</td>

                        <td>${fieldValue(bean: moderatorInstance, field: "description")}</td>

                        <td>${fieldValue(bean: moderatorInstance, field: "score.score1")} / ${fieldValue(bean: moderatorInstance, field: "score.score2")}</td>

                        <td>${fieldValue(bean: moderatorInstance, field: "mail")}</td>
                    </tr>
                </g:each>
                </tbody>
            </table>
            <div class="pagination">
                <g:paginate total="${moderatorInstanceCount ?: 0}" />
            </div>
		</div>
	</body>
</html>
