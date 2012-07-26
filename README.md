unquarantine
============

zsh script to remote Mac OS X Quarantine information from files and Applications.

While the quarantine warnings in Mac OS X have previously been merely annoying, in Mountain Lion they actively prevent
you from using applications which haven't been signed.

You can turn off the protection altogether, or you can right/control click on the app.

But I wanted to be able to do it from the command line.

The script is fairly simple: give it the name of a file or folder, and it will remove the quarantine information from it.

(If you give it a folder, it will try to remove quarantine information from any executable file in that folder.)

If no quarantine information is found, it will just say that.

If quarantine information is removed, it will tell you that.

If something else happens, it will tell you that and exit immediately so you can track down the problem.


