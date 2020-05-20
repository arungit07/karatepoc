package examples.users;

import com.intuit.karate.junit5.Karate;

class UsersRunner {
    
    @Karate.Test
    Karate testUsers() {
        return Karate.run("users").relativeTo(getClass());
    }

    @Karate.Test
    Karate testUserslist() {
        return Karate.run("userslist").relativeTo(getClass());
    }

    @Karate.Test
    Karate testUserscreate() {
        return Karate.run("userscreate").relativeTo(getClass());
    }

    @Karate.Test
    Karate testUsersupdate() {
        return Karate.run("usersupdate").relativeTo(getClass());
    }

    @Karate.Test
    Karate testUsersdelete() {
        return Karate.run("usersdelete").relativeTo(getClass());
    }

    @Karate.Test
    Karate testUsersview() {
        return Karate.run("userview").relativeTo(getClass());
    }

}
