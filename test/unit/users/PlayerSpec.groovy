package users

import grails.test.mixin.TestFor
import spock.lang.Specification
import spock.lang.Unroll

/**
 * See the API for {@link grails.test.mixin.domain.DomainClassUnitTestMixin} for usage instructions
 */
@TestFor(Player)
class PlayerSpec extends Specification {

    Player player
    Score score

    def setup() {
        player = new Player()
        score =  Mock(Score)
    }

    def cleanup() {
    }

    @Unroll
    void "Constraints test on valid player (name : #aName, login : #aLogin)"() {

        given:"a valid player"
            player.name = aName
            player.login = aLogin
            player.description = aDescription
            player.score = score
            player.mail = aMail

        when: "we trigger the validation of the player"
            def res = player.validate()

        then: "the player has no validation error"
            res
            !player.hasErrors()

        where:
            aName|aLogin|aMail|aDescription
            "Thomas"|"toto"|"thomas.toto@gmail.com"|null
            "Thomas"|"toto"|"thomas.toto@gmail.com"|""
            "Thomas"|"toto"|"thomas.toto@gmail.com"|"non-empty Description"
    }

    @Unroll
    void "Constraints test on invalid player (name : #aName)"() {

        given:"an invalid player"
        player.name = aName
        player.login = aLogin
        player.description = aDescription
        player.score = score
        player.mail = aMail

        when: "we trigger the validation of the player"
        def res = player.validate()

        then: "the player has validation error"
        !res
        player.hasErrors()

        where:
        aName|aLogin|aMail|aDescription
        "Thomas1"|null|"thomas.toto@gmail.com"|""
        "Thomas2"|""|"thomas.toto@gmail.com"|""
        "Thomas4"|"toto"|"thomas.toto.gmail.com"|""
        "Thomas5"|"toto"|null|""
        null|"toto1"|null|""
        ""|"toto2"|null|""
    }
}
