package problems

import grails.test.mixin.TestFor
import spock.lang.Specification
import spock.lang.Unroll
import users.User

/**
 * See the API for {@link grails.test.mixin.domain.DomainClassUnitTestMixin} for usage instructions
 */
@TestFor(Problem)
class ProblemSpec extends Specification {

    Problem problem
    User player

    def setup() {
        problem = new Problem()
        player = Mock(User)
    }

    def cleanup() {
    }

    @Unroll
    void "Constraints test on valid problem (id : #anId)"() {

        given: "a valid problem"
        problem.id = anId
        problem.image = anImage
        problem.description = aDescription
        problem.blackPlayer = aBlackPlayer
        problem.whitePlayer = aWhitePlayer
        problem.date = aDate
        problem.place = aPlace
        problem.tournament = aTournament
        problem.bestSolution = null
        problem.player = player

        when: "we trigger the validation of the problem"
        def res = problem.validate()

        then: "the problem has no validation error"
        res
        !problem.hasErrors()

        where:
        anId | anImage | aDescription    | aBlackPlayer     | aWhitePlayer     | aDate      | aPlace    | aTournament
        1    | [0, 1]  | "A description" | "A black user" | "A white user" | new Date() | "A place" | "A tournament"
        2    | [0, 1]  | ""              | "A black user" | "A white user" | new Date() | "A place" | "A tournament"
        3    | [0, 1]  | "A description" | ""               | "A white user" | new Date() | "A place" | "A tournament"
        4    | [0, 1]  | "A description" | "A black user" | ""               | new Date() | "A place" | "A tournament"
        5    | [0, 1]  | "A description" | "A black user" | "A white user" | new Date() | ""        | "A tournament"
        6    | [0, 1]  | "A description" | "A black user" | "A white user" | new Date() | "A place" | ""
        7    | [0, 1]  | "A description" | "A black user" | "A white user" | new Date() | "A place" | "A tournament"
        8    | [0, 1]  | null            | "A black user" | "A white user" | new Date() | "A place" | "A tournament"
        9    | [0, 1]  | "A description" | null             | "A white user" | new Date() | "A place" | "A tournament"
        10   | [0, 1]  | "A description" | "A black user" | null             | new Date() | "A place" | "A tournament"
        11   | [0, 1]  | "A description" | "A black user" | "A white user" | null       | "A place" | "A tournament"
        12   | [0, 1]  | "A description" | "A black user" | "A white user" | new Date() | null      | "A tournament"
        13   | [0, 1]  | "A description" | "A black user" | "A white user" | new Date() | "A place" | null

    }

    @Unroll
    void "Constraints test on invalid problem (id : #anId)"() {

        given: "an invalid problem"
        problem.id = anId
        problem.image = anImage
        problem.description = "A description"
        problem.blackPlayer = "A black user"
        problem.whitePlayer = "A white user"
        problem.date = new Date()
        problem.place = "A place"
        problem.tournament = "A tournament"
        problem.bestSolution = null
        problem.player = player

        when: "we trigger the validation of the problem"
        def res = problem.validate()

        then: "the problem has no validation error"
        !res
        problem.hasErrors()

        where:
        anId | anImage
        1    | null
        2    | new byte[3145729]
    }

    void "Test de la fonction sortedSolutions"() {
        given: "a valid Problem"
            def problem = new Problem(image:[0, 1], player:Mock(User))
            problem.save(failOnError:true, flush:true)

        when: "we use sortedSolutions when no solutions"
            def res = problem.sortedSolutions()

        then: "the result is null"
            res==null

        when: "we use sortedSolutions with at least one solution"
            def solution = Mock(Solution)
            def solution2 = Mock(Solution)
            problem.solutions = new HashSet<>();
            problem.solutions.add(solution);
            problem.solutions.add(solution2);
            solution.getAime() >> 2
            solution2.getAime() >> 1

            res = problem.sortedSolutions()

        then: "the result is not null"
            res != null

        when: "we use sortedSolutions with at least one solution"
        problem.solutions = new HashSet<>();
        solution2.getAime() >> 1
        solution.getAime() >> 1

        def comments = new HashSet<>();
        comments.add(Mock(Comment))
        comments.add(Mock(Comment))

        def comments2 = new HashSet<>();
        comments2.add(Mock(Comment))

        solution.getComments() >> comments
        solution2.getComments() >> comments2

        //TODO Problème au niveau des comments (size non appelé?, null object?)

        problem.solutions.add(solution);
        problem.solutions.add(solution2);

        res = problem.sortedSolutions()

        then: "the result is not null"
        res != null
    }
}
