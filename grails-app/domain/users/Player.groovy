package users

import problems.Problem
import score.Score

class Player extends SecUser{

    /*Attributes*/

    String name
    String description
    Score score
    String mail

    /*Attribute constraints*/

    static constraints = {
        name blank: false, nullable: true
        username nullable: false
        password nullable: false
        description blank: true, nullable: true
        score nullable: false
        mail email: true, blank: false, nullable: false
    }

    /*GORM constraints*/

    static hasMany = [problems : Problem]

    public boolean isAdministrator() {
        return false;
    }

    public boolean isModerator() {
        return false;
    }
}
