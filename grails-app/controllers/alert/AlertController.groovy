package alert

import grails.plugin.springsecurity.annotation.Secured
import org.springframework.security.core.context.SecurityContextHolder
import problems.Problem
import problems.Solution
import problems.Comment

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
@Secured(['ROLE_ADMIN', 'ROLE_MODERATOR'])
class AlertController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    // TODO : Ne pas passer par une variable globale entre le create et le save serait cool !
    def problemId
    def commentId

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond Alert.list(params), model:[alertInstanceCount: Alert.count()]
    }

    def custom_index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond Alert.list(params), model:[alertInstanceCount: Alert.count()]
    }

    def show(Alert alertInstance) {
        respond alertInstance
    }

    def create() {
        if (params['commentId'] != null){
            commentId = params['commentId']
            problemId = problems.Comment.findById(commentId).solution.problem.id
        } else {
            problemId = params['problemId']
        }
        respond new Alert(params)
    }

    @Transactional
    def save(Alert alertInstance) {

        if (alertInstance == null) {
            notFound()
            return
        }

        alertInstance.setDescription(params.description)
        alertInstance.setProblem(problems.Problem.findById(problemId))
        alertInstance.setUser(users.User.findByUsername(SecurityContextHolder.getContext().getAuthentication().getName()))
        if (commentId != null) {
            alertInstance.setComment(problems.Comment.findById(commentId))
        }

        // On remet les valeurs à null pour la prochaine alerte
        problemId = null;
        commentId = null;

        alertInstance.validate()

        if (alertInstance.hasErrors()) {
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

    def edit(Alert alertInstance) {
        respond alertInstance
    }

    @Transactional
    def update(Alert alertInstance) {
        if (alertInstance == null) {
            notFound()
            return
        }

        if (alertInstance.hasErrors()) {
            respond alertInstance.errors, view:'edit'
            return
        }

        alertInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'Alert.label', default: 'Alert'), alertInstance.id])
                redirect alertInstance
            }
            '*'{ respond alertInstance, [status: OK] }
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
                redirect action:"custom_index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'alert.label', default: 'Alert'), params.id])
                redirect action: "custom_index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
