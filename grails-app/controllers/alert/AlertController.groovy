package alert

import static org.springframework.http.HttpStatus.NO_CONTENT
import static org.springframework.http.HttpStatus.CREATED
import static org.springframework.http.HttpStatus.NOT_FOUND

import grails.plugin.springsecurity.annotation.Secured
import org.springframework.security.core.context.SecurityContextHolder
import grails.transaction.Transactional

@Transactional(readOnly = true)
@Secured(['ROLE_ADMIN', 'ROLE_MODERATOR'])
class AlertController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond Alert.list(params), model:[alertInstanceCount: Alert.count()]
    }

    @Secured(['ROLE_USER'])
    def create() {
        respond new Alert(params)
    }

    @Transactional
    @Secured(['ROLE_USER'])
    def save(Alert alertInstance) {

        if (alertInstance == null) {
            flash.error = "Action non autorisée..."
            redirect uri:"/problem/index"
            return
        }

        if(params.problemId != null) {
            alertInstance.setProblem(problems.Problem.findById(params.problemId))
            alertInstance.comment = null
        }
        else if(params.commentId != null) {
            def comment = problems.Comment.findById(params.commentId)
            alertInstance.setComment(comment)
            alertInstance.setProblem(comment.getSolution().getProblem())
        }
        else {
            flash.error = "Action non autorisée"
            redirect uri:"/problem/index"
            return
        }

        alertInstance.setDescription(params.description)
        alertInstance.setUser(users.User.findByUsername(SecurityContextHolder.getContext().getAuthentication().getName()))

        alertInstance.validate()

        if (alertInstance.hasErrors()) {
            println "test"
            respond alertInstance.errors, view:'create'
            return
        }

        alertInstance.save failOnError: true, flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'alert.label', default: 'Alert'), alertInstance.id])
                redirect uri:"/problem/show/" + alertInstance.getProblemId()
            }
            '*' { respond alertInstance, [status: CREATED] }
        }
    }

    @Transactional
    def delete(Alert alertInstance) {

        if (alertInstance == null) {
            notFound()
            return
        }

        alertInstance.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'Alert.label', default: 'Alert'), alertInstance.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'alert.label', default: 'Alert'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
