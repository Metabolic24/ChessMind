package problems

import grails.test.mixin.TestFor
import spock.lang.Specification
import spock.lang.Unroll

/**
 * See the API for {@link grails.test.mixin.domain.DomainClassUnitTestMixin} for usage instructions
 */
@TestFor(Problem)
class ProblemSpec extends Specification {

    Problem problem

    def setup() {
        problem = new Problem()
    }

    def cleanup() {
    }

    @Unroll
    void "Constraints test on valid problem (id : #anId)"() {

        given: "a valid problem"
        problem.id = anId
        problem.image = anImage
        problem.description = aDescription
        problem.blackPlayer = aBlackPlayer
        problem.whitePlayer = aWhitePlayer
        problem.date = aDate
        problem.place = aPlace
        problem.tournament = aTournament
        problem.solved = isSolved

        when: "we trigger the validation of the problem"
        def res = problem.validate()

        then: "the problem has no validation error"
        res
        !problem.hasErrors()

        where:
        anId | anImage | aDescription    | aBlackPlayer     | aWhitePlayer     | aDate      | aPlace    | aTournament    | isSolved
        1    | [0, 1]  | "A description" | "A black player" | "A white player" | new Date() | "A place" | "A tournament" | false
        2    | [0, 1]  | ""              | "A black player" | "A white player" | new Date() | "A place" | "A tournament" | false
        3    | [0, 1]  | "A description" | ""               | "A white player" | new Date() | "A place" | "A tournament" | false
        4    | [0, 1]  | "A description" | "A black player" | ""               | new Date() | "A place" | "A tournament" | false
        //[0, 1]  | "A description" | "A black player" | "A white player" | null       | "A place" | "A tournament" | false
        5    | [0, 1] | "A description" | "A black player" | "A white player" | new Date() | "" | "A tournament" | false
        6    | [0, 1] | "A description" | "A black player" | "A white player" | new Date() | "A place" | "" | false
        7    | [0, 1] | "A description" | "A black player" | "A white player" | new Date() | "A place" | "A tournament" | true
        8    | [0, 1] | null | "A black player" | "A white player" | new Date() | "A place" | "A tournament" | false
        9    | [0, 1] | "A description" | null | "A white player" | new Date() | "A place" | "A tournament" | false
        10   | [0, 1] | "A description" | "A black player" | null | new Date() | "A place" | "A tournament" | false
        //11   | [0, 1] | "A description" | "A black player" | "A white player" | null | "A place" | "A tournament" | false
        12   | [0, 1] | "A description" | "A black player" | "A white player" | new Date() | null | "A tournament" | false
        13   | [0, 1] | "A description" | "A black player" | "A white player" | new Date() | "A place" | null | false

    }

    @Unroll
    void "Constraints test on invalid problem (id : #anId)"() {

        given: "an invalid problem"
        problem.id = anId
        problem.image = anImage
        problem.description = aDescription
        problem.blackPlayer = aBlackPlayer
        problem.whitePlayer = aWhitePlayer
        problem.date = aDate
        problem.place = aPlace
        problem.tournament = aTournament
        problem.solved = isSolved

        when: "we trigger the validation of the problem"
        def res = problem.validate()

        then: "the problem has no validation error"
        !res
        problem.hasErrors()

        // TODO : Faire marcher le fait d'être obligé de mettre une image
        where:
        anId | anImage           | aDescription    | aBlackPlayer | aWhitePlayer     | aDate      | aPlace    | aTournament    | isSolved
        1    | null              | "A description" | ""           | "A white player" | new Date() | "A place" | "A tournament" | false
        2    | new byte[3145729] | "A description" | ""           | "A white player" | new Date() | "A place" | "A tournament" | false
        //14   | [0, 1] | "A description" | "A black player" | "A white player" | new Date() | "A place" | "A tournament" | null
    }
}
