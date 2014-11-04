
<%@ page import="problems.Problem" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main">
    <g:set var="entityName" value="${message(code: 'problem.label', default: 'Problem')}" />
    <title><g:message code="default.list.label" args="[entityName]" /></title>
</head>
<body>
<a href="#list-problem" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
<div class="nav" role="navigation">
    <ul>
        <li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
        <li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
        <li><g:link action="index"><g:message code="All valids problems"  args="[entityName]" /></g:link></li>
        <li><g:link class="my_problems" action="my_problems"><g:message code="My problems" args="[entityName]" /></g:link></li>
    </ul>
</div>
<div id="list-problem" class="content scaffold-list" role="main">
    <h1><g:message code="default.list.label" args="[entityName]" /></h1>
    <g:if test="${flash.message}">
        <div class="message" role="status">${flash.message}</div>
    </g:if>
    <table>
        <thead>
        <tr>
            <g:sortableColumn property="id" title="${message(code: 'problem.id.label', default: 'id')}" />

            <g:sortableColumn property="description" title="${message(code: 'problem.description.label', default: 'Description')}" />

            <g:sortableColumn property="blackPlayer" title="${message(code: 'problem.blackPlayer.label', default: 'Black Player')}" />

            <g:sortableColumn property="whitePlayer" title="${message(code: 'problem.whitePlayer.label', default: 'White Player')}" />

            <g:sortableColumn property="date" title="${message(code: 'problem.date.label', default: 'Date')}" />

            <g:sortableColumn property="place" title="${message(code: 'problem.place.label', default: 'Place')}" />

            <g:sortableColumn property="tournament" title="${message(code: 'problem.tournament.label', default: 'Tournament')}" />

            <g:sortableColumn property="owner" title="${message(code: 'problem.player.label', default: 'Owner')}" />

            <g:sortableColumn property="valide" title="${message(code: 'problem.valide.label', default: 'A été validé')}" />

            <th>Suppression</th>

        </tr>
        </thead>
        <tbody>
        <g:each in="${problemInstanceList}" status="i" var="problemInstance">
            <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">

                    <td><g:link action="show" id="${problemInstance.id}">${fieldValue(bean: problemInstance, field: "id")}</g:link></td>

                    <td>${fieldValue(bean: problemInstance, field: "description")}</td>

                    <td>${fieldValue(bean: problemInstance, field: "blackPlayer")}</td>

                    <td>${fieldValue(bean: problemInstance, field: "whitePlayer")}</td>

                    <td><g:formatDate date="${problemInstance.date}" /></td>

                    <td>${fieldValue(bean: problemInstance, field: "place")}</td>

                    <td>${fieldValue(bean: problemInstance, field: "tournament")}</td>

                    <td>${fieldValue(bean: problemInstance, field: "player.username")}</td>

                    <td>
                        <g:if test="${problemInstance?.valide == true}">
                            X
                        </g:if>
                    </td>

                    <td>
                        <g:if test="${problemInstance?.valide == false}">
                            <g:form url="[resource: problemInstance, action: 'delete']" method="DELETE">
                                    <g:actionSubmit class="delete" action="delete"
                                                    value="${message(code: 'default.button.delete.label', default: 'Delete')}"
                                                    onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');"/>
                            </g:form>
                        </g:if>
                    </td>
            </tr>
        </g:each>
        </tbody>
    </table>
    <div class="pagination">
        <g:paginate total="${problemInstanceCount ?: 0}" />
    </div>
</div>
</body>
</html>
