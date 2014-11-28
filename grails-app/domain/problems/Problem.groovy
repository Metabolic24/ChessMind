package problems

import alert.Alert
import users.User


class Problem {

    /*Attributes*/

    byte[] image

    String description
    String blackPlayer
    String whitePlayer
    String place
    String tournament
    Solution bestSolution = null

    Date date
    boolean valide

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
        bestSolution nullable : true
    }

    /*GORM constraints*/

    static hasMany = [solutions : Solution, alerts : Alert]

    static belongsTo = [player : User]

    def sortedSolutions() {
        def result = solutions.sort {a,b ->
            if(a.aime == b.aime) b.comments.size() <=> a.comments.size()
            else a.aime <=> b.aime}
        result
    }
}
