import users.Administrator
import users.Moderator
import users.Player
import users.Score

class BootStrap {

    def init = { servletContext ->
        def aScore = new Score(score1:0,score2:0)
        aScore.save(failOnError: true)
        new Player(name:"toto",login:"toto",password:"toto",score:aScore,mail:"m@hotmail.fr").save(failOnError: true)
        new Moderator(name:"toto2",login:"aaaa",password:"bbbbb",score:aScore,mail:"m@hotmail.fr").save(failOnError: true)
        new Administrator(name:"toto3",login:"cccc",password:"bbbbb",score:aScore,mail:"m@hotmail.fr").save(failOnError: true)
    }
    def destroy = {
    }
}
