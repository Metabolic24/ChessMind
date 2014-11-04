package problems

import grails.plugin.springsecurity.annotation.Secured
import org.springframework.security.core.context.SecurityContextHolder
import org.springframework.web.context.request.RequestContextHolder

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class ProblemController {


    static allowedMethods = [save: "POST", update: "POST", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond Problem.list(params), model:[problemInstanceCount: Problem.count()]
    }

    def show(Problem problemInstance) {
        respond problemInstance
    }

    def create() {
        respond new Problem(params)
    }

    def my_problems(Problem problemInstance) {
        respond Problem.list(params).findAll { p -> p.player.username == SecurityContextHolder.getContext().getAuthentication().name }, model:[problemInstanceCount: Problem.count()]
    }

    def valid_problems(Integer max) {
        respond Problem.list(params).findAll { p -> p.isValide() }, model:[problemInstanceCount: Problem.count()]
    }

    def invalid_problems(Integer max) {
        respond Problem.list(params).findAll { p -> !p.isValide() }, model:[problemInstanceCount: Problem.count()]
    }

    def answer(Problem problemInstance) {
        redirect(uri:"/solution/create")
    }

    @Transactional
    def save(Problem problemInstance) {
        if (problemInstance == null) {
            notFound()
            return
        }

        if (problemInstance.hasErrors()) {
            respond problemInstance.errors, view:'create'
            return
        }

        problemInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'problem.label', default: 'Problem'), problemInstance.id])
                redirect problemInstance
            }
            '*' { respond problemInstance, [status: CREATED] }
        }
    }

    def edit(Problem problemInstance) {
        respond problemInstance
    }

    @Transactional
    def update(Problem problemInstance) {
        if (problemInstance == null) {
            notFound()
            return
        }

        if (problemInstance.hasErrors()) {
            respond problemInstance.errors, view:'edit'
            return
        }

        problemInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'Problem.label', default: 'Problem'), problemInstance.id])
                redirect problemInstance
            }
            '*'{ respond problemInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(Problem problemInstance) {

        if (problemInstance == null) {
            notFound()
            return
        }

        problemInstance.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'Problem.label', default: 'Problem'), problemInstance.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }
    def validate(Problem problemInstance) {
        problemInstance.setValide(true)
        problemInstance.save failOnError: true, flush: true
        redirect uri:"/problem/show/${problemInstance.id}",method:"PUT"
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'problem.label', default: 'Problem'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }

    def viewImage = {

        def problem = Problem.get( params.id )
        byte[] img = problem.image
        response.contentType = 'image/png' // or the appropriate image content type
        response.outputStream << img
        response.outputStream.flush()

    }
}
