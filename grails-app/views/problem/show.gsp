<%@ page import="users.User; problems.Comment; problems.Problem; org.springframework.security.core.context.SecurityContextHolder" %>

<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main">
    <g:set var="entityName" value="${message(code: 'problem.label', default: 'Problem')}"/>
    <title><g:message code="default.show.label" args="[entityName]"/></title>
</head>

<body>
<a href="#show-problem" class="skip" tabindex="-1"><g:message code="default.link.skip.label"
                                                              default="Skip to content&hellip;"/></a>
<div id="show-problem" class="content scaffold-show" role="main">
    <h1><g:message code="default.show.label" args="[entityName]"/></h1>
    <g:if test="${flash.message}">
        <div class="message" role="status">${flash.message}</div>
    </g:if>
    <ol class="property-list problem">

        <div align="center">
            <g:if test="${problemInstance?.image}">
                    <img src="${createLink(controller: 'problem', action: 'viewImage', id: problemInstance.id)}"
                         style="vertical-align: middle"/>
            </g:if>

        <span style="float:right ; margin-right:200px ; vertical-align: middle">

        <g:if test="${problemInstance?.player}">
            <span style="margin-left:35px ; margin-top:20px">
                Proposé par : <g:link controller="user" action="show"
                                      id="${problemInstance?.player?.id}">${problemInstance?.player?.username?.encodeAsHTML()}</g:link>
            </span>
        </g:if>
        <g:if test="${problemInstance?.description}">
            <li class="fieldcontain">
                Description : <g:fieldValue bean="${problemInstance}" field="description"/>
            </li>
        </g:if>

        <g:if test="${problemInstance?.blackPlayer && problemInstance?.whitePlayer}">
            <li class="fieldcontain">
                <g:fieldValue bean="${problemInstance}" field="blackPlayer"/> (Noir) vs  <g:fieldValue bean="${problemInstance}" field="whitePlayer"/> (Blanc
            </li>
        </g:if>

        <g:if test="${problemInstance?.place}">
            <li class="fieldcontain">
                Observé à : <g:fieldValue bean="${problemInstance}" field="place"/>
            </li>
        </g:if>

        <g:if test="${problemInstance?.tournament}">
            <li class="fieldcontain">
                Lors de <g:fieldValue bean="${problemInstance}" field="tournament"/>
            </li>
        </g:if>

        <g:if test="${problemInstance?.date}">
            <li class="fieldcontain">
                Date : <g:formatDate date="${problemInstance?.date}"/>
            </li>
        </g:if>
        </span>

        </div>

        <g:if test="${problemInstance?.solutions}">
            <div style="margin-top:75px">
                <h2 style="margin-bottom: 30px">Solutions :</h2>
                <g:each in="${problemInstance?.sortedSolutions()}" var="s">
                    <span class="property-value" ariga-labelledby="solutions-label">
                        <g:form name="commentEditForm" url="[resource: s, controller: 'solution']">
                            <b>${s.answer}</b> (
                            <g:link controller="user" action="show"
                                    id="${s?.user?.id}">${s?.user?.username}</g:link>
                            )
                            <g:if test="${!s.user.username.equals(SecurityContextHolder.getContext().getAuthentication().name) && !User.findByUsername(SecurityContextHolder.getContext()?.getAuthentication()?.name)?.solutions?.contains(s)}">
                                <g:actionSubmit action="aime" value="J'aime" />
                            </g:if>
                             : ${s.aime} 'likes'
                            <%-- test="${!problemInstance?.player.username.equals(SecurityContextHolder.getContext().getAuthentication().name) && problemInstance?.valide}"> --%>
                            <g:if test="${s.problem.player.username.equals(SecurityContextHolder.getContext().getAuthentication().name) && s.isBestSolution == false}">
                                <g:actionSubmit action="bestSolution" value="Meilleure" />
                            </g:if>
                            <g:else>
                                <sec:ifAnyGranted roles='ROLE_ADMIN, ROLE_MODERATOR'>
                                    <g:if test="${s.isBestSolution == false}">
                                        <g:actionSubmit action="bestSolution" value="Meilleure" />
                                    </g:if>
                                </sec:ifAnyGranted>
                            </g:else>
                        </g:form>
                    </span>
                    <g:each in="${s.sortedComments()}" var="c">
                        <span class="property-value" aria-labelledby="solutions-label">
                            <g:form name="commentEditForm" url="[resource: c, controller: 'comment']" method="DELETE">
                                -> ${c.text} -
                                <g:link controller="user" action="show"
                                        id="${c?.user?.id}">${c?.user?.username}</g:link>
                                <g:if test="${c.user.username.equals(SecurityContextHolder.getContext().getAuthentication().name)}">
                                    <g:actionSubmit action="edit" value="Editer"/>

                                    <g:actionSubmit action="delete" value="X"
                                                    onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');"/>
                                </g:if>
                                <g:else>
                                    <sec:ifAnyGranted roles='ROLE_ADMIN,ROLE_MODERATOR'>
                                        <g:actionSubmit action="edit" value="Editer"/>
                                        <g:actionSubmit action="delete" value="X"
                                                        onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');"/>
                                    </sec:ifAnyGranted>
                                    <sec:ifAnyGranted roles='ROLE_USER'>
                                        <g:actionSubmit action="alertComment" value="Signaler"/>
                                    </sec:ifAnyGranted>
                                </g:else>

                            </g:form>

                        </span>

                    </g:each>

                    <br/>
                    <sec:ifLoggedIn>
                        <g:form name="commentForm" url="[action: 'create', controller: 'comment']" action="create">
                            <g:textArea name="comment" value="${comment}" rows="5" columns="30"/>
                            <g:hiddenField name="solutionId" value="${s.id}"/>
                            <g:actionSubmit action="create" value="Commenter"/>
                        </g:form>
                    </sec:ifLoggedIn>
                    <br/>
                </g:each>
            </div>
        </g:if>

        <sec:ifAnyGranted roles='ROLE_ADMIN, ROLE_MODERATOR'>

            <g:if test="${problemInstance?.bestSolution != null}">
                <li class="fieldcontain">
                    <span id="solved-label" class="property-label"><g:message code="problem.solved.label"
                                                                              default="Solved"/></span>

                    <span class="property-value" aria-labelledby="solved-label"><g:formatBoolean
                            boolean="${problemInstance?.bestSolution != null}"/></span>

                </li>
            </g:if>

            <li class="fieldcontain">
                <span class="property-value" aria-labelledby="solved-label">
                    <g:if test="${!problemInstance?.valide}">
                        En attente de Validation
                    </g:if>

                </span>
            </li>
        </sec:ifAnyGranted>
    </ol>
    <g:form url="[resource: problemInstance, action: 'delete']" method="DELETE">
        <fieldset class="buttons">
            <sec:ifAnyGranted roles='ROLE_ADMIN, ROLE_MODERATOR'>
                <g:link class="edit" action="edit" resource="${problemInstance}"><g:message
                        code="default.button.edit.label" default="Edit"/></g:link>
                <g:if test="${!problemInstance?.player.username.equals(SecurityContextHolder.getContext().getAuthentication().name) && problemInstance?.valide}">
                    <g:link class="edit" action="answer" resource="${problemInstance}"><g:message
                            code="default.button.answer.label" default="Answer"/></g:link>
                </g:if>
                <g:actionSubmit class="delete" action="delete"
                                value="${message(code: 'default.button.delete.label', default: 'Delete')}"
                                onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');"/>

                <g:if test="${!problemInstance?.valide}">
                    <g:actionSubmit value="Validate" action="validate"/>
                </g:if>
            </sec:ifAnyGranted>
            <sec:ifAnyGranted roles='ROLE_USER'>
                <g:if test="${problemInstance?.player.username.equals(SecurityContextHolder.getContext().getAuthentication().name) && !problemInstance?.valide}">
                    <g:link class="edit" action="edit" resource="${problemInstance}"><g:message
                            code="default.button.edit.label" default="Edit"/></g:link>
                    <g:actionSubmit class="delete" action="delete"
                                    value="${message(code: 'default.button.delete.label', default: 'Delete')}"
                                    onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');"/>
                </g:if>
                <g:elseif test="${!problemInstance?.player.username.equals(SecurityContextHolder.getContext().getAuthentication().name) && problemInstance?.valide}">
                    <g:link class="edit" action="answer" resource="${problemInstance}"><g:message
                            code="default.button.answer.label" default="Answer"/></g:link>
                    <g:link class="alert" action="alert" resource="${problemInstance}"><g:message
                            code="Alerter" default="Alerter"/></g:link>
                </g:elseif>
            </sec:ifAnyGranted>
        </fieldset>
    </g:form>
</div>
</body>
</html>
