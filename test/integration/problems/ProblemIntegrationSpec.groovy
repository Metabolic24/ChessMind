package problems

import grails.test.spock.IntegrationSpec
import org.apache.commons.io.IOUtils
import users.User
import score.Score

/**
 * Created by loic on 11/12/14.
 */

public class ProblemIntegrationSpec extends IntegrationSpec {

    Problem problem
    //Solution bestSolution
    User user
    //User user2

    def setup() {

        user = new User(username: "test", password: "test", email: "test@test.net", name: "testName",
                description: "descUser", score: new Score())

        //user2 = new User(username: "test2", password: "test2", email: "test2@test2.net", name: "test2Name",
        //        description: "descUser2")

        //bestSolution = new Solution(user: user, answer: "Cf3", aime: 0, isBestSolution: false)
    /*
        problem = new Problem(image: IOUtils.toByteArray(this.class.getResourceAsStream("/resources/mate1.jpg")),
                description: "A problem submited by user2",
                blackPlayer: "user",
                whitePlayer: "user2",
                place: "chessmind room",
                tournament: "chessmind tournament",
                date: new Date(),
                bestSolution: bestSolution)
*/
        user.save(failOnError: true)
        //user2.save(failOnError: true)
        //bestSolution.save(failOnError: true)
        //problem.save(failOnError: true)
    }

    void "test d'ajout d'une proposition d'un problème par un utilisateur"() {

        given : "un problème"
        problem = new Problem(image: IOUtils.toByteArray(this.class.getResourceAsStream("/resources/mate1.jpg")),
                description: "A problem submited by user",
                blackPlayer: "user",
                whitePlayer: "user2",
                place: "chessmind room",
                tournament: "chessmind tournament",
                date: new Date(),
                bestSolution: null)

        when : "ajout du problème au user"
        user.addToProblems(problem)
        problem.setPlayer(user)
        problem.save(failOnError: true, flush: true)

        then : "le problème appartient bien au user"
        user.getProblems().contains(problem)
        problem.getPlayer().equals(user)
    }

}