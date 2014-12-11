package users

import grails.test.mixin.Mock
import grails.test.mixin.TestFor
import grails.test.mixin.TestMixin
import grails.test.mixin.support.GrailsUnitTestMixin
import spock.lang.Specification

/**
 * See the API for {@link grails.test.mixin.support.GrailsUnitTestMixin} for usage instructions
 */
@TestMixin(GrailsUnitTestMixin)
@TestFor(UserController)
@Mock([User,Role])
class UserControllerSpec extends Specification {

    void "Test the administrators method"() {
        when: "The index action is executed"
        controller.administrators()

        then: "The model is correct"
        !model.userInstanceList
        model.adminInstanceCount == 0
    }

    void "Test the moderators method"() {

        when: "The index action is executed"
        controller.moderators()

        then: "The model is correct"
        !model.userInstanceList
        model.moderatorInstanceCount == 0
    }
}
