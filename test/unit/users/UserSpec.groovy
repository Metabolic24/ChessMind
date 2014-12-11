package users

import grails.plugin.springsecurity.SpringSecurityService
import grails.test.mixin.Mock
import grails.test.mixin.TestFor
import score.Score
import spock.lang.Specification
import spock.lang.Unroll

@TestFor(User)
@Mock([Role,UserRole])
class UserSpec extends Specification {

    User user
    User user1
    SpringSecurityService springSecurityService

    def setup() {
        user = new User()

        springSecurityService = Mock(SpringSecurityService)
        springSecurityService.encodePassword(user.password) >> user.password?.substring(0,3)

        user1 = new User(username: "userTest", password: "userTest", email: "a@a.fr", score: Mock(Score))
        user1.springSecurityService = springSecurityService
        user1.save(failOnError: true, flush: true)
    }

    @Unroll
    void "Constraints test on valid user (id : #anId)"() {

        given: "a valid user"

        user.id = anId
        user.username = anUsername
        user.password = aPassword
        user.email = anEmail

        user.name = aName
        user.description = aDescription

        user.accountExpired = false
        user.accountLocked = false
        user.passwordExpired = false
        user.enabled = true

        user.score = Mock(Score)

        when: "we trigger the validation of the problem"
        def res = user.validate()

        then: "the problem has no validation error"
        res
        !user.hasErrors()

        where:

        anId | anUsername      | aPassword | anEmail  | aName      | aDescription
        1    | "test username" | "pwd"     | "a@a.fr" | "test nom" | "test description"
        2    | "test username" | "pwd"     | "a@a.fr" | null       | "test description"
        3    | "test username" | "pwd"     | "a@a.fr" | "test nom" | null
        4    | "test username" | "pwd"     | "a@a.fr" | "test nom" | ""
    }

    @Unroll
    void "Constraints test on invalid problem (id : #anId)"() {

        user.id = anId
        user.username = anUsername
        user.password = aPassword
        user.email = anEmail

        user.name = aName
        user.description = aDescription

        user.accountExpired = false
        user.accountLocked = false
        user.passwordExpired = false
        user.enabled = true

        user.score = Mock(Score)

        when: "we trigger the validation of the problem"
        def res = user.validate()

        then: "the problem has validation error"
        !res
        user.hasErrors()

        where:

        anId | anUsername      | aPassword | anEmail        | aName      | aDescription
        1    | ""              | "pwd"     | "a@a.fr"       | "test nom" | "test description"
        2    | null            | "pwd"     | "a@a.fr"       | "test nom" | "test description"
        3    | "userTest"      | "pwd"     | "a@a.fr"       | "test nom" | "test description"
        4    | "test username" | ""        | "a@a.fr"       | "test nom" | "test description"
        5    | "test username" | null      | "a@a.fr"       | "test nom" | "test description"
        6    | "test username" | "pwd"     | ""             | "test nom" | "test description"
        7    | "test username" | "pwd"     | null           | "test nom" | "test description"
        8    | "test username" | "pwd"     | "not an email" | "test nom" | "test description"
        9    | "test username" | "pwd"     | "a@a.fr"       | ""         | "test description"
    }

    void "Test beforeUpdate method"() {
        given: "A valid User"
        user1
        User.metaClass.static.encodePassword = {user1.setPassword(password?.substring(0,3))}

        when: "We change the password and call beforeUpdate"
        def password = "passwrd"
        user1.setPassword(password)
        user1.beforeUpdate()
        user1.save(failOnError: true, flush: true)

        then: "The password is now encoded"
        !user1.getPassword().equals(password)

        when: "We don't change the password and call beforeUpdate"
        password = user1.getPassword()
        user1.beforeUpdate()
        user1.save(failOnError: true, flush: true)

        then: "The password didn't change"
        user1.getPassword().equals(password)
    }

    void "Test static method filterByAuthority"() {
        given: "a valid user"
            user1
        and: "a valid role"
            def role = new Role(authority:'ROLE_USER').save(failOnError:true, flush:true)

        when: "we use filterByAuthority on invalid authority role"
        Set<Role> authorities = new ArrayList<>()
        User.metaClass.static.getAuthorities = {authorities}
        def result = User.filterByAuthority(role.getAuthority(),null)

        then: "the result is not null but size is 0"
        result!=null
        result.size()==0

        when: "we use filterByAuthority on valid authority role"
            authorities = new ArrayList<>()
            authorities.add(role)
            User.metaClass.static.getAuthorities = {authorities}
            result = User.filterByAuthority(role.getAuthority(),null)

        then: "the result is not null"
            result!=null
            result.size()==1
            result.get(0).getUsername().equals(user1.getUsername())
    }

    void "Test getAuthorities"(){
        given: "a valid user"
            user1
        and: "a valid role"
            def role = new Role(authority:'ROLE_USER').save(failOnError:true, flush:true)
        and: "a valid userRole"
            new UserRole(user:user1, role:role).save(failOnError: true, flush:true)

        when: "we call getAuthorities"
            def result = user1.getAuthorities()
        then: "the result is not empty and the role is well included"
            result!=null
            !result.isEmpty()
            result[0].authority.equals(role.getAuthority())
    }
}
