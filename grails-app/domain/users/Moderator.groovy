package users

class Moderator extends Player{

    static constraints = {
    }

    public boolean isAdministrator() {
        return false;
    }

    public boolean isModerator() {
        return true;
    }
}
