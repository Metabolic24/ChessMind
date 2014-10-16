package users

class Player{

    String name
    String login
    String password
    String description
    Score score
    String mail

    static constraints = {
        name blank: false, nullable: false
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
