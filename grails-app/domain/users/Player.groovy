package users

import problems.Problem
import score.Score

class Player{

    static hasMany = [problems : Problem]
    String name
    String login
    String password
    String description
    Score score
    String mail

    static constraints = {
        name blank: false, nullable: false, unique: true
        login blank: false, nullable: false
        password blank: false, nullable: false
        description blank: true, nullable: true
        score nullable: false
        mail email: true, blank: false, nullable: false
    }

    public boolean isAdministrator() {
        return false;
    }

    public boolean isModerator() {
        return false;
    }
}
