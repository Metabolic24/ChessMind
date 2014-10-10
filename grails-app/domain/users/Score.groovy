package users

class Score {

    long score1
    long score2

    static hasOne = [player:Player]

    static constraints = {
        score1 min: 0l
        score2 min: 0l
    }
}
