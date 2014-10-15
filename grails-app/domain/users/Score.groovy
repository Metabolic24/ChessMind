package users

class Score {

    long score1
    long score2

    static constraints = {
        score1 min: 0.longValue()
        score2 min: 0.longValue()
    }
}
