package users

import org.apache.commons.lang.builder.HashCodeBuilder

class UserRole implements Serializable {

    private static final long serialVersionUID = 1

    User secUser
    Role secRole

    boolean equals(other) {
        if (!(other instanceof UserRole)) {
            return false
        }

        other.secUser?.id == secUser?.id &&
                other.secRole?.id == secRole?.id
    }

    int hashCode() {
        def builder = new HashCodeBuilder()
        if (secUser) builder.append(secUser.id)
        if (secRole) builder.append(secRole.id)
        builder.toHashCode()
    }

    static UserRole get(long secUserId, long secRoleId) {
        UserRole.where {
            secUser == User.load(secUserId) &&
                    secRole == Role.load(secRoleId)
        }.get()
    }

    static boolean exists(long secUserId, long secRoleId) {
        UserRole.where {
            secUser == User.load(secUserId) &&
                    secRole == Role.load(secRoleId)
        }.count() > 0
    }

    static UserRole create(User secUser, Role secRole, boolean flush = false) {
        def instance = new UserRole(secUser: secUser, secRole: secRole)
        instance.save(flush: flush, insert: true)
        instance
    }

    static boolean remove(User u, Role r, boolean flush = false) {
        if (u == null || r == null) return false

        int rowCount = UserRole.where {
            secUser == User.load(u.id) &&
                    secRole == Role.load(r.id)
        }.deleteAll()

        if (flush) {
            UserRole.withSession { it.flush() }
        }

        rowCount > 0
    }

    static void removeAll(User u, boolean flush = false) {
        if (u == null) return

        UserRole.where {
            secUser == User.load(u.id)
        }.deleteAll()

        if (flush) {
            UserRole.withSession { it.flush() }
        }
    }

    static void removeAll(Role r, boolean flush = false) {
        if (r == null) return

        UserRole.where {
            secRole == Role.load(r.id)
        }.deleteAll()

        if (flush) {
            UserRole.withSession { it.flush() }
        }
    }

    static constraints = {
        secRole validator: { Role r, UserRole ur ->
            if (ur.secUser == null) return
            boolean existing = false
            UserRole.withNewSession {
                existing = UserRole.exists(ur.secUser.id, r.id)
            }
            if (existing) {
                return 'userRole.exists'
            }
        }
    }

    static mapping = {
        id composite: ['secRole', 'secUser']
        version false
    }
}
