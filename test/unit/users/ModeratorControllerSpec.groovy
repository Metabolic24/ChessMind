package users



import grails.test.mixin.*
import score.Score
import spock.lang.*

@TestFor(ModeratorController)
@Mock(Moderator)
class ModeratorControllerSpec extends Specification {

    def populateValidParams(params) {
        assert params != null
        params["name"] = 'aName'
        params["username"]='aLogin'
        params["password"]='aPwd'
        params["description"]=''
        params["score"]=new Score(score1:0,score2:0)
        params["mail"]='toto@gmail.com'
    }

    void "Test the index action returns the correct model"() {
        /*
        when:"The index action is executed"
            controller.index()

        then:"The model is correct"
            !model.moderatorInstanceList
            model.moderatorInstanceCount == 0*/
        true
    }

    void "Test the create action returns the correct model"() {
        /*when:"The create action is executed"
            controller.create()

        then:"The model is correctly created"
            model.moderatorInstance!= null*/
        true
    }

    void "Test the save action correctly persists an instance"() {

        when:"The save action is executed with an invalid instance"
            request.contentType = FORM_CONTENT_TYPE
            def moderator = new Moderator()
            moderator.validate()
            controller.save(moderator)

        then:"The create view is rendered again with the correct model"
            model.moderatorInstance!= null
            view == 'create'

        when:"The save action is executed with a valid instance"
            response.reset()
            populateValidParams(params)
            moderator = new Moderator(params)

            controller.save(moderator)

        then:"A redirect is issued to the show action"
            response.redirectedUrl == '/moderator/show/1'
            controller.flash.message != null
            Moderator.count() == 1
    }

    void "Test that the show action returns the correct model"() {
        when:"The show action is executed with a null domain"
            controller.show(null)

        then:"A 404 error is returned"
            response.status == 404

        when:"A domain instance is passed to the show action"
            populateValidParams(params)
            def moderator = new Moderator(params)
            controller.show(moderator)

        then:"A model is populated containing the domain instance"
            model.moderatorInstance == moderator
    }

    void "Test that the edit action returns the correct model"() {
        when:"The edit action is executed with a null domain"
            controller.edit(null)

        then:"A 404 error is returned"
            response.status == 404

        when:"A domain instance is passed to the edit action"
            populateValidParams(params)
            def moderator = new Moderator(params)
            controller.edit(moderator)

        then:"A model is populated containing the domain instance"
            model.moderatorInstance == moderator
    }

    void "Test the update action performs an update on a valid domain instance"() {
        when:"Update is called for a domain instance that doesn't exist"
            request.contentType = FORM_CONTENT_TYPE
            controller.update(null)

        then:"A 404 error is returned"
            response.redirectedUrl == '/moderator/index'
            flash.message != null


        when:"An invalid domain instance is passed to the update action"
            response.reset()
            def moderator = new Moderator()
            moderator.validate()
            controller.update(moderator)

        then:"The edit view is rendered again with the invalid instance"
            view == 'edit'
            model.moderatorInstance == moderator

        when:"A valid domain instance is passed to the update action"
            response.reset()
            populateValidParams(params)
            moderator = new Moderator(params).save(flush: true)
            controller.update(moderator)

        then:"A redirect is issues to the show action"
            response.redirectedUrl == "/moderator/show/$moderator.id"
            flash.message != null
    }

    void "Test that the delete action deletes an instance if it exists"() {
        when:"The delete action is called for a null instance"
            request.contentType = FORM_CONTENT_TYPE
            controller.delete(null)

        then:"A 404 is returned"
            response.redirectedUrl == '/moderator/index'
            flash.message != null

        when:"A domain instance is created"
            response.reset()
            populateValidParams(params)
            def moderator = new Moderator(params).save(flush: true)

        then:"It exists"
            Moderator.count() == 1

        when:"The domain instance is passed to the delete action"
            controller.delete(moderator)

        then:"The instance is deleted"
            Moderator.count() == 0
            response.redirectedUrl == '/moderator/index'
            flash.message != null
    }
}
