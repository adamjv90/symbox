symbox
======

 * Optimized for symfony2 v2.3
 * Basic configuration generated with https://puphpet.com/


Installation
------------

 * Edit "web/app_dev.php" and "192.168.10.1" to the array of allowed IPs within the "if"- condition
 * Do the same for "web/config.php" if you use this file

Open up a terminal and run the install script:

    ~$ curl https://raw.github.com/sweikenb/symbox/master/installer.sh | sh
    ~$ vagrant up
    ~$ vagrant ssh


Update
------

Open up a terminal and run the update script:

    ~$ curl https://raw.github.com/sweikenb/symbox/master/update.sh | sh
    ~$ vagrant reload
    ~$ vagrant ssh


Accessing the VM
----------------

 * Edit the hosts file of your system (e.g. '/etc/hosts' on Mac OS X) and add: "192.168.10.10 symbox.dev"
 * Now you can access the VM with your browser: http://symbox.dev/


Security
--------

 * symbox uses the default 'precise64' image provided by http://www.vagrantbox.es/
 * All generated passwords are set to "symbox" (e.g. MySQL root)

