<%@ page import="users.Administrator" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main">
    <g:set var="entityName" value="Administrator"/>
    <title><g:message code="default.list.label" args="[entityName]"/></title>
</head>

<body>
<a href="#list-player" class="skip" tabindex="-1"><g:message code="default.link.skip.label"
                                                             default="Skip to content&hellip;"/></a>

<div class="nav" role="navigation">
    <ul>
        <li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
        <li><g:link class="create" action="create"><g:message code="default.new.label" args="['User']"/></g:link></li>
        <li><g:link class="list" action="index"><g:message code="default.list.label" args="['User']"/></g:link></li>
        <li><g:link class="list" action="players"><g:message code="default.list.label" args="['Player']"/></g:link></li>
        <li><g:link class="list" action="moderators"><g:message code="default.list.label"
                                                                args="['Moderator']"/></g:link></li>
    </ul>
</div>

<div id="list-administrator" class="content scaffold-list" role="main">
    <h1><g:message code="default.list.label" args="[entityName]"/></h1>
    <g:if test="${flash.message}">
        <div class="message" role="status">${flash.message}</div>
    </g:if>
    <table>
        <thead>
        <tr>

            <g:sortableColumn property="username" title="${message(code: 'user.username.label', default: 'Username')}"/>

            <g:sortableColumn property="email" title="${message(code: 'user.email.label', default: 'E-Mail')}"/>

        </tr>
        </thead>
        <tbody>
        <g:each in="${userInstanceList}" status="i" var="userInstance">
            <g:if test="${userInstance.isAdministrator()}">
                <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">

                    <td><g:link action="show"
                                id="${administratorInstance.id}">${fieldValue(bean: administratorInstance, field: "name")}</g:link></td>

                    <td>${fieldValue(bean: administratorInstance, field: "username")}</td>

                    <td>${fieldValue(bean: administratorInstance, field: "description")}</td>

                    <td>${fieldValue(bean: administratorInstance, field: "score.score1")} / ${fieldValue(bean: administratorInstance, field: "score.score2")}</td>

                    <td>${fieldValue(bean: administratorInstance, field: "mail")}</td>
                </tr>
            </g:if>
        </g:each>
        </tbody>
    </table>

    <div class="pagination">
        <g:paginate total="${administratorInstanceCount ?: 0}"/>
    </div>
</div>
</body>
</html>
