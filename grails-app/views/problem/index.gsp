<%@ page import="problems.Problem" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main">
    <g:set var="entityName" value="${message(code: 'problem.label', default: 'Problem')}" />
</head>
<body>
<a href="#list-problem" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
<div id="list-problem" class="content scaffold-list" role="main">
    <h1>Liste détaillée des Problèmes</h1>
    <g:if test="${flash.message}">
        <div class="message" role="status">${flash.message}</div>
    </g:if>
    <g:if test="${flash.error}">
        <div class="errors" role="status">${flash.error}</div>
    </g:if>
    <table>
        <thead>
        <tr>
            <g:sortableColumn property="id" title="${message(code: 'problem.id.label', default: 'id')}" />

            <g:sortableColumn property="owner" title="${message(code: 'problem.player.label', default: 'Auteur')}" />

            <th>Diagramme</th>

            <sec:ifAnyGranted roles='ROLE_ADMIN, ROLE_MODERATOR'>
                <th>Edition</th>
                <th>Suppression</th>
                <th>Validation</th>
            </sec:ifAnyGranted>
        </tr>
        </thead>
        <tbody>
        <g:each in="${problemInstanceList}" status="i" var="problemInstance">
            <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">

                <td><g:link action="show" id="${problemInstance.id}">${fieldValue(bean: problemInstance, field: "id")}</g:link></td>

                <td>${fieldValue(bean: problemInstance, field: "player.username")}</td>

                <td>
                    <img src="${createLink(controller: 'problem', action: 'viewImage', id: problemInstance.id)}"/>
                </td>

                <sec:ifAnyGranted roles='ROLE_ADMIN, ROLE_MODERATOR'>
                    <td>
                        <g:form url="[resource: problemInstance, action: 'edit']">
                            <g:actionSubmit class="edit" action="edit"
                                            value="${message(code: 'default.button.edit.label', default: 'Edit')}"/>
                        </g:form>
                    </td>

                    <td>
                        <g:form url="[resource: problemInstance, action: 'delete']" method="DELETE">
                            <g:actionSubmit class="delete" action="delete"
                                            value="${message(code: 'default.button.delete.label', default: 'Delete')}"
                                            onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');"/>
                        </g:form>
                    </td>

                    <td>
                        <g:if test="${problemInstance.valide == false}">
                            En attente de validation
                        </g:if>
                        <g:else>
                            Problème validé
                        </g:else>
                    </td>
                </sec:ifAnyGranted>
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
