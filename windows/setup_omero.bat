
start /w cscript j_unzip.vbs omero\OMERO.server-5.1.1-ice35-b43.zip
xcopy /e /i OMERO.server-5.1.1-ice35-b43 c:\OMERO.server

pushd c:\OMERO.server

python bin\omero db script -f db.sql "" "" omero

set PGCLIENTENCODING=UTF8
set PGPASSWORD=omero
psql -hlocalhost -Uomero -fdb.sql omero
set PGPASSWORD=

mkdir \OMERO
python bin\omero config set omero.data.dir \OMERO
rem python bin\omero config set omero.web.debug True

popd
