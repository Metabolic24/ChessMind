package alert



import grails.test.mixin.*
import org.springframework.security.core.Authentication
import org.springframework.security.core.context.SecurityContext
import org.springframework.security.core.context.SecurityContextHolder
import problems.Problem
import spock.lang.*
import users.User

@TestFor(AlertController)
@Mock([Alert])
class AlertControllerSpec extends Specification {

    def populateValidParams(params) {
        assert params != null
        params['user'] = Mock(User)
        params['description'] = "La description doit être plus poussée !"
        params['problem'] = Mock(Problem)
    }

    void "Test the index action returns the correct model"() {

        when:"The index action is executed"
            controller.index()

        then:"The model is correct"
            !model.alertInstanceList
            model.alertInstanceCount == 0
    }

    void "Test the create action returns the correct model"() {
        when:"The create action is executed"
            controller.create()

        then:"The model is correctly created"
            model.alertInstance!= null
    }

    void "Test the save action correctly persists an instance"() {
        given:"A connected user"
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
        Problem.metaClass.static.findById = { id -> Mock(Problem) }

        when:"Save is called for a domain instance that doesn't exist"
            request.contentType = FORM_CONTENT_TYPE
            controller.save(null)

        then:"A redirect is issued to the index problem action"
            model.solutionInstance == null
            response.redirectedUrl == '/problem/index'
            flash.error != null

        when:"The save action is executed with an invalid instance alone"
            response.reset()
            def alert = new Alert()
            alert.validate()
            controller.save(alert)

        then:"A redirect is issued to the index problem action"
            model.solutionInstance == null
            response.redirectedUrl == '/problem/index'
            flash.error != null

        when:"The save action is executed with an invalid instance after setting problemId"
            response.reset()
            params.problemId = 1
            alert = new Alert()
            alert.validate()
            controller.save(alert)

        then:"The create view is rendered again with the correct model"
            model.alertInstance != null
            view == 'create'

        when:"The save action is executed with a valid instance alone"
        response.reset()
        populateValidParams(params)
        params.problemId = null
        alert = new Alert(params)

        controller.save(alert)

        then:"A redirect is issued to the index problem action"
        model.solutionInstance == null
        response.redirectedUrl == '/problem/index'
        flash.error != null

        when:"The save action is executed with a valid instance after setting problemId"
            response.reset()
            populateValidParams(params)
            params.problemId = 1
            alert = new Alert(params)

            controller.save(alert)

        then:"A redirect is issued to the show action"
            response.redirectedUrl.contains('/problem/show/')
            controller.flash.message != null
            Alert.count() == 1
    }

    void "Test that the delete action deletes an instance if it exists"() {
        when:"The delete action is called for a null instance"
            request.contentType = FORM_CONTENT_TYPE
            controller.delete(null)

        then:"A 404 is returned"
            response.redirectedUrl == '/alert/index'
            flash.message != null

        when:"A domain instance is created"
            response.reset()
            populateValidParams(params)
            def alert = new Alert(params).save(flush: true)

        then:"It exists"
            Alert.count() == 1

        when:"The domain instance is passed to the delete action"
            controller.delete(alert)

        then:"The instance is deleted"
            Alert.count() == 0
            response.redirectedUrl == '/alert/index'
            flash.message != null
    }
}
