<%@ page import="problems.Comment; problems.Problem; org.springframework.security.core.context.SecurityContextHolder" %>

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

<div class="nav" role="navigation">
    <ul>
        <li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
        <%-- <li><g:link class="create" action="create"><g:message code="default.new.label" /></g:link></li> --%>
        <li><g:link class="create" action="create">New Problem</g:link></li>
        <sec:ifAnyGranted roles='ROLE_ADMIN, ROLE_MODERATOR'>
            <li><g:link class="list" action="index"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
            <li><g:link action="problems_to_validate"><g:message code="Problems to validate" args="[entityName]" /></g:link></li>
        </sec:ifAnyGranted>
        <li><g:link action="valid_problems"><g:message code="All valids problems"  args="[entityName]" /></g:link></li>
        <li><g:link action="my_problems"><g:message code="My problems"  args="[entityName]" /></g:link></li>
    </ul>
</div>

<div id="show-problem" class="content scaffold-show" role="main">
    <h1><g:message code="default.show.label" args="[entityName]"/></h1>
    <g:if test="${flash.message}">
        <div class="message" role="status">${flash.message}</div>
    </g:if>
    <ol class="property-list problem">

        <g:if test="${problemInstance?.image}">
            <li class="fieldcontain">
                <span id="image-label" class="property-label"><g:message code="problem.image.label"
                                                                         default="Image"/></span>
                <img src="${createLink(controller: 'problem', action: 'viewImage', id: problemInstance.id)}"/>
            </li>
        </g:if>

        <g:if test="${problemInstance?.description}">
            <li class="fieldcontain">
                <span id="description-label" class="property-label"><g:message code="problem.description.label"
                                                                               default="Description"/></span>

                <span class="property-value" aria-labelledby="description-label"><g:fieldValue bean="${problemInstance}"
                                                                                               field="description"/></span>

            </li>
        </g:if>

        <g:if test="${problemInstance?.blackPlayer}">
            <li class="fieldcontain">
                <span id="blackPlayer-label" class="property-label"><g:message code="problem.blackPlayer.label"
                                                                               default="Black Player"/></span>

                <span class="property-value" aria-labelledby="blackPlayer-label"><g:fieldValue bean="${problemInstance}"
                                                                                               field="blackPlayer"/></span>

            </li>
        </g:if>

        <g:if test="${problemInstance?.whitePlayer}">
            <li class="fieldcontain">
                <span id="whitePlayer-label" class="property-label"><g:message code="problem.whitePlayer.label"
                                                                               default="White Player"/></span>

                <span class="property-value" aria-labelledby="whitePlayer-label"><g:fieldValue bean="${problemInstance}"
                                                                                               field="whitePlayer"/></span>

            </li>
        </g:if>

        <g:if test="${problemInstance?.place}">
            <li class="fieldcontain">
                <span id="place-label" class="property-label"><g:message code="problem.place.label"
                                                                         default="Place"/></span>

                <span class="property-value" aria-labelledby="place-label"><g:fieldValue bean="${problemInstance}"
                                                                                         field="place"/></span>

            </li>
        </g:if>

        <g:if test="${problemInstance?.tournament}">
            <li class="fieldcontain">
                <span id="tournament-label" class="property-label"><g:message code="problem.tournament.label"
                                                                              default="Tournament"/></span>

                <span class="property-value" aria-labelledby="tournament-label"><g:fieldValue bean="${problemInstance}"
                                                                                              field="tournament"/></span>

            </li>
        </g:if>

        <g:if test="${problemInstance?.date}">
            <li class="fieldcontain">
                <span id="date-label" class="property-label"><g:message code="problem.date.label"
                                                                        default="Date"/></span>

                <span class="property-value" aria-labelledby="date-label"><g:formatDate
                        date="${problemInstance?.date}"/></span>

            </li>
        </g:if>

        <g:if test="${problemInstance?.player}">
            <li class="fieldcontain">
                <span id="player-label" class="property-label"><g:message code="problem.player.username.label"
                                                                          default="Player"/></span>

                <span class="property-value" aria-labelledby="player-label"><g:link controller="user" action="show"
                                                                                    id="${problemInstance?.player?.id}">${problemInstance?.player?.username?.encodeAsHTML()}</g:link></span>

            </li>
        </g:if>

        <g:if test="${problemInstance?.solutions}">
            <li class="fieldcontain">
                <span id="solutions-label" class="property-label"><g:message code="problem.solutions.label"
                                                                             default="Solutions"/></span>

                <g:each in="${problemInstance.solutions}" var="s">
                    <span class="property-value" aria-labelledby="solutions-label"><g:link controller="solution"
                                                                                           action="show"
                                                                                           id="${s.id}">${s?.encodeAsHTML()}</g:link></span>
                    <g:each in="${s.comments}" var="c">
                        <span class="property-value" aria-labelledby="solutions-label">
                            <g:form name="commentEditForm" url="[resource:c,controller:'comment']" >
                                -> ${c.text} - ${c.user.username}
                        <g:if test="${c.user.username.equals(SecurityContextHolder.getContext().getAuthentication().name)}">
                            <g:actionSubmit action="edit" value="Editer"/>
                            <g:actionSubmit action="supprimer" value="Supprimer"/>
                        </g:if>
                        </g:form>

                        </span>

                    </g:each>

                    <g:form name="commentForm" url="[action:'create',controller:'comment']" action="create">
                        <g:textArea name="comment" value="${comment}" rows="5" columns="30"/>
                        <g:hiddenField name="solutionId" value="${s.id}" />
                        <g:actionSubmit action="create" value="Commenter"/>
                    </g:form>
                </g:each>

            </li>
        </g:if>

        <g:if test="${problemInstance?.solved}">
            <li class="fieldcontain">
                <span id="solved-label" class="property-label"><g:message code="problem.solved.label"
                                                                          default="Solved"/></span>

                <span class="property-value" aria-labelledby="solved-label"><g:formatBoolean
                        boolean="${problemInstance?.solved}"/></span>

            </li>
        </g:if>

        <li class="fieldcontain">

            <span class="property-value" aria-labelledby="solved-label">
                <g:if test="${problemInstance?.valide}">
                    Valide
                </g:if>

            </span>

        </li>

    </ol>
    <g:form url="[resource: problemInstance, action: 'delete']" method="DELETE">
        <fieldset class="buttons">
            <g:link class="edit" action="edit" resource="${problemInstance}"><g:message code="default.button.edit.label"
                                                                                        default="Edit"/></g:link>
            <g:link class="edit" action="answer" resource="${problemInstance}"><g:message
                    code="default.button.answer.label" default="Answer"/></g:link>
            <g:actionSubmit class="delete" action="delete"
                            value="${message(code: 'default.button.delete.label', default: 'Delete')}"
                            onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');"/>
            <g:actionSubmit value="Validate" action="validate"/>
        </fieldset>
    </g:form>
</div>
</body>
</html>
