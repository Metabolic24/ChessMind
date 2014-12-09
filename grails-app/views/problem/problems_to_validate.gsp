<%@ page import="problems.Problem" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main">
    <g:set var="entityName" value="${message(code: 'problem.label', default: 'Problem')}"/>
</head>

<body>
<a href="#list-problem" class="skip" tabindex="-1"><g:message code="default.link.skip.label"
                                                              default="Skip to content&hellip;"/></a>

<div id="list-problem" class="content scaffold-list" role="main">
    <h1>Problèmes en attente de Validation</h1>
    <g:if test="${flash.message}">
        <div class="message" role="status">${flash.message}</div>
    </g:if>

    <table>
        <tbody>
        <g:each in="${problemInstanceList}" status="i" var="problemInstance">
            <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">

                <td style=" font-size: 17 ; font-weight: bold ; text-align: center ; vertical-align: middle ; padding-bottom: 115px">
                    ${problemInstance.getId()}.
                </td>

                <td>
                    <g:link action="show" id="${problemInstance.id}"><img
                            src="${createLink(controller: 'problem', action: 'viewImage', id: problemInstance.id)}"/></g:link>
                    <br/>
                    <span align="right" style="margin-left:35px ; margin-top:20px">
                        Proposé par
                        <g:link controller="user" action="show"
                                id="${problemInstance.player.id}">${fieldValue(bean: problemInstance, field: "player.username")}</g:link>
                    </span>

                    <g:form url="[resource: problemInstance, action: 'delete']" method="DELETE"
                            style="margin-left:8px; margin-top:5px">
                        <g:actionSubmit class="myButton" action="edit"
                                        value="${message(code: 'default.button.edit.label', default: 'Edit')}"
                                        style="margin-right:5px"/>
                        <g:actionSubmit class="myButton" action="delete"
                                        value="${message(code: 'default.button.delete.label', default: 'Delete')}"
                                        style="margin-left:5px"
                                        onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');"/>
                        <br/>
                        <g:actionSubmit class="myButton" action="validateFromList"
                                        value="${message(code: 'default.button.validate.label', default: 'Validate')}"
                                        style="margin-right:5px ; margin-top:8px ; margin-left:35px"/>
                    </g:form>
                </td>
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
