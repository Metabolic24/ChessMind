package users

import grails.transaction.Transactional
import score.Score

@Transactional
class PlayerService {

    Player addNewScoreToNewPlayer(Player newPlayer) {
        def score = new Score(score1: 0l,score2:0l)
        score.save(failOnError: true)
        newPlayer.score = score
        return newPlayer
    }

    def serviceMethod() {

    }
}
