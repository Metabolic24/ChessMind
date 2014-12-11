package problems

import grails.test.spock.IntegrationSpec
import org.apache.commons.io.IOUtils
import score.Score
import users.User

/**
 *
 */
class SolutionIntegrationSpec extends IntegrationSpec {

    User user, user2
    Problem problem

    def setup() {
        user = new User(username: "test", password: "test", email: "test@test.net", name: "testName",
                description: "descUser", score: new Score())
        user2 = new User(username: "test2", password: "test51", email: "test@test.net", name: "testName",
                description: "descUser", score: new Score())
        user.save(failOnError: true, flush: true)
        user2.save(failOnError: true, flush: true)
        problem = new Problem(image: IOUtils.toByteArray(this.class.getResourceAsStream("/resources/mate1.jpg")),
                description: "A problem submited by user",
                blackPlayer: "user",
                whitePlayer: "user2",
                place: "chessmind room",
                tournament: "chessmind tournament",
                date: new Date(),
                player: user2,
                bestSolution: null)
        problem.save(failOnError: true, flush: true)
    }

    void "test sortedComments"() {
        given: "A valid Solution"
        Solution solution = new Solution(answer: "Cf3", problem: problem, user:user)
        solution.save(failOnError: true,flush:true)

        and: "Some posted comments"
        Comment com1 = new Comment(text:"test1", solution:solution, user:user)
        Comment com2 = new Comment(text:"test2", solution:solution, user:user2)

        com1.save(failOnError: true, flush:true)
        com2.save(failOnError: true, flush:true)

        when: "We call sortedComments method on solution"
        solution.addToComments(com1)
        solution.addToComments(com2)
        def res = solution.sortedComments()

        then: "res is corrrectly filled"
        res.size() == 2;
        res.get(0).equals(com1)
        res.get(1).equals(com2)
    }
}
