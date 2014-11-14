package problems



import grails.test.mixin.*
import spock.lang.*
import users.User

@TestFor(SolutionController)
@Mock(Solution)
class SolutionControllerSpec extends Specification {

    def populateValidParams(params) {
        assert params != null
        params['answer'] = "a1"
        params['problem.id'] = 1
        params['user'] = Mock(User)
    }

    void "Test the index action returns the correct model"() {

        when:"The index action is executed"
            controller.index()

        then:"The model is correct"
            !model.solutionInstanceList
            model.solutionInstanceCount == 0
    }

    void "Test the create action returns the correct model"() {
        when:"The create action is executed"
            controller.create()

        then:"The model is correctly created"
            model.solutionInstance!= null
    }

    void "Test the save action correctly persists an instance"() {
        when:"Save is called for a domain instance that doesn't exist"
        request.contentType = FORM_CONTENT_TYPE
        controller.save(null)

        then:"A 404 error is returned"
        response.redirectedUrl == '/solution/index'
        flash.message != null

        when:"The save action is executed with an invalid instance"
            request.contentType = FORM_CONTENT_TYPE
            def solution = new Solution()
            solution.validate()
            controller.save(solution)

        then:"The create view is rendered again with the correct model"
            model.solutionInstance!= null
            view == 'create'

        when:"The save action is executed with a valid instance"
            response.reset()
            populateValidParams(params)
            solution = new Solution(params)

            controller.save(solution)

        then:"A redirect is issued to the show action"
            response.redirectedUrl == '/solution/show/1'
            controller.flash.message != null
            Solution.count() == 1
    }

    void "Test that the show action returns the correct model"() {
        when:"The show action is executed with a null domain"
            controller.show(null)

        then:"A 404 error is returned"
            response.status == 404

        when:"A domain instance is passed to the show action"
            populateValidParams(params)
            def solution = new Solution(params)
            controller.show(solution)

        then:"A model is populated containing the domain instance"
            model.solutionInstance == solution
    }

    void "Test that the edit action returns the correct model"() {
        when:"The edit action is executed with a null domain"
            controller.edit(null)

        then:"A 404 error is returned"
            response.status == 404

        when:"A domain instance is passed to the edit action"
            populateValidParams(params)
            def solution = new Solution(params)
            controller.edit(solution)

        then:"A model is populated containing the domain instance"
            model.solutionInstance == solution
    }

    void "Test the update action performs an update on a valid domain instance"() {
        when:"Update is called for a domain instance that doesn't exist"
            request.contentType = FORM_CONTENT_TYPE
            controller.update(null)

        then:"A 404 error is returned"
            response.redirectedUrl == '/solution/index'
            flash.message != null


        when:"An invalid domain instance is passed to the update action"
            response.reset()
            def solution = new Solution()
            solution.validate()
            controller.update(solution)

        then:"The edit view is rendered again with the invalid instance"
            view == 'edit'
            model.solutionInstance == solution

        when:"A valid domain instance is passed to the update action"
            response.reset()
            populateValidParams(params)
            solution = new Solution(params).save(flush: true)
            controller.update(solution)

        then:"A redirect is issues to the show action"
            response.redirectedUrl == "/solution/show/$solution.id"
            flash.message != null
    }

    void "Test that the delete action deletes an instance if it exists"() {
        when:"The delete action is called for a null instance"
            request.contentType = FORM_CONTENT_TYPE
            controller.delete(null)

        then:"A 404 is returned"
            response.redirectedUrl == '/solution/index'
            flash.message != null

        when:"A domain instance is created"
            response.reset()
            populateValidParams(params)
            def solution = new Solution(params).save(flush: true)

        then:"It exists"
            Solution.count() == 1

        when:"The domain instance is passed to the delete action"
            controller.delete(solution)

        then:"The instance is deleted"
            Solution.count() == 0
            response.redirectedUrl == '/solution/index'
            flash.message != null
    }
}
