package alert

import problems.Problem
import users.User

class Alert {

    User user
    String description

    static belongsTo = [problem : Problem]

    static constraints = {
        description blank : false, nullable : false
    }
}
