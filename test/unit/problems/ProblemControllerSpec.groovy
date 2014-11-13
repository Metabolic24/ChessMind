package problems


import grails.test.mixin.*
import org.springframework.security.core.Authentication
import org.springframework.security.core.context.SecurityContext
import org.springframework.security.core.context.SecurityContextHolder
import score.Score
import spock.lang.*
import users.Role
import users.User
import java.util.Set

@TestFor(ProblemController)
@Mock([Problem, Role])
class ProblemControllerSpec extends Specification {

    def populateValidParams(params) {
        assert params != null
        params["image"] = [0, 1]
        params["description"] = ''
        params["blackPlayer"] = ''
        params["whitePlayer"] = ''
        params["date"] = new Date()
        params["place"] = ''
        params["tournament"] = ''
        params["solved"] = false
        params["valide"] = false
        params["player"] = Mock(User)
    }

    void "Test the index action returns the correct model"() {

        when: "The index action is executed"
        controller.index()

        then: "The model is correct"
        !model.problemInstanceList
        model.problemInstanceCount == 0
    }

    void "Test the create action returns the correct model"() {
        when: "The create action is executed"
        controller.create()

        then: "The model is correctly created"
        model.problemInstance != null
    }

    void "Test the save action correctly persists an instance"() {
        when: "Save is called for a domain instance that doesn't exist"
        request.contentType = FORM_CONTENT_TYPE
        controller.save(null)

        then: "A 404 error is returned"
        response.redirectedUrl == '/problem/index'
        flash.message != null

        when: "The save action is executed with an invalid instance"
        def problem = new Problem()
        problem.validate()
        controller.save(problem)

        then: "The create view is rendered again with the correct model"
        model.problemInstance != null
        view == 'create'

        when: "The save action is executed with a valid instance"
        response.reset()
        populateValidParams(params)
        problem = new Problem(params)

        controller.save(problem)

        then: "A redirect is issued to the show action"
        response.redirectedUrl == '/problem/show/1'
        controller.flash.message != null
        Problem.count() == 1
    }

    void "Test that the show action returns the correct model"() {
        when: "The show action is executed with a null domain"
        controller.show(null)

        then: "A 404 error is returned"
        response.status == 404

        when: "A domain instance is passed to the show action"
        populateValidParams(params)
        def problem = new Problem(params)
        controller.show(problem)

        then: "A model is populated containing the domain instance"
        model.problemInstance == problem
    }

    void "Test that the edit action returns the correct model"() {
        when: "The edit action is executed with a null domain"
        controller.edit(null)

        then: "A 404 error is returned"
        response.status == 404

        when: "A domain instance is passed to the edit action"
        populateValidParams(params)
        def problem = new Problem(params)
        controller.edit(problem)

        then: "A model is populated containing the domain instance"
        model.problemInstance == problem
    }

    void "Test the update action performs an update on a valid domain instance"() {
        when: "Update is called for a domain instance that doesn't exist"
        request.contentType = FORM_CONTENT_TYPE
        controller.update(null)

        then: "A 404 error is returned"
        response.redirectedUrl == '/problem/index'
        flash.message != null


        when: "An invalid domain instance is passed to the update action"
        response.reset()
        def problem = new Problem()
        problem.validate()
        controller.update(problem)

        then: "The edit view is rendered again with the invalid instance"
        view == 'edit'
        model.problemInstance == problem

        when: "A valid domain instance is passed to the update action"
        response.reset()
        populateValidParams(params)
        problem = new Problem(params).save(flush: true)
        controller.update(problem)

        then: "A redirect is issues to the show action"
        response.redirectedUrl == "/problem/show/$problem.id"
        flash.message != null
    }

