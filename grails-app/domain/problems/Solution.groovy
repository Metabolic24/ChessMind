package problems

import users.User

class Solution {

    User player;
    String answer;

    static belongsTo = [problem:Problem]

    static constraints = {
        answer matches: "[CTFDR]?[a-h][1-8](([\\-x][CTFDR]?[a-h][1-8]|\\+)?)|0\\-0(\\-0)?" //"([CTFDR]?[a-h][1-8](([\\-x][CTFDR]?[a-h][1-8]) | \\+)?)"// | (0\\-0(\\-0)?)"
    }
}
