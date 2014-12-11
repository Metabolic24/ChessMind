package problems

import grails.test.mixin.TestFor
import spock.lang.Specification
import users.User

/**
 * See the API for {@link grails.test.mixin.domain.DomainClassUnitTestMixin} for usage instructions
 */
@TestFor(Comment)
class CommentSpec extends Specification {

    Comment comment

    def setup() {
        comment = new Comment()
        comment.user = Mock(User)
        comment.solution = Mock(Solution)
    }

    void "Constraints test on valid comment"() {
        given: "a valid comment"
        comment.text = "testComment"
        when: "we trigger the validation of the player"
        def res = comment.validate()

        then: "the player has no validation error"
        res
        !comment.hasErrors()
    }

    void "Constraints test on invalid comment"() {
        given: "a valid comment"
        comment.text = aText

        when: "we trigger the validation of the player"
        def res = comment.validate()

        then: "the player has no validation error"
        !res
        comment.hasErrors()
        where:
        aText | _
        ""    | _
        null  | _
    }
}
