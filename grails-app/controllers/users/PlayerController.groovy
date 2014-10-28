package users

import grails.plugin.springsecurity.annotation.Secured
import score.Score

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class PlayerController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    @Secured(['ROLE_ADMIN'])
    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond Player.list(params), model:[playerInstanceCount: Player.count()]
    }

    def administrators(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond Administrator.list(params), model:[administratorInstanceCount: Administrator.count()]
    }

    def moderators(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond Moderator.list(params), model:[moderatorInstanceCount: Moderator.count()]
    }

    def players(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond Player.list(params), model:[playerInstanceCount: Player.count()]
    }

    def show(Player playerInstance) {
        if(playerInstance?.isModerator()) {
            redirect(uri: "/moderator/show/${playerInstance.getId()}")
        } else if(playerInstance?.isAdministrator()){
            redirect(uri: "/administrator/show/${playerInstance.getId()}")
        } else {
            respond playerInstance
        }

    }

    def create() {
        respond new Player(params)
    }

    def signin() {
        respond new Player(params)
    }

    def signinsave(Player playerInstance){

        if (playerInstance == null) {
            notFound()
            return
        }

        if (!params["confirmPassword"].equals(playerInstance.getPassword())) {
            request.withFormat {
                form multipartForm {
                    flash.error = "Password fields don't match. Enter the same password in both..."
                    redirect action:'signin', params:
                            [mail:playerInstance.mail,
                             username: playerInstance.username]
                }
            }
        }
        else {
            redirect(uri: "/player/index")
            /*playerInstance.score = new Score(score1:0l,score2:0l)
            playerInstance.validate()

            if (playerInstance.hasErrors()){
                respond playerInstance.errors, view:'signin'
                return
            }

            playerInstance.save flush:true

            request.withFormat {
                form multipartForm {
                    flash.message = message(code: 'default.created.message', args: [message(code: 'player.label', default: 'Player'), playerInstance.id])
                    redirect playerInstance
                }
                '*' { respond playerInstance, [status: CREATED] }
            }*/
        }
    }

    @Transactional
    def save(Player playerInstance) {
        if (playerInstance == null) {
            notFound()
            return
        }

        if(playerInstance.score==null) {
            print("NULL")
            playerInstance.score = new Score(score1:0l,score2:0l)
            playerInstance.validate()
        }

        if (playerInstance.hasErrors()){
            respond playerInstance.errors, view:'create'
            return
        }

        // Création du modérateur si l'option moderator est cochée
        if (params["moderator"]!=null) {
            playerInstance = new Moderator(name:playerInstance.name, username:playerInstance.username,password:playerInstance.password,score:playerInstance.score,mail:playerInstance.mail).save(failOnError: true)
        }

        playerInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'player.label', default: 'Player'), playerInstance.id])
                redirect playerInstance
            }
            '*' { respond playerInstance, [status: CREATED] }
        }
    }

    def edit(Player playerInstance) {
        respond playerInstance
    }

    @Transactional
    def update(Player playerInstance) {
        if (playerInstance == null) {
            notFound()
            return
        }

        if (playerInstance.hasErrors()) {
            respond playerInstance.errors, view:'edit'
            return
        }

        playerInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'Player.label', default: 'Player'), playerInstance.id])
                redirect playerInstance
            }
            '*'{ respond playerInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(Player playerInstance) {

        if (playerInstance == null) {
            notFound()
            return
        }

        playerInstance.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'Player.label', default: 'Player'), playerInstance.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'player.label', default: 'Player'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
