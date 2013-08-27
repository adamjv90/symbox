symbox
======

 * Basic configuration generated with https://puphpet.com/


Installation
============

    ~$ curl https://raw.github.com/sweikenb/symbox/master/installer.sh | sh
    ~$ vagrant up
    ~$ vagrant ssh


Accessing the VM
================

 * Edit the hosts file of your system (e.g. '/etc/hosts' on Mac OS X) and add:

    192.168.10.10 symbox.dev
    192.168.10.10 www.symbox.dev

 * Now you can access the VM with your browser: http://symbox.dev/ or http://www.symbox.dev/


Security
========

 * symbox uses the default 'precise64' image provided by http://www.vagrantbox.es/
 * All generated passwords are set to "symbox" (e.g. MySQL root)
