<html>

<head>
    <title>Formulaire d'Inscription</title>
    <meta name='layout' content='register'/>
</head>

<body>

<p/>

<div class="login s2ui_center ui-corner-all" style='text-align:center;'>
    <div class="login-inner">
        <form action='${postUrl}' method='POST' id="loginForm" name="loginForm" autocomplete='off'>
            <div class="sign-in">

                <h1>Authentification</h1>

                <table>
                    <tr>
                        <td><label for="username">Pseudo</label></td>
                        <td><input name="j_username" id="username" size="20"/></td>
                    </tr>
                    <tr>
                        <td><label for="password">Mot de Passe</label></td>
                        <td><input type="password" name="j_password" id="password" size="20"/></td>
                    </tr>
                    <tr>
                        <td colspan='2'>
                            <input type="checkbox" class="checkbox" name="${rememberMeParameter}" id="remember_me"
                                   checked="checked"/>
                            <label for='remember_me'>Rester Connecté</label> |
                            <span class="forgot-link">
                                <g:link controller='register' action='forgotPassword'>Mot de Passe oublié?</g:link>
                            </span>
                        </td>
                    </tr>
                    <tr>
                        <td colspan='2' style='text-align:center;padding:3px' >
                            <s2ui:linkButton elementId='register' controller='register'
                                             messageCode="S'enregistrer"/>
                            <s2ui:submitButton elementId='loginButton' form='loginForm'
                                               messageCode='Connexion'/>
                        </td>
                    </tr>
                </table>

            </div>
        </form>
    </div>
</div>

<script>
    $(document).ready(function () {
        $('#username').focus();
    });

    <s2ui:initCheckboxes/>

</script>

</body>
</html>
