
start /w cscript j_unzip.vbs omero\OMERO.server-5.0.4-ice34-b43
xcopy /e /i OMERO.server-5.0.4-ice34-b43 c:\OMERO.server-5.0.4-ice34-b43

pushd c:\OMERO.server-5.0.4-ice34-b43

python bin\omero db script -f db.sql "" "" omero

set PGPASSWORD=omero
psql -hlocalhost -Uomero -fdb.sql omero
set PGPASSWORD=

mkdir \OMERO
python bin\omero config set omero.data.dir \OMERO
rem python bin\omero config set omero.web.debug True

popd

rem To start OMERO reboot and run
rem bin\omero admin start
rem bin\omero web iis
