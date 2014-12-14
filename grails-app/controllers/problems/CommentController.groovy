package problems

import static org.springframework.http.HttpStatus.NO_CONTENT
import static org.springframework.http.HttpStatus.CREATED
import static org.springframework.http.HttpStatus.NOT_FOUND

import grails.plugin.springsecurity.annotation.Secured
import org.springframework.security.core.context.SecurityContextHolder
import grails.transaction.Transactional

@Transactional(readOnly = true)
@Secured(['ROLE_ADMIN', 'ROLE_USER', 'ROLE_MODERATOR'])
class CommentController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def create() {
        Comment commentInstance = new Comment(text:params.comment,user:users.User.findByUsername(SecurityContextHolder.getContext().getAuthentication().getName()),solution:Solution.findById(params.solutionId)).save(failOnError: true, flush:true)

        request.withFormat {
            form multipartForm {
                flash.message = "Commentaire ajouté"
                redirect uri:'/problem/show/'+commentInstance.getSolution().getProblem().getId()
            }
            '*' { respond commentInstance, [status: CREATED] }
        }
    }


    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond Comment.list(params), model:[commentInstanceCount: Comment.count()]
    }

    def show(Comment commentInstance) {
        respond commentInstance
    }

    def edit(Comment commentInstance) {
        respond commentInstance
    }

    @Transactional
    def update(Comment commentInstance) {
        if (commentInstance == null) {
            notFound()
            return
        }

        if (commentInstance.hasErrors()) {
            respond commentInstance.errors, view:'edit'
            return
        }

        def commentProblemId = commentInstance.solution.problem.id

        commentInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'Comment.label', default: 'Comment'), commentInstance.id])
                redirect action:'show', controller:'problem', id:commentProblemId

            }
            '*'{ respond commentInstance, [status: OK] }
        }
    }


    @Transactional
    def delete(Comment commentInstance) {

        if (commentInstance == null) {
            notFound()
            return
        }

        def commentProblem = commentInstance.getSolution().getProblem()

        commentInstance.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'Comment.label', default: 'Comment'), commentInstance.id])
                redirect uri:'/problem/show/'+commentProblem.getId()

            }
            '*'{ render status: NO_CONTENT }
        }
    }


    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'comment.label', default: 'Comment'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }

    def alertComment(Comment commentInstance) {
        redirect action: 'create', controller: 'alert', params: [commentId: commentInstance.id]
    }
}
