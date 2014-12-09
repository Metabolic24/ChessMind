<li><a class="home" href="${createLink(uri: '/problem/valid_problems')}">Accueil</a></li>

<%-- For administrators and moderators, having more menus to administrate the website --%>

<li><g:link class="create" action="create" controller="problem">Proposer un Problème</g:link></li>
<li><a class="problem" href="${createLink(uri: '/problem/my_problems')}">Mes Problèmes</a></li>

<li><a class="score" href="${createLink(uri: '/score/index')}">Classement</a></li>

<sec:ifAnyGranted roles='ROLE_ADMIN, ROLE_MODERATOR'>
    <li><a class="alert" href="${createLink(uri: '/alert/index')}">Alertes</a></li>
    <li><a class="problem" href="${createLink(uri: '/problem/problems_to_validate')}">En attente de Validation</a></li>
    <li><a class="problem" href="${createLink(uri: '/problem/index')}">Tous les Problèmes</a></li>
</sec:ifAnyGranted>
