package problems



import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class SolutionController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond Solution.list(params), model:[solutionInstanceCount: Solution.count()]
    }

    def show(Solution solutionInstance) {
        respond solutionInstance
    }

    def create() {
        respond new Solution(params)
    }

    @Transactional
    def save(Solution solutionInstance) {
        if (solutionInstance == null) {
            notFound()
            return
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

    def edit(Solution solutionInstance) {
        respond solutionInstance
    }

    @Transactional
    def update(Solution solutionInstance) {
        if (solutionInstance == null) {
            notFound()
            return
        }

        if (solutionInstance.hasErrors()) {
            respond solutionInstance.errors, view:'edit'
            return
        }

        solutionInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'Solution.label', default: 'Solution'), solutionInstance.id])
                redirect solutionInstance
            }
            '*'{ respond solutionInstance, [status: OK] }
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
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
