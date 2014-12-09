<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'solution.label', default: 'Solution')}" />
	</head>
	<body>
		<a href="#create-solution" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div id="create-solution" class="content scaffold-create" role="main">
			<h1>Proposer une Solution</h1>
			<g:if test="${flash.message}">
			<div class="errors" role="status">${flash.message}</div>
			</g:if>
			<g:hasErrors bean="${solutionInstance}">
			<ul class="errors" role="alert">
				<g:eachError bean="${solutionInstance}" var="error">
				<li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
				</g:eachError>
			</ul>
			</g:hasErrors>
			<g:form url="[resource:solutionInstance, action:'save']" >
				<fieldset class="form">
					<g:render template="form"/>
				</fieldset>
                <g:hiddenField name="problemId" value="${params.problemId}"/>
				<fieldset class="buttons">
					<g:submitButton name="create" class="save" value="${message(code: 'default.button.create.label', default: 'Create')}" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
