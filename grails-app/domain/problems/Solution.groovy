package problems

import users.User

class Solution {

    User user;
    String answer
    int aime

    static hasMany = [comments:Comment]
    static belongsTo = [problem:Problem]

    static constraints = {
        answer matches: "[CTFDR]?[a-h][1-8](([\\-x][CTFDR]?[a-h][1-8]|\\+)?)|0\\-0(\\-0)?" //"([CTFDR]?[a-h][1-8](([\\-x][CTFDR]?[a-h][1-8]) | \\+)?)"// | (0\\-0(\\-0)?)"
        aime blank: true , nullable: true
    }
}
