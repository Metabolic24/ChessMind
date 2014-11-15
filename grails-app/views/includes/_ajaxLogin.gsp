<style>
#ajaxLogin {
    background-color: #FFFFFF
    display: none;
    height: 370px;
    width: 400px;
    border: none;
}

#inputs input
{
    background: #f1f1f1 url(http://www.red-team-design.com/wp-content/uploads/2011/09/login-sprite.png) no-repeat;
    padding: 15px 15px 15px 30px;
    margin: 0 0 10px 0;
    width: 353px; /* 353 + 2 + 45 = 400 */
    border: 1px solid #ccc;
    -moz-border-radius: 5px;
    -webkit-border-radius: 5px;
    border-radius: 5px;
    -moz-box-shadow: 0 1px 1px #ccc inset, 0 1px 0 #fff;
    -webkit-box-shadow: 0 1px 1px #ccc inset, 0 1px 0 #fff;
    box-shadow: 0 1px 1px #ccc inset, 0 1px 0 #fff;
}

#inputs input:focus
{
    background-color: #fff;
    border-color: #e8c291;
    outline: none;
    -moz-box-shadow: 0 0 0 1px #e8c291 inset;
    -webkit-box-shadow: 0 0 0 1px #e8c291 inset;
    box-shadow: 0 0 0 1px #e8c291 inset;
}

#actions
{
    margin: 25px 0 0 0;
}

#username
{
    background-position: 5px -2px !important;
}

#password
{
    background-position: 5px -52px !important;
}

#login {
    box-shadow: 0 0 2px rgba(0, 0, 0, 0.2),
    0 1px 1px rgba(0, 0, 0, .2),
    0 3px 0 #fff,
    0 4px 0 rgba(0, 0, 0, .2),
    0 6px 0 #fff,
    0 7px 0 rgba(0, 0, 0, .2);
}

#login {
    position: relative;
    z-index: 0;
}

#login:before {
    content: '';
    position: absolute;
    z-index: -1;
    border: 1px dashed #ccc;
    top: 5px;
    bottom: 5px;
    left: 5px;
    right: 5px;
    box-shadow: 0 0 0 1px #fff;
}

#ajaxLogin h1 {
    text-shadow: 0 1px 0 rgba(255, 255, 255, .7), 0px 2px 0 rgba(0, 0, 0, .5);
    text-transform: uppercase;
    text-align: center;
    color: #666;
    margin: 0 0 30px 0;
    letter-spacing: 4px;
    font: normal 26px/1 Verdana, Helvetica;
    position: relative;
}

#ajaxLogin h1:after,#ajaxLogin h1:before {
    background-color: #777;
    content: "";
    height: 1px;
    position: absolute;
    top: 15px;
    width: 120px;
}

#ajaxLogin h1:after {
    right: 0;
}

#ajaxLogin h1:before {
    background-image: linear-gradient(right, #777, #fff);
    left: 0;
}

#ajaxLogin .button {
    background: #3498db;
    background-image: -webkit-linear-gradient(top, #3498db, #2980b9);
    background-image: -moz-linear-gradient(top, #3498db, #2980b9);
    background-image: -ms-linear-gradient(top, #3498db, #2980b9);
    background-image: -o-linear-gradient(top, #3498db, #2980b9);
    background-image: linear-gradient(to bottom, #3498db, #2980b9);
    -webkit-border-radius: 28;
    -moz-border-radius: 28;
    border-radius: 28px;
    font-family: Arial;
    color: #ffffff;
    font-size: 20px;
    padding: 4px 10px 4px 10px;
    text-decoration: none;
    display:inline;
}

#ajaxLogin .button:hover {
    background: #3cb0fd;
    background-image: -webkit-linear-gradient(top, #3cb0fd, #3498db);
    background-image: -moz-linear-gradient(top, #3cb0fd, #3498db);
    background-image: -ms-linear-gradient(top, #3cb0fd, #3498db);
    background-image: -o-linear-gradient(top, #3cb0fd, #3498db);
    background-image: linear-gradient(to bottom, #3cb0fd, #3498db);
    cursor:hand;
    cursor:pointer;
    text-decoration: none;
}

.errorMessage { color: red; }
</style>

<div id='ajaxLogin' class="jqmWindow" style="z-index: 3000;">
    <form action='${request.contextPath}/j_spring_security_check' method='POST'
          id='login' name='ajaxLoginForm'>

        <h1>Log In</h1>

        <fieldset id="inputs">
            <input id="username" type="text" placeholder="Username" name='j_username' autofocus required>
            <input id="password" type="password" placeholder="Password" name='j_password' required>
        </fieldset>

        <p>
            <label for='remember_me'>Remember me</label>
            <input type='checkbox' class='chk' id='remember_me'
                   name='_spring_security_remember_me'/>
            <g:link controller='register' action='forgotPassword'><g:message code='spring.security.ui.login.forgotPassword'/></g:link>
            <g:link controller='register'><g:message code='spring.security.ui.login.register'/></g:link>
        </p>

        <fieldset id="actions">
            <input type="submit" class="button" id="authAjax" value="Log in">
            <input type="cancel" class="button" id="cancelLogin" value="Cancel">
        </fieldset>

        <div style='display: none; text-align: left;' id='loginMessage'></div>
    </form>
</div>

<script type='text/javascript'>
    var onLogin;
    $.ajaxSetup({
        beforeSend : function(xhr, event) {
            // save the 'success' function for later use
            onLogin = event.success;
        },
        statusCode: {
            // Set up a global AJAX error handler to handle the 401
            // unauthorized responses. If a 401 status code comes back,
            // the user is no longer logged-into the system and can not
            // use it properly.
            401: function() {
                showLogin();
            }
        }
    });

    function showLogin() {
        var ajaxLogin = $('#ajaxLogin');
        ajaxLogin.css('text-align','center');
        // use jqModal to show and align login panel
        ajaxLogin.jqmShow();
    }

    function cancelLogin() {
        $('#ajaxLogin').jqmHide();
    }

    function authAjax() {
        $('#loginMessage').html('Sending request ...').show();

        var form = $('#ajaxLoginForm');
        var config = {
            type : 'post'
            ,url : form.attr('action')
            ,data : form.serialize()
            ,async : false
            ,dataType : 'JSON'
            ,success: function(response) {
                form[0].reset();
                $('#loginMessage').empty();
                $('#ajaxLogin').jqmHide();
                if (onLogin) {
                    // execute the saved event.success function
                    onLogin(response);
                }
            }
            ,error : function (response) {
                var responseText = response.responseText || '[]';
                var json = responseText.evalJSON();
                if (json.error) {
                    $('#loginMessage').html("<span class='errorMessage'>" + json.error + '</error>');
                } else {
                    $('#loginMessage').html(responseText);
                }
            }
            ,beforeSend : function(xhr, event) {
                //console.log("overriding default behaviour");
            }
        }
        $.ajax(config);
    }

    $(function() {
        $('#ajaxLogin').jqm({modal: true, trigger: 'span.jqmTrigger'});
        $('#authAjax').click(authAjax);
        $('#cancelLogin').click(cancelLogin);
    });
</script>