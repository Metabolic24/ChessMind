package users

class Player {

    String name
    String nickname
    String description
    Score score
    String mail

    static constraints = {
        name blank: false, nullable: false
        nickname blank: false, nullable: false
        description blank: true, nullable: true
        score nullable:false
        mail email: true, blank: false, nullable: false
    }
}
