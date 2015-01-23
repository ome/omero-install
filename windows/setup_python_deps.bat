set PYTHONPIP=C:\Python27\Scripts\pip.exe

%PYTHONPIP% install python-2.7.9\matplotlib-1.4.2-cp27-none-win_amd64.whl
cscript installpymod.vbs python-2.7.9\numpy-MKL-1.9.1.win-amd64-py2.7.exe 10000
cscript installpymod.vbs python-2.7.9\numexpr-2.4.win-amd64-py2.7.exe 5000
%PYTHONPIP% install python-2.7.9\Pillow-2.7.0-cp27-none-win_amd64.whl
cscript installpymod.vbs python-2.7.9\pyparsing-2.0.3.win-amd64-py2.7.exe 5000
%PYTHONPIP% install python-2.7.9\python_dateutil-2.4.0-py2.py3-none-any.whl
%PYTHONPIP% install python-2.7.9\pytz-2014.10-py2.py3-none-any.whl
%PYTHONPIP% install python-2.7.9\six-1.9.0-py2.py3-none-any.whl
%PYTHONPIP% install python-2.7.9\tables-3.1.1-cp27-none-win_amd64.whl
%PYTHONPIP% install python-2.7.9\virtualenv-12.0.5-py2.py3-none-any.whl

%PYTHONPIP% install python-2.7.9\pywin32-219-cp27-none-win_amd64.whl
c:\Python27\Scripts\pywin32_postinstall.py -install
