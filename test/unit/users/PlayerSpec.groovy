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
            def res = option.validate()

        then: "the player has no validation error"
            res==true
            !player.hasErrors()

        where:
            aName|aNickName|aScore|aMail|aDescription
            "Thomas"|"toto"|0|"thomas.toto@gmail.com"|null
            "Thomas"|"toto"|0|"thomas.toto@gmail.com"|""
            "Thomas"|"toto"|0|"thomas.toto@gmail.com"|"non-empty Description"
    }

    /*"Thomas"|null|0|"thomas.toto@gmail.com"
    "Thomas"|""|0|"thomas.toto@gmail.com"
    "Thomas"|"toto"|-1|"thomas.toto@gmail.com"
    "Thomas"|"toto"|0|"thomas.toto.gmail.com"
    "Thomas"|"toto"|0|null*/
}
