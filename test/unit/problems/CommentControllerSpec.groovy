package problems


import grails.test.mixin.*
import spock.lang.*

@TestFor(CommentController)
@Mock(Comment)
class CommentControllerSpec extends Specification {

    void "Test the create action returns the correct model"() {
        given: "The number of comment"
        def count = Comment.count()

        when: "The create action is executed"
        controller.create()

        then: "The model is correctly created"
        count == Comment.count()-1
    }
}
