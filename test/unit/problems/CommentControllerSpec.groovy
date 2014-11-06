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

    void "Test the index action returns the correct model"() {

        when: "The index action is executed"
        controller.index()

        then: "The model is correct"
        !model.commentInstanceList
        model.commentInstanceCount == 0
    }

    void "Test the create action returns the correct model"() {
        when: "The create action is executed"
        controller.create()

        then: "The model is correctly created"
        model.commentInstance != null
    }

    void "Test that the show action returns the correct model"() {
        when: "The show action is executed with a null domain"
        controller.show(null)

        then: "A 404 error is returned"
        response.status == 404

        when: "A domain instance is passed to the show action"
        populateValidParams(params)
        def comment = new Comment(params)
        controller.show(comment)

        then: "A model is populated containing the domain instance"
        model.commentInstance == comment
    }

    void "Test that the edit action returns the correct model"() {
        when: "The edit action is executed with a null domain"
        controller.edit(null)

        then: "A 404 error is returned"
        response.status == 404

        when: "A domain instance is passed to the edit action"
        populateValidParams(params)
        def comment = new Comment(params)
        controller.edit(comment)

        then: "A model is populated containing the domain instance"
        model.commentInstance == comment
    }

    void "Test the update action performs an update on a valid domain instance"() {
        when: "Update is called for a domain instance that doesn't exist"
        request.contentType = FORM_CONTENT_TYPE
        controller.update(null)

        then: "A 404 error is returned"
        response.redirectedUrl == '/comment/index'
        flash.message != null


        when: "An invalid domain instance is passed to the update action"
        response.reset()
        def comment = new Comment()
        comment.validate()
        controller.update(comment)

        then: "The edit view is rendered again with the invalid instance"
        view == 'edit'
        model.commentInstance == comment

        when: "A valid domain instance is passed to the update action"
        response.reset()
        populateValidParams(params)
        comment = new Comment(params).save(flush: true)
        controller.update(comment)

        then: "A redirect is issues to the show action"
        response.redirectedUrl == "/comment/show/$comment.id"
        flash.message != null
    }
}
