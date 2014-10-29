<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="springSecurityUI">
    <g:set var="entityName" value="Moderator"/>
    <title><g:message code="default.list.label" args="[entityName]"/></title>
</head>

<body>

<div id="list-moderator" class="content scaffold-list" role="main">
    <h1><g:message code="default.list.label" args="[entityName]"/></h1>
    <g:if test="${flash.message}">
        <div class="message" role="status">${flash.message}</div>
    </g:if>
    <table>
        <thead>
        <tr>

            <g:sortableColumn property="username" title="${message(code: 'user.username.label', default: 'Username')}"/>

            <g:sortableColumn property="email" title="${message(code: 'user.email.label', default: 'E-Mail')}"/>

            <g:sortableColumn property="score" title="${message(code: 'user.score.label', default: 'Score')}"/>

        </tr>
        </thead>
        <tbody>
        <g:if test="${userInstanceList==null}">
            Aucun résultat
        </g:if>
        <g:else>
            <g:each in="${userInstanceList}" status="i" var="userInstance">
                <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">

                    <td><g:link action="edit"
                                id="${userInstance.id}">${fieldValue(bean: userInstance, field: "username")}</g:link></td>

                    <td>${fieldValue(bean: userInstance, field: "email")}</td>

                    <td>${fieldValue(bean: userInstance, field: "score.score1")} / ${fieldValue(bean: userInstance, field: "score.score2")}</td>

                </tr>
            </g:each>
        </g:else>
        </tbody>
    </table>

    <div class="pagination">
        <g:paginate total="${moderatorInstanceCount ?: 0}"/>
    </div>
</div>
</body>
</html>
