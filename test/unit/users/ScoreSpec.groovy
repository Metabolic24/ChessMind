package users

import grails.test.mixin.TestFor
import spock.lang.Specification
import spock.lang.Unroll

/**
 * See the API for {@link grails.test.mixin.domain.DomainClassUnitTestMixin} for usage instructions
 */
@TestFor(Score)
class ScoreSpec extends Specification {

    Score score

    def setup() {
        score = new Score()
    }

    def cleanup() {
    }

    @Unroll
    void "Constraints test on valid score"() {

        given: "a valid score"
        score.score1 = 6.longValue()
        score.score2 = 5.longValue()

        when: "we trigger the validation of the score"
        def res = score.validate()

        then: "the score has no validation error"
        res
        !score.hasErrors()

        where:
        aScore1 | aScore2
        6l       | 6l
        5l       | 0l
        0l       | 5l
        0l       | 0l
        1000l    | 1000l
    }

    @Unroll
    void "Constraints test on invalid score (score1 : #aScore1, score2 : #aScore2)"() {

        given: "a valid score"
        score.score1 = aScore1
        score.score2 = aScore2


        when: "we trigger the validation of the score"
        def res = score.validate()

        then: "the score has no validation error"
        !res
        score.hasErrors()

        where:
        aScore1 | aScore2
        -1      | 5
        1       | -5
        -1      | -5
    }
}
