Yubikey_gnupg
=============

This project will help to build a rpm that can be installed to use the yubikey with the openpgcard applet as a keystore for ssh & gnupg.

Building the rpm
----------------

To build the rpm, first ensure that the prerequisites are installed.

    # dnf install @development-tools
    # dnf install fedora-packager
    # dnf install rpmdevtools

The issue the command:

   rpmdev-setuptree

and perform a checkout of this project.

Move the *spec file to ~/rpmbuild/SPECS

To download the source file, issue the commands below

    # cd ~/rpmbuild/SOURCES
    # wget `spectool yubikey_gnupg.spec  | awk  {'print $2}'`

Execute then the command below to build the rpm

    cp ~/rpmbuild/SPEC
    rpmbuild -ta yubikey_gnupg

The final rpm can be found in the directory ~/rpmbuild/RPMS/noarch/
