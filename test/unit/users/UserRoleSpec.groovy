package users

import grails.plugin.springsecurity.SpringSecurityService
import grails.test.mixin.Mock
import grails.test.mixin.TestMixin
import grails.test.mixin.support.GrailsUnitTestMixin
import score.Score
import spock.lang.Specification

/**
 * See the API for {@link grails.test.mixin.support.GrailsUnitTestMixin} for usage instructions
 */
@TestMixin(GrailsUnitTestMixin)
@Mock([User, Role])
class UserRoleSpec extends Specification {

    User user
    User user2
    Role role
    Role role2
    UserRole userRole

    SpringSecurityService springSecurityService = Mock(SpringSecurityService)


    def setup() {
        user = new User(firstName: "franck", lastName: "s", username: "fsil", email: "mail@mail.com", password: "password", score:Mock(Score))
        user.springSecurityService = springSecurityService
        springSecurityService.encodePassword(user.password) >> user.password
        user.save(failOnError: true, flush:true)

        user2 = new User(firstName: "franck", lastName: "s", username: "test", email: "mail@mail.com", password: "password", score:Mock(Score))
        user2.springSecurityService = springSecurityService
        springSecurityService.encodePassword(user2.password) >> user2.password
        user2.save(failOnError: true, flush:true)

        role = new Role(authority: 'ROLE_USER').save(failOnError: true, flush: true)
        role2 = new Role(authority: 'ROLE_BLABLA').save(failOnError: true, flush: true)

        UserRole.metaClass.static.exists = { l, j -> null }

        userRole = new UserRole(user: user, role: role).save(failOnError: true,flush: true)
    }

    def cleanup() {
    }

    void "Test method 'equals' with other type object"() {
        given: "a valid userRole"
        userRole
        when: "we apply equals to String object"
        def isEqual = userRole.equals("userRole")
        then: "it returns false"
        !isEqual
    }

    void "Test method 'equals' with same object"() {
        given: "a valid userRole"
        userRole
        when: "we apply equals to itSelf"
        def isEqual = userRole.equals(new UserRole(user: user, role: role))
        then: "it returns true"
        isEqual
    }

    void "Test method 'equals' with different objects"() {
        given: "a valid userRole"
        userRole
        when: "we apply equals to an UserRole with different role"
        def isEqual = userRole.equals(new UserRole(user: user, role: role2))
        then: "isEqual returns false"
        !isEqual

        when: "we apply equals to an UserRole with different role"
        isEqual = userRole.equals(new UserRole(user: user2, role: role))
        then: "isEqual returns false"
        !isEqual

        when: "we apply equals to an UserRole with different role"
        isEqual = userRole.equals(new UserRole(user: user2, role: role2))
        then: "isEqual returns false"
        !isEqual
    }

    void "Test method 'get' with right parameters"() {
        given: "a valid userRole"
        userRole
        when: "we apply get to its id"
        def res = UserRole.get(userRole.userId,userRole.roleId)
        then: "it returns true"
        res!=null
        res.equals(userRole)
    }

    void "Test method 'get' with bad parameters"() {
        given: "a valid userRole"
        userRole
        when: "we apply get to other id id"
        def res = UserRole.get(userRole.userId+1,userRole.roleId+1)
        then: "it returns false"
        res==null
        !res.equals(userRole)
    }

    void "Test method 'removeAll' with right user parameter" () {
        given: "a valid userRole"
        userRole
        and: "a number of UserRole objects"
        def nbUserRole = UserRole.count()
        when: "we apply 'removeAll' "
        UserRole.removeAll(userRole.user,true)
        then: "there's no more UserRole"
        UserRole.count()!=nbUserRole
        UserRole.count()==0
    }

    void "Test method 'removeAll' with bad user parameter" () {
        given: "a valid userRole"
        userRole
        and: "a number of UserRole objects"
        def nbUserRole = UserRole.count()
        when: "we apply 'removeAll' "
        UserRole.removeAll(user2,true)
        then: "there's no more UserRole"
        UserRole.count()==nbUserRole
    }

    void "Test method 'removeAll' with right role parameter" () {
        given: "a valid userRole"
        userRole
        and: "a number of UserRole objects"
        def nbUserRole = UserRole.count()
        when: "we apply 'removeAll' "
        UserRole.removeAll(userRole.role,true)
        then: "there's no more UserRole"
        UserRole.count()!=nbUserRole
        UserRole.count()==0
    }

    void "Test method 'removeAll' with bad role parameter" () {
        given: "a valid userRole"
        userRole
        and: "a number of UserRole objects"
        def nbUserRole = UserRole.count()
        when: "we apply 'removeAll' with role2"
        UserRole.removeAll(role2,true)
        then: "there's no more UserRole"
        UserRole.count()==nbUserRole
    }

    void "Test method 'removeAll' with null parameter" () {
        given: "a null role"
        Role nullRole = null
        and: "a null user"
        User nullUser = null
        and: "a number of UserRole objects"
        def nbUserRole = UserRole.count()
        when: "we apply 'removeAll' with null"
        UserRole.removeAll((User)nullUser,true)
        then: "there's no more UserRole"
        UserRole.count()==nbUserRole

        when: "we apply 'removeAll' with null"
        UserRole.removeAll((Role)nullRole,true)
        then: "there's no more UserRole"
        UserRole.count()==nbUserRole
    }

    void "Test role validator on null user"() {
        given: "a valid role"
        role
        when: "we create a new UserRole"
        def newUserRole = new UserRole(user:null,role:role)
        then: "the validation fails"
        !newUserRole.validate()
    }
}
