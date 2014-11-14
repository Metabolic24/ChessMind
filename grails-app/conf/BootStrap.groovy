import org.apache.commons.io.IOUtils
import problems.Comment
import problems.Problem
import problems.Solution
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

        def admin = User.findByUsername('admin') ?: new User(
                name: "toto",
                username: 'admin',
                score: new Score(score1: 0l, score2: 0l),
                email: "m@hotmail.fr",
                password: "admin",
                enabled: true).save(failOnError: true, flush:true)

        def moderator = User.findByUsername('moderator') ?: new User(
                name: "titi",
                username: 'moderator',
                score: new Score(score1: 0l, score2: 0l),
                email: "mo@hotmail.fr",
                password: "moderator",
                enabled: true).save(failOnError: true, flush:true)

        def user = User.findByUsername('user') ?: new User(
                name: "tata",
                username: 'user',
                score: new Score(score1: 0l, score2: 0l),
                email: "u@hotmail.fr",
                password: "user",
                enabled: true).save(failOnError: true, flush:true)

        if (!admin.authorities.contains(adminRole)) {
            UserRole.create admin, adminRole, true
        }

        if (!user.authorities.contains(userRole)) {
            UserRole.create user, userRole, true
        }

        if (!moderator.authorities.contains(moderatorRole)) {
            UserRole.create moderator, moderatorRole, true
        }

        byte[] image = IOUtils.toByteArray(this.class.getResourceAsStream("/resources/mate1.jpg"))
        byte[] image2 = IOUtils.toByteArray(this.class.getResourceAsStream("/resources/mate2.jpg"))
        byte[] image3 = IOUtils.toByteArray(this.class.getResourceAsStream("/resources/mate3.jpg"))

        def problemTest = new Problem(player: admin, image:image, valide:true).save(failOnError: true, flush: true)
        def problemTest2 = new Problem(player: user, image:image2, valide:true).save(failOnError: true, flush: true)
        def problemTest3 = new Problem(player: user, image:image3, valide:false).save(failOnError: true, flush: true)

        def solution1 = new Solution(user: admin, answer : "Ca1", problem: problemTest).save(failOnError: true, flush: true)
        def solution2 = new Solution(user: user, answer : "Ca2", problem: problemTest2).save(failOnError: true, flush: true)
        def solution3 = new Solution(user: user, answer : "Ca3", problem: problemTest3).save(failOnError: true, flush: true)

        def comment1 = new Comment(text : "C'est une bonne solution 1", user : admin, solution: solution1).save(failOnError: true, flush: true)
        def comment2 = new Comment(text : "C'est une mauvaise solution 2", user : admin, solution: solution2).save(failOnError: true, flush: true)
        def comment3 = new Comment(text : "C'est une bonne solution 3", user : user, solution: solution1).save(failOnError: true, flush: true)
        def comment4 = new Comment(text : "C'est une mauvaise solution 4", user : user, solution: solution2).save(failOnError: true, flush: true)

        assert User.count() == 3
        assert Role.count() == 3
        assert UserRole.count() == 3
    }
    def destroy = {
    }
}
