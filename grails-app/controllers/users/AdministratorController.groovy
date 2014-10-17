package users



import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class AdministratorController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond Administrator.list(params), model:[administratorInstanceCount: Administrator.count()]
    }

    def show(Administrator administratorInstance) {
        respond administratorInstance
    }

    def create() {
        respond new Administrator(params)
    }

    @Transactional
    def save(Administrator administratorInstance) {
        if (administratorInstance == null) {
            notFound()
            return
        }

        if (administratorInstance.hasErrors()) {
            respond administratorInstance.errors, view:'create'
            return
        }

        administratorInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'administrator.label', default: 'Administrator'), administratorInstance.id])
                redirect administratorInstance
            }
            '*' { respond administratorInstance, [status: CREATED] }
        }
    }

    def edit(Administrator administratorInstance) {
        respond administratorInstance
    }

    @Transactional
    def update(Administrator administratorInstance) {
        if (administratorInstance == null) {
            notFound()
            return
        }

        if (administratorInstance.hasErrors()) {
            respond administratorInstance.errors, view:'edit'
            return
        }

        administratorInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'Administrator.label', default: 'Administrator'), administratorInstance.id])
                redirect administratorInstance
            }
            '*'{ respond administratorInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(Administrator administratorInstance) {

        if (administratorInstance == null) {
            notFound()
            return
        }

        administratorInstance.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'Administrator.label', default: 'Administrator'), administratorInstance.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'administrator.label', default: 'Administrator'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
