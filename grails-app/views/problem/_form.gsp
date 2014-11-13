<%@ page import="problems.Problem" %>



<div class="fieldcontain ${hasErrors(bean: problemInstance, field: 'image', 'error')} required">
    <label for="image">
        <g:message code="problem.image.label" default="Image" />
        <span class="required-indicator">*</span>
    </label>
    <input type="file" id="image" name="image" />

</div>

<div class="fieldcontain ${hasErrors(bean: problemInstance, field: 'description', 'error')} ">
    <label for="description">
        <g:message code="problem.description.label" default="Description" />

    </label>
    <g:textField name="description" value="${problemInstance?.description}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: problemInstance, field: 'blackPlayer', 'error')} ">
    <label for="blackPlayer">
        <g:message code="problem.blackPlayer.label" default="Black Player" />

    </label>
    <g:textField name="blackPlayer" value="${problemInstance?.blackPlayer}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: problemInstance, field: 'whitePlayer', 'error')} ">
    <label for="whitePlayer">
        <g:message code="problem.whitePlayer.label" default="White Player" />

    </label>
    <g:textField name="whitePlayer" value="${problemInstance?.whitePlayer}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: problemInstance, field: 'place', 'error')} ">
    <label for="place">
        <g:message code="problem.place.label" default="Place" />

    </label>
    <g:textField name="place" value="${problemInstance?.place}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: problemInstance, field: 'tournament', 'error')} ">
    <label for="tournament">
        <g:message code="problem.tournament.label" default="Tournament" />

    </label>
    <g:textField name="tournament" value="${problemInstance?.tournament}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: problemInstance, field: 'date', 'error')} ">
    <label for="date">
        <g:message code="problem.date.label" default="Date" />

    </label>
    <g:datePicker name="date" precision="day"  value="${problemInstance?.date}" default="none" noSelection="['': '']" />

</div>

<div class="fieldcontain ${hasErrors(bean: problemInstance, field: 'alerts', 'error')} ">
    <label for="alerts">
        <g:message code="problem.alerts.label" default="Alerts" />

    </label>

    <ul class="one-to-many">
        <g:each in="${problemInstance?.alerts?}" var="a">
            <li><g:link controller="alert" action="show" id="${a.id}">${a?.encodeAsHTML()}</g:link></li>
        </g:each>
        <li class="add">
            <g:link controller="alert" action="create" params="['problem.id': problemInstance?.id]">${message(code: 'default.add.label', args: [message(code: 'alert.label', default: 'Alert')])}</g:link>
        </li>
    </ul>


</div>

<div class="fieldcontain ${hasErrors(bean: problemInstance, field: 'player', 'error')} required">
    <label for="player">
        <g:message code="problem.player.label" default="Player" />
        <span class="required-indicator">*</span>
    </label>
    <g:select id="player" name="player.id" from="${users.User.list()}" optionKey="id" optionValue = "username" required="" value="${problemInstance?.player?.id}" class="many-to-one"/>

</div>
