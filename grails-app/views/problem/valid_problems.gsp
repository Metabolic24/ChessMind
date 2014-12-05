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
            <li><a class="alert" href="${createLink(uri: '/alert/index')}"><g:message code="Alertes"/></a></li>
        </sec:ifAnyGranted>

    </ul>
</div>

<div id="list-problem" class="content scaffold-list" role="main">
    <h1>Liste des Problèmes</h1>
    <g:if test="${flash.message}">
        <div class="message" role="status">${flash.message}</div>
    </g:if>
    <table>
        <tbody>
        <g:each in="${problemInstanceList}" status="i" var="problemInstance">
        <g:if test="${i %2 == 0}">
            <tr class="even">
        </g:if>

                <g:if test="${problemInstance.valide}">
                    <td style=" font-size: 17 ; font-weight:bold ; text-align: center ; vertical-align: middle ; padding-bottom: 71px">
                        ${problemInstance.getId()}.
                    </td>

                    <td>
                        <g:link action="show" id="${problemInstance.id}"><img src="${createLink(controller: 'problem', action: 'viewImage', id: problemInstance.id)}"/></g:link>
                        <br/>
                        <span align="right" style="margin-left:35px ; margin-top:20px">
                            Proposé par
                            <g:link controller="user" action="show" id="${problemInstance.player.id}">${fieldValue(bean: problemInstance, field: "player.username")}</g:link>
                        </span>

                        <sec:ifAnyGranted roles='ROLE_ADMIN, ROLE_MODERATOR'>
                            <g:form url="[resource: problemInstance, action: 'delete']" method="DELETE" style="margin-left:8px; margin-top:5px">
                                <g:actionSubmit class="myButton" action="edit"
                                                value="${message(code: 'default.button.edit.label', default: 'Edit')}" style="margin-right:5px"/>
                                <g:actionSubmit class="myButton" action="delete"
                                                value="${message(code: 'default.button.delete.label', default: 'Delete')}" style="margin-left:5px"
                                                onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');"/>
                            </g:form>
                        </sec:ifAnyGranted>
                    </td>
                </g:if>
            <g:if test="${i % 2 == 1}">
                </tr>
            </g:if>
        </g:each>
        </tbody>
    </table>

    <div class="pagination">
        <g:paginate total="${problemInstanceCount ?: 0}"/>
    </div>
</div>
</body>
</html>
