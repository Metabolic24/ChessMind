package users

import score.Score

class User {

    transient springSecurityService

    /*Attributes*/

    String username
    String password
    String email

    boolean enabled = true
    boolean accountExpired
    boolean accountLocked
    boolean passwordExpired

    Score score

    String name
    String description = ""

    static transients = ['springSecurityService']

    static constraints = {
        username blank: false, unique: true
        password blank: false
        email email: true, blank: false
        name blank: false, nullable: true
    }

    static mapping = {
        password column: '`password`'
    }

    Set<Role> getAuthorities() {
        UserRole.findAllByUser(this).collect { it.role }
    }

    def beforeInsert() {
        encodePassword()
    }

    def beforeUpdate() {
        if (isDirty('password')) {
            encodePassword()
        }
    }

    static List<User> filterByAuthority(String authority,Map params) {
        def list = User.list(params)
        ArrayList<User> result = new ArrayList<>()
        for (User user : list) {
            if(user.getAuthorities().contains(Role.findByAuthority(authority))){
                result.add(user)
            }
        }
        result
    }

    protected void encodePassword() {
        password = springSecurityService?.passwordEncoder ? springSecurityService.encodePassword(password) : password
    }
}
