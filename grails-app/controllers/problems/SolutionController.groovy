package problems

import grails.plugin.springsecurity.annotation.Secured
import org.springframework.security.core.context.SecurityContextHolder
import users.User

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
@Secured(['ROLE_ADMIN', 'ROLE_USER', 'ROLE_MODERATOR'])
class SolutionController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def create() {
        if(params.problemId != null) {
            respond new Solution(params)
        } else {
            flash.error = "Action non autorisée..."
            redirect uri:"/problem/index"
        }
    }

    @Transactional
    def save(Solution solutionInstance) {
        if (solutionInstance == null) {
            notFound()
            return
        }

        if(solutionInstance.user == null) {
            solutionInstance.user = User.findByUsername(SecurityContextHolder.getContext().getAuthentication().getName())
        }

        if(solutionInstance.problem == null && params.problemId != null) {
            solutionInstance.problem = Problem.findById(params.problemId)
        }

        solutionInstance.validate()

        def solutions = Solution.findAllByProblem(solutionInstance.problem)

        if(!solutions.isEmpty()) {
            if (solutions.find { a -> a.answer.equals(solutionInstance.answer) } !=null) {
                flash.message = "This solution has already been proposed for this problem..."
                respond solutionInstance, view: 'create'
                return
            }
        }

        if (solutionInstance.hasErrors()) {
            respond solutionInstance.errors, view:'create'
            return
        }

        solutionInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'solution.label', default: 'Solution'), solutionInstance.id])
                redirect solutionInstance
            }
            '*' { respond solutionInstance, [status: CREATED] }
        }
    }

    @Transactional
    def delete(Solution solutionInstance) {

        if (solutionInstance == null) {
            notFound()
            return
        }

        solutionInstance.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'Solution.label', default: 'Solution'), solutionInstance.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'solution.label', default: 'Solution'), params.id])
                redirect uri:"/problem/index"
            }
            '*'{render status: NOT_FOUND }
        }
    }
}
