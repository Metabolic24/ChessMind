
<%@ page import="alert.Alert" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main">
    <g:set var="entityName" value="${message(code: 'alert.label', default: 'Alert')}" />
    <title>ChessMind : Alertes</title>
</head>
<body>
<a href="#list-alert" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
<div id="list-alert" class="content scaffold-list" role="main">
    <h1>Alertes signalées</h1>
    <g:if test="${flash.message}">
        <div class="message" role="status">${flash.message}</div>
    </g:if>
    <table>
        <thead>
        <tr>
            <g:sortableColumn property="description" style="text-align: center ; vertical-align: middle" title="${message(code: 'alert.description.label', default: 'Description')}" />

            <th style="text-align: center ; vertical-align: middle"><g:message code="alert.problem.label" default="Problème" /></th>

            <th style="text-align: center ; vertical-align: middle"><g:message code="alert.comment.label" default="Commentaire signalé" /></th>

            <th style="text-align: center ; vertical-align: middle"><g:message code="alert.user.label" default="Auteur" /></th>
        </tr>
        </thead>
        <tbody>
        <g:each in="${alertInstanceList}" status="i" var="alertInstance">
            <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">

                <td>${fieldValue(bean: alertInstance, field: "description")}</td>

                <td style="text-align: center ; vertical-align: middle"><g:link controller="problem" action="show" id="${alertInstance.problem.id}">${fieldValue(bean: alertInstance, field: "problem.id")}</g:link></td>

                <td><g:link controller="problem" action="show" id="${alertInstance.problem.id}">${fieldValue(bean: alertInstance, field: "comment.text")}</g:link></td>

                <td style="text-align: center ; vertical-align: middle">${fieldValue(bean: alertInstance, field: "user.username")}</td>

                <td style="text-align: center ; vertical-align: middle">
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
