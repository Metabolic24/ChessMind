package score

import users.User

class Score {

    long score1 // nombre de problèmes résolus
    long score2 // nombre de "j'aime" acquis

    static constraints = {
        score1 min: 0.longValue()
        score2 min: 0.longValue()
    }

    static belongsTo = [user:User]
}
