<%@ page import="score.Score" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main">
    <g:set var="entityName" value="${message(code: 'score.label', default: 'Score')}"/>
    <title>ChessMind : Classement</title>
</head>

<body>
<a href="#list-score" class="skip" tabindex="-1"><g:message code="default.link.skip.label"
                                                            default="Skip to content&hellip;"/></a>

<div id="list-score" class="content scaffold-list" role="main">
    <h1>Classement Général</h1>
    <g:if test="${flash.message}">
        <div class="message" role="status">${flash.message}</div>
    </g:if>
    <table>
        <thead>
        <tr>
            <g:sortableColumn property="user.score" style="text-align: center ; vertical-align: middle"
                              title="${message(code: "score.player.rank", default: "Rang")}"/>

            <g:sortableColumn property="user.username" style="text-align: center ; vertical-align: middle"
                              title="${message(code: "score.player.label", default: "Membre")}"/>

            <g:sortableColumn property="score1" style="text-align: center ; vertical-align: middle"
                              title="${message(code: 'score.score1.label', default: 'Problèmes résolus ')}"/>

            <g:sortableColumn property="score2" style="text-align: center ; vertical-align: middle"
                              title="${message(code: 'score.score2.label', default: 'Likes')}"/>
        </tr>
        </thead>
        <tbody>
        <g:each in="${scoreInstanceList}" status="i" var="scoreInstance">
            <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
                <td style="font-weight: bold ; font-size: 17 ; text-align: center ; vertical-align: middle">${i + 1}.</td>

                <td style="text-align: center ; vertical-align: middle"><g:link action="show" controller="user"
                                                                                id="${scoreInstance.user.id}">${fieldValue(bean: scoreInstance, field: "user.username")}</g:link></td>

                <td style="text-align: center ; vertical-align: middle">${fieldValue(bean: scoreInstance, field: "score1")}</td>

                <td style="text-align: center ; vertical-align: middle">${fieldValue(bean: scoreInstance, field: "score2")}</td>
            </tr>
        </g:each>
        </tbody>
    </table>

    <div class="pagination">
        <g:paginate total="${scoreInstanceCount ?: 0}"/>
    </div>
</div>
</body>
</html>
