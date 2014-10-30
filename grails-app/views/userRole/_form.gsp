<%@ page import="users.UserRole" %>



<div class="fieldcontain ${hasErrors(bean: userRoleInstance, field: 'role', 'error')} required">
	<label for="role">
		<g:message code="userRole.role.label" default="Sec Role" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="role" name="role.id" from="${users.Role.list()}" optionKey="id" required="" value="${userRoleInstance?.role?.id}" class="many-to-one"/>

</div>

<div class="fieldcontain ${hasErrors(bean: userRoleInstance, field: 'user', 'error')} required">
	<label for="user">
		<g:message code="userRole.user.label" default="Sec User" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="user" name="user.id" from="${users.User.list()}" optionKey="id" required="" value="${userRoleInstance?.user?.id}" class="many-to-one"/>

</div>

