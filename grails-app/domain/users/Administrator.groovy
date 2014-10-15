package users

class Administrator extends Player{

    static constraints = {
    }

    public boolean isAdministrator() {
        return true;
    }

    public boolean isModerator() {
        return false;
    }
}
