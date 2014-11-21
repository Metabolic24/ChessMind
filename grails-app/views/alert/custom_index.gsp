
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
        <li><a class="problem" href="${createLink(uri: '/problem/index')}"><g:message code="Problem List"/></a></li>
        <li><a class="problem" href="${createLink(uri: '/problem/problems_to_validate')}"><g:message code="Problems to validate"/></a></li>
        <li><a class="problem" href="${createLink(uri: '/problem/valid_problems')}"><g:message code="All valids problems"/></a></li>
        <li><a class="problem" href="${createLink(uri: '/problem/my_problems')}"><g:message code="My problems"/></a></li>

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

            <th><g:message code="alert.comment.label" default="Commentaire signalé" /></th>

            <th><g:message code="alert.user.label" default="User" /></th>

            <th>Suppression</th>

        </tr>
        </thead>
        <tbody>
        <g:each in="${alertInstanceList}" status="i" var="alertInstance">
            <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">

                <td><g:link action="show" id="${alertInstance.id}">${fieldValue(bean: alertInstance, field: "description")}</g:link></td>
                <%--
                <td>${fieldValue(bean: alertInstance, field: "problem")}</td>
                --%>
                <td><g:link controller="problem" action="show" id="${alertInstance.problem.id}">${fieldValue(bean: alertInstance, field: "problem.id")}</g:link></td>

                <td><g:link controller="problem" action="show" id="${alertInstance.problem.id}">${fieldValue(bean: alertInstance, field: "comment.text")}</g:link></td>

                <td>${fieldValue(bean: alertInstance, field: "user.username")}</td>

                <td>
                    <g:form url="[resource:alertInstance, action:'delete']" method="DELETE">
                        <g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
                    </g:form>
                </td>
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
