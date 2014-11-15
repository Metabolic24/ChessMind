package alert

import problems.Problem
import users.User
import problems.Comment

class Alert {

    User user
    String description
    Comment comment

    static belongsTo = [problem : Problem]

    static constraints = {
        description blank : false, nullable : false
        comment blank : true, nullable : true
    }
}
