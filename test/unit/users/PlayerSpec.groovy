package users

import grails.test.mixin.TestFor
import score.Score
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
    void "Constraints test on valid player (login : #aLogin)"() {

        given:"a valid player"
            player.name = aName
            player.username = aLogin
            player.description = aDescription
            player.password = aPwd
            player.score = score
            player.mail = aMail

        when: "we trigger the validation of the player"
            def res = player.validate()

        then: "the player has no validation error"
            res
            !player.hasErrors()

        where:
            aName|aLogin|aPwd|aMail|aDescription
            "a"|"b"|"c"|"d@gmail.com"|"e"
            "Thomas"|"toto"|"pwd"|"thomas.toto@gmail.com"|null
            "Thomas"|"toto2"|"pwd"|"thomas.toto@gmail.com"|""
            "Thomas"|"toto3"|"pwd"|"thomas.toto@gmail.com"|"non-empty Description"
            null|"toto3"|"pwd"|"thomas.toto@gmail.com"|"non-empty Description"
    }

    @Unroll
    void "Constraints test on invalid player (login : #aLogin)"() {

        given:"an invalid player"
        player.name = aName
        player.username = aLogin
        player.password = aPwd
        player.description = aDescription
        player.score = score
        player.mail = aMail

        when: "we trigger the validation of the player"
        def res = player.validate()

        then: "the player has validation error"
        !res
        player.hasErrors()

        where:
        aName|aLogin|aPwd|aMail|aDescription
        "Thomas1"|null|"pwd"|"thomas.toto@gmail.com"|""
        "Thomas2"|""|"pwd"|"thomas.toto@gmail.com"|""
        "Thomas4"|"toto7"|""|"thomas.toto.gmail.com"|""
        "Thomas4"|"toto8"|null|"thomas.toto.gmail.com"|""
        "Thomas4"|"toto9"|"pwd"|"thomas.toto.gmail.com"|""
        "Thomas5"|"toto4"|"pwd"|null|""
        ""|"toto6"|"pwd"|null|""

    }
}
