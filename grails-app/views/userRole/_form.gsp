<%@ page import="users.UserRole" %>



<div class="fieldcontain ${hasErrors(bean: userRoleInstance, field: 'secRole', 'error')} required">
	<label for="secRole">
		<g:message code="userRole.secRole.label" default="Sec Role" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="secRole" name="secRole.id" from="${users.Role.list()}" optionKey="id" required="" value="${userRoleInstance?.secRole?.id}" class="many-to-one"/>

</div>

<div class="fieldcontain ${hasErrors(bean: userRoleInstance, field: 'secUser', 'error')} required">
	<label for="secUser">
		<g:message code="userRole.secUser.label" default="Sec User" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="secUser" name="secUser.id" from="${users.User.list()}" optionKey="id" required="" value="${userRoleInstance?.secUser?.id}" class="many-to-one"/>

</div>

