package problems

import static org.springframework.http.HttpStatus.NO_CONTENT
import static org.springframework.http.HttpStatus.CREATED
import static org.springframework.http.HttpStatus.NOT_FOUND

import grails.transaction.Transactional
import grails.plugin.springsecurity.annotation.Secured
import org.springframework.security.core.context.SecurityContextHolder
import java.awt.Graphics2D
import java.awt.RenderingHints
import java.awt.image.BufferedImage
import javax.imageio.ImageIO
import users.Role
import users.User


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

    @Secured(['ROLE_ADMIN', 'ROLE_USER', 'ROLE_MODERATOR'])
    def create() {
        respond new Problem(params)
    }

    @Secured(['ROLE_ADMIN', 'ROLE_USER', 'ROLE_MODERATOR'])
    def my_problems() {
        respond Problem.list(params).findAll { p -> p.player.username == SecurityContextHolder.getContext().getAuthentication().name }, model:[problemInstanceCount: Problem.count()]
    }

    def valid_problems() {
        respond Problem.list(params).findAll { p -> p.isValide() }, model:[problemInstanceCount: Problem.count()]
    }

    @Secured(['ROLE_ADMIN', 'ROLE_MODERATOR'])
    def problems_to_validate() {
        respond Problem.list(params).findAll { p -> !p.isValide() }, model:[problemInstanceCount: Problem.count()]
    }

    @Secured(['ROLE_ADMIN', 'ROLE_USER', 'ROLE_MODERATOR'])
    def answer(Problem problemInstance) {
        redirect(controller: "solution", action:"create", params: [problemId:problemInstance.id] )
    }

    @Transactional
    @Secured(['ROLE_ADMIN', 'ROLE_USER', 'ROLE_MODERATOR'])
    def save(Problem problemInstance) {
        if (problemInstance == null) {
            notFound()
            return
        }

        if(problemInstance.player == null) {
            problemInstance.player = User.findByUsername(SecurityContextHolder.getContext().getAuthentication().getName())
            problemInstance.validate()
        }

        if (problemInstance.hasErrors()) {
            respond problemInstance.errors, view:'create'
            return
        }

        if (problemInstance?.player?.getAuthorities()?.contains(Role.findByAuthority('ROLE_ADMIN'))
                || problemInstance?.player?.getAuthorities()?.contains(Role.findByAuthority('ROLE_MODERATOR'))){
            problemInstance.setValide(true)
        }

        problemInstance.save failOnError: true, flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'problem.label', default: 'Problem'), problemInstance.id])
                redirect problemInstance
            }
            '*' { respond problemInstance, [status: CREATED] }
        }
    }

    @Secured(['ROLE_ADMIN', 'ROLE_USER', 'ROLE_MODERATOR'])
    def edit(Problem problemInstance) {
        respond problemInstance
    }

    @Transactional
    @Secured(['ROLE_ADMIN', 'ROLE_USER', 'ROLE_MODERATOR'])
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

    @Secured(['ROLE_ADMIN', 'ROLE_USER', 'ROLE_MODERATOR'])
    @Transactional
    def delete(Problem problemInstance) {

        if (problemInstance == null) {
            println("test")
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

    @Secured(['ROLE_ADMIN', 'ROLE_MODERATOR'])
    def validate(Problem problemInstance) {
        problemInstance.setValide(true)
        problemInstance.save failOnError: true, flush: true
        redirect uri:"/problem/show/${problemInstance.id}",method:"PUT"
    }

    @Secured(['ROLE_ADMIN', 'ROLE_MODERATOR'])
    def validateFromList(Problem problemInstance) {
        problemInstance.setValide(true)
        problemInstance.save failOnError: true, flush: true
        redirect uri:"/problem/index",method:"PUT"
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

        def problem = Problem.get(params.id)
        byte[] img = problem.image

        InputStream input = new ByteArrayInputStream(img);
        BufferedImage bImageFromConvert = ImageIO.read(input);

        int width = 200
        int height = width

        // Operations on image to resize
        BufferedImage resized = new BufferedImage(width, height, bImageFromConvert.getType())
        Graphics2D g = resized.createGraphics()
        g.setRenderingHint(RenderingHints.KEY_INTERPOLATION, RenderingHints.VALUE_INTERPOLATION_BILINEAR)
        g.drawImage(bImageFromConvert, 0, 0, width, height, 0, 0, bImageFromConvert.getWidth(), bImageFromConvert.getHeight(), null)
        g.dispose()

        ByteArrayOutputStream baos = new ByteArrayOutputStream()

        ImageIO.write(resized, 'jpg', baos)
        response.outputStream << baos.toByteArray()
        baos.close()

        //response.outputStream << img
        response.setIntHeader('Content-length', img.length)
        response.contentType = 'image/jpg' // or the appropriate image content type
        response.outputStream.flush()
    }

    @Secured(['ROLE_USER'])
    def alert(Problem problemInstance) {
        redirect action: 'create', controller: 'alert', params: [problemId: problemInstance.id]
    }
}
