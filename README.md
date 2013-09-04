symbox
======

 * Optimized for symfony2 v2.3
 * Basic configuration generated with https://puphpet.com/


Custom modifications
--------------------

For persistent custom modifications you have these options:

 1. Install symbox by hand
 2. Fork symbox and overwrite the repository location in your main "composer.json"-file to your forked version of symbox with your custom modifications


Basic installation with Composer
--------------------------------

 * Edit "web/app_dev.php" and add "192.168.10.1" to the array of allowed IPs within the "if"- condition
 * Do the same for "web/config.php" if you use this file

Add the following dependency and script-callbacks to your main "composer.json"-file:

    "require": {
        ... ,
        "basecom/symbox": ">=1.1,<2.0"
    },
    "scripts": {
        "post-install-cmd": [
            ... ,
            "basecom\\symbox\\ComposerCallback::install"
        ],
        "post-update-cmd": [
            ... ,
            "basecom\\symbox\\ComposerCallback::update"
        ]
    }


Manual installation
-------------------

 * Download the current release-version of symbox as Zip
 * Extract files and move the included "Vagrantfile"-file and "symbox"-folder into your project root
 * Edit "web/app_dev.php" and add "192.168.10.1" to the array of allowed IPs within the "if"- condition
 * Do the same for "web/config.php" if you use this file
 * Have fun!


Accessing the VM
----------------

 * Edit the hosts file of your system (e.g. '/etc/hosts' on Mac OS X) and add: "192.168.10.10 symbox.dev"
 * Now you can access the VM with your browser: http://symbox.dev/

To connect via ssh, you can simply run the default vagrant command:

    ~$ vagrant ssh


Security
--------

 * symbox uses the default 'precise64' image provided by http://www.vagrantbox.es/
 * All generated passwords are set to "symbox" (e.g. MySQL root)

