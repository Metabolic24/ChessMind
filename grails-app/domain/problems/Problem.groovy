package problems

import users.Player

class Problem {

    /*Attributes*/

    byte[] image

    String description
    String blackPlayer
    String whitePlayer
    String place
    String tournament

    Date date
    boolean solved //Pas de nullable: false car boolean est un type primitif (true|false)

    /*Attribute Constraints*/

    // TODO Uncomment constraints
    static constraints = {
        image nullable : false, blank : false, maxSize : 3145728 // 3 Mo
        description blank : true, nullable : true
        blackPlayer blank : true, nullable : true
        whitePlayer blank : true, nullable : true
        place blank : true, nullable : true
        tournament blank : true, nullable : true
        date nullable: true, date: true
    }

    /*GORM constraints*/

    static belongsTo = [player : Player]
}
