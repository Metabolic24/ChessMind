package score

import static org.springframework.http.HttpStatus.NO_CONTENT
import static org.springframework.http.HttpStatus.CREATED
import static org.springframework.http.HttpStatus.NOT_FOUND

import grails.plugin.springsecurity.annotation.Secured
import grails.transaction.Transactional

@Transactional(readOnly = true)
@Secured(['ROLE_ADMIN', 'ROLE_USER', 'ROLE_MODERATOR'])
class ScoreController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond Score.list(params), model:[scoreInstanceCount: Score.count()]
    }

    def show(Score scoreInstance) {
        respond scoreInstance
    }

    def create() {
        respond new Score(params)
    }

    @Transactional
    def save(Score scoreInstance) {
        if (scoreInstance == null) {
            notFound()
            return
        }

        if (scoreInstance.hasErrors()) {
            respond scoreInstance.errors, view:'create'
            return
        }

        scoreInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'score.label', default: 'Score'), scoreInstance.id])
                redirect scoreInstance
            }
            '*' { respond scoreInstance, [status: CREATED] }
        }
    }

    def edit(Score scoreInstance) {
        respond scoreInstance
    }

    @Transactional
    def update(Score scoreInstance) {
        if (scoreInstance == null) {
            notFound()
            return
        }

        if (scoreInstance.hasErrors()) {
            respond scoreInstance.errors, view:'edit'
            return
        }

        scoreInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'Score.label', default: 'Score'), scoreInstance.id])
                redirect scoreInstance
            }
            '*'{ respond scoreInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(Score scoreInstance) {

        if (scoreInstance == null) {
            notFound()
            return
        }

        scoreInstance.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'Score.label', default: 'Score'), scoreInstance.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'score.label', default: 'Score'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
