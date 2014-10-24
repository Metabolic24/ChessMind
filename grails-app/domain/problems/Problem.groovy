package problems

class Problem {
    byte[] image
    String description
    String blackPlayer
    String whitePlayer
    Date date
    String place
    String tournament
    boolean solved

    static constraints = {
        // TODO add constraints
        // solved nullable : false, blank : false
        // date nullable : false
        description blank : true, nullable : true
        blackPlayer blank : true, nullable : true
        whitePlayer blank : true, nullable : true
        date blank: true, date: true
        place blank : true, nullable : true
        tournament blank : true, nullable : true
        image nullable : false, blank : false, maxSize : 3145728 // 3 Mo
    }
}
