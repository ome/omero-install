
start /w cscript j_unzip.vbs omero\OMERO.server-5.0.5-ice35-b47.zip
xcopy /e /i OMERO.server-5.0.5-ice35-b47 c:\OMERO.server

pushd c:\OMERO.server

python bin\omero db script -f db.sql "" "" omero

set PGPASSWORD=omero
psql -hlocalhost -Uomero -fdb.sql omero
set PGPASSWORD=

mkdir \OMERO
python bin\omero config set omero.data.dir \OMERO
rem python bin\omero config set omero.web.debug True

popd

rem To start OMERO run
rem bin\omero admin start
rem bin\omero web iis
