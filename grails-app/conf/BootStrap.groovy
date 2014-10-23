import users.Administrator
import users.Moderator
import users.Player
import score.Score

class BootStrap {

    def init = { servletContext ->
        new Player(name:"toto",login:"toto",password:"toto",score:new Score(score1:0l,score2:0l),mail:"m@hotmail.fr").save(failOnError: true)
        new Moderator(name:"toto2",login:"aaaa",password:"bbbbb",score:new Score(score1:0l,score2:0l),mail:"m@hotmail.fr").save(failOnError: true)
        new Administrator(name:"toto3",login:"cccc",password:"bbbbb",score:new Score(score1:0l,score2:0l),mail:"m@hotmail.fr").save(failOnError: true)
    }
    def destroy = {
    }
}
