Windows Python 2.7 Ice 3.5 OMERO installation
=============================================

This is a walkthrough for setting up OMERO on a new Windows 7 machine. This directory also contains batch scripts for partially automating many of the installation steps.

If you are performing a manual installation you can just double click on the relevant installer files and accept the defaults when prompted (ignore any command line parameters passed in the scripts).

If you are using the batch scripts it is best to run them from a command prompt instead of double-clicking them, so that you can see any error messages. The scripts assume this directory contains the binaries listed under "Required files". You can copy this entire directory onto your local filesystem and start a command prompt in that directory.


Prerequisites
-------------

Install Python, Java, PostgreSQL and Ice. Set/update the system PATH and PYTHONPATH environment variables. For the custom Ice 3.5 binaries you will need to add the `bin` and `lib` directories to PATH, and the `python` directory to PYTHONPATH. It is also helpful to add the Python and PostgreSQL directories to PATH.

Note that due to a bug(?) in the Python installer it is not possible to do an unattended install at present. Accept all the defaults in the installation dialog.

    setup_windows.bat

- jre-7u67-windows-x64.exe
- postgresql-9.3.4-3-windows-x64.exe
- Ice-3.5.1-2-win-x64-Release.zip
- python-2.7.6/python-2.7.6.amd64.msi

Install Python module dependencies (all the exes in the `python-2.7.6` directory). Note that these python modules are built as exes which, unlike msi files, cannot be scripted. As a workaround `installpymod.vbs` simulates hitting `<ENTER>` on the keyboard to move through the installer prompts, however it uses simple timeouts so if the installer is slow it may not work:

    setup_python_deps.bat

- python-2.7.6/matplotlib-1.3.1.win-amd64-py2.7.exe
- python-2.7.6/numexpr-2.4.win-amd64-py2.7.exe
- python-2.7.6/numpy-MKL-1.8.1.win-amd64-py2.7.exe
- python-2.7.6/Pillow-2.4.0.win-amd64-py2.7.exe
- python-2.7.6/pyparsing-2.0.2.win-amd64-py2.7.exe
- python-2.7.6/python-dateutil-2.2.win-amd64-py2.7.exe
- python-2.7.6/pytz-2014.2.win-amd64-py2.7.exe
- python-2.7.6/pywin32-218.win-amd64-py2.7.exe
- python-2.7.6/six-1.6.1.win-amd64-py2.7.exe
- python-2.7.6/tables-3.1.1.win-amd64-py2.7.exe
- python-2.7.6/virtualenv-1.11.4.win-amd64-py2.7.exe

Reboot, this is because OMERO.server runs under a local system account and modified environment variables will only be picked up after a reboot:

    shutdown /r

Create a database and user for OMERO:

    setup_postgres.bat

Do a basic check of dependencies, you should not see any error messages when this is run:

    check.bat

Finally install and configure OMERO in the usual way:

    setup_omero.bat

- omero/OMERO.server-5.0.2-ice35-b26.zip


Required files
--------------

- jre-7u67-windows-x64.exe
- postgresql-9.3.4-3-windows-x64.exe
- Ice-3.5.1-2-win-x64-Release.zip

- python-2.7.6/python-2.7.6.amd64.msi

- python-2.7.6/matplotlib-1.3.1.win-amd64-py2.7.exe
- python-2.7.6/numexpr-2.4.win-amd64-py2.7.exe
- python-2.7.6/numpy-MKL-1.8.1.win-amd64-py2.7.exe
- python-2.7.6/Pillow-2.4.0.win-amd64-py2.7.exe
- python-2.7.6/pyparsing-2.0.2.win-amd64-py2.7.exe
- python-2.7.6/python-dateutil-2.2.win-amd64-py2.7.exe
- python-2.7.6/pytz-2014.2.win-amd64-py2.7.exe
- python-2.7.6/pywin32-218.win-amd64-py2.7.exe
- python-2.7.6/six-1.6.1.win-amd64-py2.7.exe
- python-2.7.6/tables-3.1.1.win-amd64-py2.7.exe
- python-2.7.6/virtualenv-1.11.4.win-amd64-py2.7.exe

- omero/OMERO.server-5.0.2-ice35-b26.zip


Additional files
----------------

- installpymod.vbs: A helper script for simulating an interactive install of a Python module. 
- j_unzip.vbs: A helper script for unzipping file using the native Windows capabilities.

