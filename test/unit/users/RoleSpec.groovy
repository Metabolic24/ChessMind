package users

import grails.test.mixin.TestMixin
import grails.test.mixin.support.GrailsUnitTestMixin
import spock.lang.Specification
import spock.lang.Unroll

/**
 * See the API for {@link grails.test.mixin.support.GrailsUnitTestMixin} for usage instructions
 */
@TestMixin(GrailsUnitTestMixin)
class RoleSpec extends Specification {

    Role role
    Role role2

    def setup() {
        role = new Role()
        role2 = new Role(authority:"test2")
        role2.save(failOnError: true, flush: true)
    }

    def cleanup() {
    }

    void "Constraints test on valid role (role : #anId)"() {

        given: "a valid user"

        role.id = anId
        role.authority = anAuthority

        when: "we trigger the validation of the problem"
        def res = role.validate()

        then: "the problem has no validation error"
        res
        !role.hasErrors()

        where:

        anId | anAuthority
        1    | "test"
    }

    @Unroll
    void "Constraints test on invalid role (role : #anId)"() {

        given: "a invalid user"

        role.id = anId
        role.authority = anAuthority

        when: "we trigger the validation of the problem"
        def res = role.validate()

        then: "the problem has no validation error"
        !res
        role.hasErrors()

        where:

        anId | anAuthority
        1    | ""
        2    | null
        3    | "test2"
    }
}