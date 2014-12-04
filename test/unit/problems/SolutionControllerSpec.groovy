package problems



import grails.test.mixin.*
import org.springframework.security.core.Authentication
import org.springframework.security.core.context.SecurityContext
import org.springframework.security.core.context.SecurityContextHolder
import spock.lang.*
import users.User

@TestFor(SolutionController)
@Mock(Solution)
class SolutionControllerSpec extends Specification {

    def populateValidParams(params) {
        assert params != null
        params['answer'] = "a1"
        params['problem.id'] = 1
        params['isBestSolution'] = false
        params['user'] = Mock(User)
    }

    void "Test the create action returns the correct model"() {
        when:"The create action is executed alone"
            controller.create()

        then:"The model is not created"
            model.solutionInstance == null
            response.redirectedUrl == '/problem/index'
            flash.error != null

        when:"The create action is executed after setting problemId"
            params.problemId = 1
            controller.create()

        then:"The model is correctly created"
            model.solutionInstance != null
    }

    void "Test the save action correctly persists an instance"() {
        given: "A valid SecurityContext"
        def auth = Mock(Authentication)
        auth.getName() >> "admin"

        SecurityContextHolder.setContext(new SecurityContext() {
            @Override
            Authentication getAuthentication() {
                return auth
            }

            @Override
            void setAuthentication(Authentication authentication) {

            }
        })

        User.metaClass.static.findByUsername = { l -> Mock(User) }

        when:"Save is called for a domain instance that doesn't exist"
            request.contentType = FORM_CONTENT_TYPE
            controller.save(null)

        then:"A 404 error is returned"
            response.redirectedUrl == '/problem/index'
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

    void "Test that the delete action deletes an instance if it exists"() {
        when:"The delete action is called for a null instance"
            request.contentType = FORM_CONTENT_TYPE
            controller.delete(null)

        then:"A 404 is returned"
            response.redirectedUrl == '/problem/index'
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
