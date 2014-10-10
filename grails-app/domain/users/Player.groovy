package users

class Player {

    String name
    String nickname
    String description
    long score
    String mail

    static constraints = {
        mail email:true
    }
}
