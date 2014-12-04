<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>

<%-- For administrators and moderators, having more menus to administrate the website --%>

<li><a class="problem" href="${createLink(uri: '/problem/valid_problems')}"><g:message code="All valids problems"/></a></li>
<li><a class="problem" href="${createLink(uri: '/problem/solved_problems')}"><g:message code="Archived problems"/></a></li>
<li><a class="problem" href="${createLink(uri: '/problem/my_problems')}"><g:message code="My problems"/></a></li>


<sec:ifAnyGranted roles='ROLE_ADMIN, ROLE_MODERATOR'>
    <li><a class="problem" href="${createLink(uri: '/problem/index')}"><g:message code="Problem List"/></a></li>
    <li><a class="problem" href="${createLink(uri: '/problem/problems_to_validate')}"><g:message code="Problems to validate"/></a></li>

</sec:ifAnyGranted>

<li><a class="score" href="${createLink(uri: '/score/index')}"><g:message code="Rankings"/></a></li>

<sec:ifAnyGranted roles='ROLE_ADMIN, ROLE_MODERATOR'>
    <li><a class="alert" href="${createLink(uri: '/alert/index')}"><g:message code="Alerts"/></a></li>
</sec:ifAnyGranted>
