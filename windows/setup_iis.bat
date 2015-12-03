start /w dism /Online /Enable-Feature /FeatureName:IIS-WebServerRole /FeatureName:IIS-WebServer /FeatureName:IIS-CommonHttpFeatures /FeatureName:IIS-Security /FeatureName:IIS-RequestFiltering /FeatureName:IIS-StaticContent /FeatureName:IIS-DefaultDocument /FeatureName:IIS-DirectoryBrowsing /FeatureName:IIS-HttpErrors /FeatureName:IIS-ApplicationDevelopment /FeatureName:IIS-ISAPIExtensions /FeatureName:IIS-ISAPIFilter /FeatureName:IIS-HealthAndDiagnostics /FeatureName:IIS-HttpLogging /FeatureName:IIS-Performance /FeatureName:IIS-HttpCompressionStatic /FeatureName:IIS-WebServerManagementTools /FeatureName:IIS-ManagementConsole /FeatureName:IIS-IIS6ManagementCompatibility /FeatureName:IIS-Metabase

set PYTHONPIP=C:\Python27\Scripts\pip.exe
%PYTHONPIP% install -r c:\OMERO.server\share\web\requirements-py27-win.txt

start /w cscript j_unzip.vbs python-source\isapi_wsgi-0.4.2.zip
pushd isapi_wsgi-0.4.2
python setup.py install
popd

