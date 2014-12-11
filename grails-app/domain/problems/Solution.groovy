package problems

import users.User

class Solution {

    User user;
    String answer
    int aime = 0
    boolean isBestSolution = false

    static hasMany = [comments:Comment]
    static belongsTo = [problem:Problem]

    static constraints = {
        answer matches: "[CTFDR]?[a-h][1-8](([\\-x][CTFDR]?[a-h][1-8]|\\+)?)|0\\-0(\\-0)?", blank: false, nullable: false
        aime blank: true , nullable: true, min: 0
    }

    def sortedComments() {
        def result = comments.sort {a,b -> a.getId()<=>b.getId()}
        result
    }
}
