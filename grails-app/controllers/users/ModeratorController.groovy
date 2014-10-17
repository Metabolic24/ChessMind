package users



import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class ModeratorController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond Moderator.list(params), model:[moderatorInstanceCount: Moderator.count()]
    }

    def show(Moderator moderatorInstance) {
        respond moderatorInstance
    }

    def create() {
        respond new Moderator(params)
    }

    @Transactional
    def save(Moderator moderatorInstance) {
        if (moderatorInstance == null) {
            notFound()
            return
        }

        if (moderatorInstance.hasErrors()) {
            respond moderatorInstance.errors, view:'create'
            return
        }

        moderatorInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'moderator.label', default: 'Moderator'), moderatorInstance.id])
                redirect moderatorInstance
            }
            '*' { respond moderatorInstance, [status: CREATED] }
        }
    }

    def edit(Moderator moderatorInstance) {
        respond moderatorInstance
    }

    @Transactional
    def update(Moderator moderatorInstance) {
        if (moderatorInstance == null) {
            notFound()
            return
        }

        if (moderatorInstance.hasErrors()) {
            respond moderatorInstance.errors, view:'edit'
            return
        }

        moderatorInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'Moderator.label', default: 'Moderator'), moderatorInstance.id])
                redirect moderatorInstance
            }
            '*'{ respond moderatorInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(Moderator moderatorInstance) {

        if (moderatorInstance == null) {
            notFound()
            return
        }

        moderatorInstance.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'Moderator.label', default: 'Moderator'), moderatorInstance.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'moderator.label', default: 'Moderator'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
