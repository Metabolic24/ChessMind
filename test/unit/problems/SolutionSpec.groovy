package problems

import grails.test.mixin.TestFor
import problems.Solution
import spock.lang.Specification
import spock.lang.Unroll
import users.User

/**
 * See the API for {@link grails.test.mixin.domain.DomainClassUnitTestMixin} for usage instructions
 */
@TestFor(Solution)
class SolutionSpec extends Specification {

    Solution solution
    User user
    Problem problem

    def setup() {
        solution = new Solution()
        problem = Mock(Problem)
        user = Mock(User)
    }

    def cleanup() {
    }

    @Unroll
    void "Constraints test on valid solution (id : #anId)"() {

        given: "a valid solution"
        solution.user = user
        solution.problem = problem
        solution.id = anId
        solution.answer = anAnswer
        solution.aime = anAime
        solution.isBestSolution = aBestSolution

        when: "we trigger the validation of the solution"
        def res = solution.validate()

        then: "the solution has no validation error"
        res
        !solution.hasErrors()

        where:
        anId | anAnswer  | anAime | aBestSolution
        1    | "Cf3"     | 0      | false
        2    | "Cf3-Ce5" | 0      | false
        3    | "Df8"     | 1      | true
        4    | "Df8-De7" | 1      | false
        5    | "Tf8"     | 1      | true
        6    | "Tf8-Tf7" | 1      | true
        7    | "Ff8"     | 1      | true
        8    | "Ff8-Fe7" | 1      | true
        9    | "Rf8"     | 1      | true
        10   | "Rf8-Rf7" | 1      | true
        11   | "e4"      | 1      | true
        12   | "e4-e5"   | 1      | true
        13   | "0-0"     | 1      | true
        14   | "0-0-0"   | 1      | true
        15   | "Cf4xe5"  | 1      | true
        16   | "Cf7+"    | 1      | true
    }

    @Unroll
    void "Constraints test on invalid solution (id : #anId)"() {

        given: "an invalid solution"
        solution.user = user
        solution.problem = problem
        solution.id = anId
        solution.answer = anAnswer
        solution.aime = anAime
        solution.isBestSolution = aBestSolution

        when: "we trigger the validation of the solution"
        def res = solution.validate()

        then: "the solution has no validation error"
        !res
        solution.hasErrors()

        where:
        anId | anAnswer | anAime | aBestSolution
        1  | "Cf0"       | 0 | false
        42 | null        | 0 | false
        43 | ""          | 0 | false
        2  | "Cf9-"      | 0 | false
        3  | "Df11"      | 1 | true
        4  | "Df8-D7"    | 1 | false
        5  | "Pf8"       | 1 | true
        6  | "Tf8-Tf"    | 1 | true
        11 | "e4x5"      | 1 | true
        12 | "e+"        | 1 | true
        13 | "0-0+"      | 1 | true
        14 | "0-0-0xCf8" | 1 | true
        44 | "a1-a9"     | 0 | false
        45 | "a42"       | 0 | false
        46 | "0-"        | 0 | false
        47 | "0-0-3"     | 0 | false
        48 | "Lf3"       | 1 | true
        49 | "De9"       | 1 | true
    }
}
