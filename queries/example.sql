SELECT "example.users", (SELECT count(1) from mysql.user);
