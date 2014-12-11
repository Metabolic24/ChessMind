package alert

import grails.test.mixin.TestFor
import problems.Problem
import spock.lang.Specification
import spock.lang.Unroll
import users.User

/**
 * See the API for {@link grails.test.mixin.domain.DomainClassUnitTestMixin} for usage instructions
 */
@TestFor(Alert)
class AlertSpec extends Specification {

    Alert alert
    Problem problem
    User user

    def setup() {
        alert = new Alert()
        problem = Mock(Problem)
        user = Mock(User)
    }

    @Unroll
    void "Constraints test on valid alert (id : #anId)"() {
        given: "A valid alert"
        alert.user = user
        alert.description = aDescription
        alert.problem = problem

        when: "we trigger the validation of the problem"
        def res = alert.validate()

        then: "the problem has no validation error"
        res
        !alert.hasErrors()

        where:
        anId | aDescription
        1    | "ma description"
    }

    @Unroll
    void "Constraints test on invalid alert (id : #anId)"() {
        given: "An invalid alert"
        alert.user = user
        alert.description = aDescription
        alert.problem = problem

        when: "we trigger the validation of the problem"
        def res = alert.validate()

        then: "the problem has validation error"
        !res
        alert.hasErrors()

        where:
        anId | aDescription
        1    | ""
        42   | null
    }
}
