package users

import groovy.transform.InheritConstructors

@InheritConstructors
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
