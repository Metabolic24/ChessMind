package problems


import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class CommentController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def create() {
        Comment commentInstance = new Comment(text:params.comment,user:users.User.findByUsername("admin"),solution:Solution.findById(params.solutionId)).save(failOnError: true, flush:true)

        request.withFormat {
            form multipartForm {
                flash.message = "Commentaire ajouté"
                redirect commentInstance.solution.problem
            }
            '*' { respond commentInstance, [status: CREATED] }
        }
    }
}
