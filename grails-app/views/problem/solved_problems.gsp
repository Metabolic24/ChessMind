<%@ page import="problems.Problem" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main">
    <g:set var="entityName" value="${message(code: 'problem.label', default: 'Problem')}"/>
    <title>ChessMind</title>
</head>

<body>
<a href="#list-problem" class="skip" tabindex="-1"><g:message code="default.link.skip.label"
                                                              default="Skip to content&hellip;"/></a>

<div class="nav" role="navigation">
    <ul>
        <li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
        <li><g:link class="create" action="create"><g:message code="default.new.label"
                                                              args="[entityName]"/></g:link></li>
        <sec:ifAnyGranted roles='ROLE_ADMIN, ROLE_MODERATOR'>
            <li><g:link class="list" action="index"><g:message code="default.list.label"
                                                               args="[entityName]"/></g:link></li>
            <li><g:link action="problems_to_validate"><g:message code="Problems to validate"
                                                                 args="[entityName]"/></g:link></li>
        </sec:ifAnyGranted>
        <li><g:link action="valid_problems"><g:message code="All valids problems" args="[entityName]"/></g:link></li>
        <li><g:link action="my_problems"><g:message code="My problems" args="[entityName]"/></g:link></li>

        <sec:ifAnyGranted roles='ROLE_ADMIN, ROLE_MODERATOR'>
            <li><a class="alert" href="${createLink(uri: '/alert/custom_index')}"><g:message code="Alertes"/></a></li>
        </sec:ifAnyGranted>

    </ul>
</div>

<div id="list-problem" class="content scaffold-list" role="main">
    <h1>Liste des Problèmes</h1>
    <g:if test="${flash.message}">
        <div class="message" role="status">${flash.message}</div>
    </g:if>
    <table>
        <thead>
        <tr>
            <g:sortableColumn property="id" title="${message(code: 'problem.id.label', default: 'id')}"/>

            <g:sortableColumn property="owner" title="${message(code: 'problem.player.label', default: 'Owner')}"/>

            <th>Diagramme</th>

            <sec:ifAnyGranted roles='ROLE_ADMIN, ROLE_MODERATOR'>
                <th>Edition</th>
                <th>Suppression</th>
            </sec:ifAnyGranted>

        </tr>
        </thead>
        <tbody>
        <g:each in="${problemInstanceList}" status="i" var="problemInstance">
            <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">

                <td><g:link action="show"
                            id="${problemInstance.id}">${fieldValue(bean: problemInstance, field: "id")}</g:link></td>

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
                </sec:ifAnyGranted>
            </tr>
        </g:each>
        </tbody>
    </table>

    <div class="pagination">
        <g:paginate total="${problemInstanceCount ?: 0}"/>
    </div>
</div>
</body>
</html>
