package users

import grails.plugin.springsecurity.annotation.Secured
import grails.plugin.springsecurity.authentication.dao.NullSaltSource
import org.springframework.security.core.context.SecurityContextHolder
import problems.Problem
import score.Score

class UserController extends grails.plugin.springsecurity.ui.UserController {

    @Secured(['ROLE_ADMIN'])
    def save() {
        User user = lookupUserClass().newInstance(params)
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

    //TODO Verifier que la pagination fonctionne
    //TODO Voir si on ne peut pas remplacer la boucle par une closure
    @Secured(['ROLE_ADMIN'])
    def administrators(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        def list = User.filterByAuthority('ROLE_ADMIN',params)

        respond list, model:[adminInstanceCount: list?.size()]
    }

    @Secured(['ROLE_ADMIN'])
    def moderators(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        def list = User.filterByAuthority('ROLE_MODERATOR',params)

        respond list, model:[moderatorInstanceCount: list?.size()]
    }

    @Secured(['ROLE_ADMIN'])
    def show(User userInstance) {
        respond userInstance
    }

    def showMyProfile() {
        respond User.findByUsername(SecurityContextHolder.getContext().getAuthentication().name)
    }
}
