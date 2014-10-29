import users.Administrator
import users.Moderator
import users.Player
import score.Score
import users.SecRole
import users.SecUser
import users.SecUserSecRole

class BootStrap {

    def springSecurityService

    def init = { servletContext ->

        /*new Player(name: "toto", username: "toto", password: "toto", score: new Score(score1: 0l, score2: 0l), mail: "m@hotmail.fr").save(failOnError: true)
        new Moderator(name: "toto2", username: "aaaa", password: "bbbbb", score: new Score(score1: 0l, score2: 0l), mail: "m@hotmail.fr").save(failOnError: true)
        new Administrator(name: "toto3", username: "cccc", password: "bbbbb", score: new Score(score1: 0l, score2: 0l), mail: "m@hotmail.fr").save(failOnError: true)*/

        def userRole = SecRole.findByAuthority('ROLE_USER') ?: new SecRole(authority: 'ROLE_USER').save(failOnError: true, flush:true)
        def adminRole = SecRole.findByAuthority('ROLE_ADMIN') ?: new SecRole(authority: 'ROLE_ADMIN').save(failOnError: true, flush:true)

        def adminUser = SecUser.findByUsername('admin') ?: new Administrator(
                name: "toto",
                username: 'admin',
                score: new Score(score1: 0l, score2: 0l),
                mail: "m@hotmail.fr",
                password: "admin",
                enabled: true).save(failOnError: true, flush:true)

        if (!adminUser.authorities.contains(adminRole)) {
            SecUserSecRole.create adminUser, adminRole, true
        }

        assert SecUser.count() == 1
        assert SecRole.count() == 2
        assert SecUserSecRole.count() == 1

    }
    def destroy = {
    }
}
