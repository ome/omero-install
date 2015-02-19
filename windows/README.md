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

- jre-8u31-windows-x64.exe
- postgresql-9.4.0-1-windows-x64.exe
- Ice-3.5.1-3-win-x64-Release.zip
- python-2.7.9\python-2.7.9.amd64.msi

Install Python module dependencies (all the whl files in the `python-2.7.9` directory). These are wheel files which must be installed using pip:

    setup_python_deps.bat

- python-2.7.9\matplotlib-1.4.2-cp27-none-win_amd64.whl
- python-2.7.9\numpy-1.9.2rc1+mkl-cp27-none-win_amd64.whl
- python-2.7.9\numexpr-2.4-cp27-none-win_amd64.whl
- python-2.7.9\Pillow-2.7.0-cp27-none-win_amd64.whl
- python-2.7.9\pyparsing-2.0.3-py2-none-any.whl
- python-2.7.9\python_dateutil-2.4.0-py2.py3-none-any.whl
- python-2.7.9\pytz-2014.10-py2.py3-none-any.whl
- python-2.7.9\six-1.9.0-py2.py3-none-any.whl
- python-2.7.9\tables-3.1.1-cp27-none-win_amd64.whl
- python-2.7.9\virtualenv-12.0.5-py2.py3-none-any.whl
- python-2.7.9\pywin32-219-cp27-none-win_amd64.whl

Reboot, this is because OMERO.server runs under a local system account and modified environment variables will only be picked up after a reboot:

    shutdown /r

Create a database and user for OMERO:

    setup_postgres.bat

Do a basic check of dependencies, you should not see any error messages when this is run:

    check.bat

Setup IIS with Python:

    setup_iis.bat

- python-source\isapi_wsgi-0.4.2.zip

Finally install and configure OMERO in the usual way:

    setup_omero.bat

- omero\OMERO.server-5.0.8-ice35-b60.zip


Optional Prerequisites
----------------------

Install MPlayer (the installation process requires 7zip) and reboot:

    setup_mplayer.bat

- extras/7z938-x64.msi
- extras/mplayer-svn-37353-x86_64.7z

And reboot (due to PATH modification):

    shutdown /r


Additional files
----------------

- installpymod.vbs: A helper script for simulating an interactive install of a Python module.
- j_unzip.vbs: A helper script for unzipping file using the native Windows capabilities.
