package problems

import users.User

class Solution {

    User user;
    String answer
    int aime
    boolean isBestSolution = false

    static hasMany = [comments:Comment]
    static belongsTo = [problem:Problem]

    static constraints = {
        answer matches: "[CTFDR]?[a-h][1-8](([\\-x][CTFDR]?[a-h][1-8]|\\+)?)|0\\-0(\\-0)?"
        aime blank: true , nullable: true
    }

    def sortedComments() {
        def result = comments.sort {a,b -> a.id<=>b.id}
        result
    }
}
