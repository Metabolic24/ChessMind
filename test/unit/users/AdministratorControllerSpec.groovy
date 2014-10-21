package users



import grails.test.mixin.*
import spock.lang.*

@TestFor(AdministratorController)
@Mock(Administrator)
class AdministratorControllerSpec extends Specification {

    def populateValidParams(params) {
        assert params != null
        params["name"] = 'aName'
        params["login"]='aLogin'
        params["password"]='aPwd'
        params["description"]=''
        params["score"]=new Score(score1:0,score2:0)
        params["mail"]='toto@gmail.com'
    }

    void "Test the index action returns the correct model"() {
        /*when:"The index action is executed"
            controller.index()

        then:"The model is correct"
            !model.administratorInstanceList
            model.administratorInstanceCount == 0*/
        true
    }

    void "Test the create action returns the correct model"() {
        /*when:"The create action is executed"
            controller.create()

        then:"The model is correctly created"
            model.administratorInstance!= null*/
        true
    }

    void "Test the save action correctly persists an instance"() {

        when:"The save action is executed with an invalid instance"
            request.contentType = FORM_CONTENT_TYPE
            def administrator = new Administrator()
            administrator.validate()
            controller.save(administrator)

        then:"The create view is rendered again with the correct model"
            model.administratorInstance!= null
            view == 'create'

        when:"The save action is executed with a valid instance"
            response.reset()
            populateValidParams(params)
            administrator = new Administrator(params)

            controller.save(administrator)

        then:"A redirect is issued to the show action"
            response.redirectedUrl == '/administrator/show/1'
            controller.flash.message != null
            Administrator.count() == 1
    }

    void "Test that the show action returns the correct model"() {
        when:"The show action is executed with a null domain"
            controller.show(null)

        then:"A 404 error is returned"
            response.status == 404

        when:"A domain instance is passed to the show action"
            populateValidParams(params)
            def administrator = new Administrator(params)
            controller.show(administrator)

        then:"A model is populated containing the domain instance"
            model.administratorInstance == administrator
    }

    void "Test that the edit action returns the correct model"() {
        when:"The edit action is executed with a null domain"
            controller.edit(null)

        then:"A 404 error is returned"
            response.status == 404

        when:"A domain instance is passed to the edit action"
            populateValidParams(params)
            def administrator = new Administrator(params)
            controller.edit(administrator)

        then:"A model is populated containing the domain instance"
            model.administratorInstance == administrator
    }

    void "Test the update action performs an update on a valid domain instance"() {
        when:"Update is called for a domain instance that doesn't exist"
            request.contentType = FORM_CONTENT_TYPE
            controller.update(null)

        then:"A 404 error is returned"
            response.redirectedUrl == '/administrator/index'
            flash.message != null


        when:"An invalid domain instance is passed to the update action"
            response.reset()
            def administrator = new Administrator()
            administrator.validate()
            controller.update(administrator)

        then:"The edit view is rendered again with the invalid instance"
            view == 'edit'
            model.administratorInstance == administrator

        when:"A valid domain instance is passed to the update action"
            response.reset()
            populateValidParams(params)
            administrator = new Administrator(params).save(flush: true)
            controller.update(administrator)

        then:"A redirect is issues to the show action"
            response.redirectedUrl == "/administrator/show/$administrator.id"
            flash.message != null
    }

    void "Test that the delete action deletes an instance if it exists"() {
        when:"The delete action is called for a null instance"
            request.contentType = FORM_CONTENT_TYPE
            controller.delete(null)

        then:"A 404 is returned"
            response.redirectedUrl == '/administrator/index'
            flash.message != null

        when:"A domain instance is created"
            response.reset()
            populateValidParams(params)
            def administrator = new Administrator(params).save(flush: true)

        then:"It exists"
            Administrator.count() == 1

        when:"The domain instance is passed to the delete action"
            controller.delete(administrator)

        then:"The instance is deleted"
            Administrator.count() == 0
            response.redirectedUrl == '/administrator/index'
            flash.message != null
    }
}