    void "Test that the delete action deletes an instance if it exists"() {
        when: "The delete action is called for a null instance"
        request.contentType = FORM_CONTENT_TYPE
        controller.delete(null)

        then: "A 404 is returned"
        response.redirectedUrl == '/problem/index'
        flash.message != null

        when: "A domain instance is created"
        response.reset()
        populateValidParams(params)
        def problem = new Problem(params).save(flush: true)

        then: "It exists"
        Problem.count() == 1

        when: "The domain instance is passed to the delete action"
        controller.delete(problem)

        then: "The instance is deleted"
        Problem.count() == 0
        response.redirectedUrl == '/problem/index'
        flash.message != null
    }

    void "Test update valide"() {
        given: "A valid problem"
        populateValidParams(params)
        def problem = new Problem(params).save(failOnError: true, flush: true)

        when: "The valide is executed"
        controller.validate(problem)

        then: "Valide attribute is true"
        problem.valide == true
    }

    void "Test that the my_problems returns the correct problems number"() {

        given: "An user and some problems added to him"

        def player = Mock(User)
        player.getUsername() >> "admin"

        Set<Problem> problems = new ArrayList<Problem>()
        Problem p1 = new Problem(player: player, image: [0, 1], valide: true).save(failOnError: true, flush: true)
        Problem p2 = new Problem(player: player, image: [0, 1], valide: true).save(failOnError: true, flush: true)
        Problem p3 = new Problem(player: player, image: [0, 1], valide: true).save(failOnError: true, flush: true)

        problems.add(p1)
        problems.add(p2)
        problems.add(p3)

        player.getProblems() >> problems

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

        when: "The my_problems is executed"
        controller.my_problems()

        then: "A model is displaying all problems of the current player"
        model.problemInstanceCount == problems.size()
    }

    void "Test that the valid_problems returns the correct problems number"() {

        given: "An user and some problems added to him"

        def player = Mock(User)
        player.getUsername() >> "admin"

        Set<Problem> problems = new ArrayList<Problem>()
        Problem p1 = new Problem(player: player, image: [0, 1], valide: true).save(failOnError: true, flush: true)
        Problem p2 = new Problem(player: player, image: [0, 1], valide: true).save(failOnError: true, flush: true)
        Problem p3 = new Problem(player: player, image: [0, 1], valide: true).save(failOnError: true, flush: true)

        problems.add(p1)
        problems.add(p2)
        problems.add(p3)

        player.getProblems() >> problems

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

        when: "The my_problems is executed"
        controller.problems_to_validate()

        then: "A model is displaying all problems of the current player"
        model.problemInstanceCount == problems.size()
    }

    void "Test that the problems_to_validate returns the correct problems number"() {

        given: "An user and some problems added to him"

        def player = Mock(User)
        player.getUsername() >> "admin"

        Set<Problem> problems = new ArrayList<Problem>()
        Problem p1 = new Problem(player: player, image: [0, 1], valide: true).save(failOnError: true, flush: true)
        Problem p2 = new Problem(player: player, image: [0, 1], valide: true).save(failOnError: true, flush: true)
        Problem p3 = new Problem(player: player, image: [0, 1], valide: true).save(failOnError: true, flush: true)

        problems.add(p1)
        problems.add(p2)
        problems.add(p3)

        player.getProblems() >> problems

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

        when: "The my_problems is executed"
        controller.valid_problems()

        then: "A model is displaying all problems of the current player"
        model.problemInstanceCount == problems.size()
    }

    void "Test of the method answer()"() {
        given: "a valid problem"
        populateValidParams(params)
        def problem = new Problem(params).save(failOnError: true, flush: true)

        when: "We call the answer method"
        controller.answer()

        then: "The redirection is correct"
        response.redirectedUrl == '/solution/create'
        controller.flash.message == null
        Problem.count() == 1
    }

    void "Test validate_from_list method"() {
        given: "A valid problem"
        populateValidParams(params)
        def problem = new Problem(params).save(failOnError: true, flush: true)

        when: "we call validate_from_list on the problem"
        controller.validateFromList(problem)

        then: "we check that problem is valid and that the redirection is ok"
        problem.isValide()
        response.redirectedUrl == '/problem/index'
        controller.flash.message == null
        Problem.count() == 1
    }
}
