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

    def setup() {
        player = new Player()
    }

    def cleanup() {
    }

    @Unroll
    void "Constraints test on valid player (name : #aName)"() {

        given:"a valid player"
            player.name = aName
            player.nickname = aNickName
            player.description = aDescription
            player.score = aScore
            player.mail = aMail

        when: "we trigger the validation of the player"
            def res = player.validate()

        then: "the player has no validation error"
            res==true
            !player.hasErrors()

        where:
            aName|aNickName|aScore|aMail|aDescription
            "Thomas"|"toto"|new Score(score1 : 0, score2 : 0)|"thomas.toto@gmail.com"|null
            "Thomas"|"toto"|new Score(score1 : 0, score2 : 0)|"thomas.toto@gmail.com"|""
            "Thomas"|"toto"|new Score(score1 : 0, score2 : 0)|"thomas.toto@gmail.com"|"non-empty Description"
    }

    @Unroll
    void "Constraints test on invalid player (name : #aName)"() {

        given:"an invalid player"
        player.name = aName
        player.nickname = aNickName
        player.description = aDescription
        player.score = aScore
        player.mail = aMail

        when: "we trigger the validation of the player"
        def res = player.validate()

        then: "the player has validation error"
        res==false
        player.hasErrors()

        where:
        aName|aNickName|aScore|aMail|aDescription
        "Thomas"|null|new Score(score1 : 0, score2 : 0)|"thomas.toto@gmail.com"|""
        "Thomas"|""|new Score(score1 : 0, score2 : 0)|"thomas.toto@gmail.com"|""
        "Thomas"|"toto"|new Score(score1 : 0, score2 : 0)|"thomas.toto@gmail.com"|""
        "Thomas"|"toto"|new Score(score1 : 0, score2 : 0)|"thomas.toto.gmail.com"|""
        "Thomas"|"toto"|new Score(score1 : 0, score2 : 0)|null|""
        null|"toto"|new Score(score1 : 0, score2 : 0)|null|""
        ""|"toto"|new Score(score1 : 0, score2 : 0)|null|""
    }
}
