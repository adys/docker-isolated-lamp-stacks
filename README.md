Manage lamp stacks on a docker host
============

manage-stack.sh
----------------

* Create / Destroy lamp stacks on a docker host.
* Help:
```
$ ./manage-stack.sh
Usage: manage-stack.sh <stack-id> <stack-port> <action>

   stack-id      The stack runs as a user with the 'stack-id' uid.
   stack-port    The port that apache2 binds to.
   action        'create' or 'destroy' the stack.

   Example:
   ./manage-stack.sh 1111 8080 create
```

* Examples:
```
$ ./manage-stack.sh 1111 8080 create
[manage-stack.sh] 2018-05-14T13:08:08+0200 | Creating directories ...
[manage-stack.sh] 2018-05-14T13:08:08+0200 | Done.
[manage-stack.sh] 2018-05-14T13:08:08+0200 | Generating secrets ...
[manage-stack.sh] 2018-05-14T13:08:08+0200 | Done.
[manage-stack.sh] 2018-05-14T13:08:08+0200 | Running docker compose ...
Creating network "1111_dmz" with the default driver
Creating network "1111_data" with the default driver
Creating 1111_mysql_1      ... done
Creating 1111_apache-php_1 ... done
[manage-stack.sh] 2018-05-14T13:08:10+0200 | Done.
```
```
$ ./manage-stack.sh 1111 8080 destroy
[manage-stack.sh] 2018-05-14T13:08:28+0200 | Running docker compose ...
Stopping 1111_apache-php_1 ... done
Removing 1111_apache-php_1 ... done
Removing 1111_mysql_1      ... done
Removing network 1111_dmz
Removing network 1111_data
[manage-stack.sh] 2018-05-14T13:08:29+0200 | Done.
[manage-stack.sh] 2018-05-14T13:08:29+0200 | Destroying directories ...
[manage-stack.sh] 2018-05-14T13:08:29+0200 | Done.
```
