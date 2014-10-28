package users

import grails.plugin.springsecurity.authentication.dao.NullSaltSource
import score.Score

class UserController extends grails.plugin.springsecurity.ui.UserController {

    def save() {
        def user = lookupUserClass().newInstance(params)
        if (params.password) {
            String salt = saltSource instanceof NullSaltSource ? null : params.username
            user.password = springSecurityUiService.encodePassword(params.password, salt)
        }

        if(user.score==null) {
            user.score = new Score(score1:0l,score2:0l)
            user.validate()
        }

        if (!user.save(flush: true)) {
            render view: 'create', model: [user: user, authorityList: sortedRoles()]
            return
        }

        addRoles(user)
        flash.message = "${message(code: 'default.created.message', args: [message(code: 'user.label', default: 'User'), user.id])}"
        redirect action: 'edit', id: user.id
    }

}
