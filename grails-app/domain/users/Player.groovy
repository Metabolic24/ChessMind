package users

import score.Score

class Player extends SecUser{

    String name
    String description
    Score score
    String mail

    static constraints = {
        name blank: false, nullable: false, unique: true
        username nullable: false
        password nullable: false
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
