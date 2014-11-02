package problems

import users.User

class Comment {

    String text
    User user

    static belongsTo = [solution:Solution]

    static constraints = {
        text nullable:false, blank: false
    }
}
