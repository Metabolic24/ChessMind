import users.Administrator
import users.Moderator

import score.Score
import users.Role
import users.User
import users.UserRole

class BootStrap {

    def springSecurityService

    def init = { servletContext ->

        /*new Player(name: "toto", username: "toto", password: "toto", score: new Score(score1: 0l, score2: 0l), mail: "m@hotmail.fr").save(failOnError: true)
        new Moderator(name: "toto2", username: "aaaa", password: "bbbbb", score: new Score(score1: 0l, score2: 0l), mail: "m@hotmail.fr").save(failOnError: true)
        new Administrator(name: "toto3", username: "cccc", password: "bbbbb", score: new Score(score1: 0l, score2: 0l), mail: "m@hotmail.fr").save(failOnError: true)*/

        def userRole = Role.findByAuthority('ROLE_USER') ?: new Role(authority: 'ROLE_USER').save(failOnError: true, flush:true)
        def moderatorRole = Role.findByAuthority('ROLE_MODERATOR') ?: new Role(authority: 'ROLE_MODERATOR').save(failOnError: true, flush:true)
        def adminRole = Role.findByAuthority('ROLE_ADMIN') ?: new Role(authority: 'ROLE_ADMIN').save(failOnError: true, flush:true)

        def adminUser = User.findByUsername('admin') ?: new User(
                name: "toto",
                username: 'admin',
                score: new Score(score1: 0l, score2: 0l),
                email: "m@hotmail.fr",
                password: "admin",
                enabled: true).save(failOnError: true, flush:true)

        if (!adminUser.authorities.contains(adminRole)) {
            UserRole.create adminUser, adminRole, true
        }

        assert User.count() == 1
        assert Role.count() == 3
        assert UserRole.count() == 1
    }
    def destroy = {
    }
}
