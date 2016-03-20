#!/bin/bash
# installation of the recommended dependencies
# i.e. Java 1.8, nginx
OS=${OS:-centos7}
file=walkthrough_$OS.sh
if [ -e $file ]; then
	rm $file
fi
cat <<EOF > $file
#!/bin/bash
set -e -u -x
source settings.env
EOF

N=$OS
if [ $OS = "debian8" ] ; then
	N="ubuntu1404"
fi
echo -en '\n' >> $file
echo "#start-step01: As root, install dependencies" >> $file
line=$(sed -n '2,$p' step01_"$N"_init.sh)
echo "$line" >> $file

# install java
N=$OS
if [[ $OS =~ "centos" ]] ; then
	N="centos"
fi 
echo -en '\n' >> $file
echo "# install Java" >> $file
number=$(sed -n '/#start-recommended/=' step01_"$N"_java_deps.sh)
ns=$((number+1))
number=$(sed -n '/#end-recommended/=' step01_"$N"_java_deps.sh)
ne=$((number-1))
line=$(sed -n ''$ns','$ne'p' step01_"$N"_java_deps.sh)

# remove leading whitespace
line="$(echo -e "${line}" | sed -e 's/^[[:space:]]*//')"

echo "$line"  >> $file
echo -en '\n' >> $file

# install ice
echo "# install Ice" >> $file
N=$OS
if [ $OS = "debian8" ] ; then
	N="ubuntu1404"
fi 
number=$(sed -n '/#start-recommended/=' step01_"$N"_ice_deps.sh)
ns=$((number+1))
number=$(sed -n '/#end-recommended/=' step01_"$N"_ice_deps.sh)
ne=$((number-1))
line=$(sed -n ''$ns','$ne'p' step01_"$N"_ice_deps.sh)

# remove leading whitespace
line="$(echo -e "${line}" | sed -e 's/^[[:space:]]*//')"

echo "$line"  >> $file
echo -en '\n' >> $file

# install dependencies
if [ $OS = "centos7" ] ; then
	number=$(sed -n '/#start-docker-pip/=' step01_"$OS"_deps.sh)
	ne=$((number-2))
	line=$(sed -n '2,'$ne'p' step01_"$OS"_deps.sh)
	echo "$line" >> $file
	# remove leading whitespace
	number=$(sed -n '/#start-docker-pip/=' step01_"$OS"_deps.sh)
	ns=$((number+1))
	number=$(sed -n '/#end-docker-pip/=' step01_"$OS"_deps.sh)
	ne=$((number-1))
	line=$(sed -n ''$ns','$ne'p' step01_"$OS"_deps.sh)
	line="$(echo -e "${line}" | sed -e 's/^[[:space:]]*//')"

	echo "$line" >> $file
	ne=$(($ne+3))
	line=$(sed -n ''$ne',$p' step01_"$OS"_deps.sh)
else
	line=$(sed -n '2,$p' step01_"$OS"_deps.sh)
fi
echo "$line" >> $file
# install postgres
N=$OS
if [ $OS = "debian8" ] ; then
	N="ubuntu1404"
fi
echo -en '\n' >> $file
echo "# install Postgres" >> $file
if [ $OS = "centos7" ] ; then
	number=$(sed -n '/#start-recommended/=' step01_"$N"_pg_deps.sh)
	nrs=$((number+1))
	number=$(sed -n '/#end-recommended/=' step01_"$N"_pg_deps.sh)
	nre=$((number-1))
	number=$(sed -n ''$nrs','$nre'!d;/#start-workaround/!d;=' step01_"$N"_pg_deps.sh)
	ne=$((number-1))
	line=$(sed -n ''$nrs','$ne'p' step01_"$N"_pg_deps.sh)
	# remove leading whitespace
	line="$(echo -e "${line}" | sed -e 's/^[[:space:]]*//')"

	echo "$line" >> $file
	number=$(sed -n ''$nrs','$nre'!d;/#end-workaround/!d;=' step01_"$N"_pg_deps.sh)
	ns=$((number+1))
	number=$(sed -n '/#end-recommended/=' step01_"$N"_pg_deps.sh)
	ne=$((number-1))
	line=$(sed -n ''$ns','$ne'p' step01_"$N"_pg_deps.sh)
else
	number=$(sed -n '/#start-recommended/=' step01_"$N"_pg_deps.sh)
	ns=$((number+1))
	number=$(sed -n '/#end-recommended/=' step01_"$N"_pg_deps.sh)
	ne=$((number-1))
	line=$(sed -n ''$ns','$ne'p' step01_"$N"_pg_deps.sh)
fi
# remove leading whitespace
line="$(echo -e "${line}" | sed -e 's/^[[:space:]]*//')"

echo "$line"  >> $file
echo -en '\n' >> $file

echo "#end-step01" >> $file

if [ $OS = "centos6_py27_ius" ] ; then
	echo -en '\n' >> $file
	echo "#start-step01.1: virtual env" >> $file
	#find from where to start copying
	start=$(sed -n '/#start-install/=' step01_"$OS"_virtualenv_deps.sh)
	start=$((start+1))
	number=$(sed -n '/#start-dev/=' step01_"$OS"_virtualenv_deps.sh)
	number=$((number-1))
	line=$(sed -n ''$start','$number'p' step01_"$OS"_virtualenv_deps.sh)
	echo "$line" >> $file
	number=$(sed -n '/#end-dev/=' step01_"$OS"_virtualenv_deps.sh)
	number=$((number+1))
	line=$(sed -n ''$number',$p' step01_"$OS"_virtualenv_deps.sh)
	echo "$line" >> $file
	echo "#end-step01.1" >> $file
fi

echo -en '\n' >> $file
echo "#start-step02: As root, create an omero system user and directory for the OMERO repository" >> $file
if [ $OS = "centos6_py27" ] || [ $OS = "centos6_py27_ius" ] ; then
	line=$(sed -n '2,$p' step02_"$OS"_setup.sh)
else 
	line=$(sed -n '2,$p' step02_all_setup.sh)
fi
echo "$line" >> $file
echo "#end-step02" >> $file

# postgres remove section
echo -en '\n' >> $file
echo "#start-step03: As root, create a database user and a database" >> $file
#find from where to start copying
start=$(sed -n '/#start-setup/=' step03_all_postgres.sh)
start=$((start+1))
line=$(sed -n ''$start',$p' step03_all_postgres.sh)
echo "$line" >> $file
echo "#end-step03" >> $file

echo -en '\n' >> $file
echo "#start-step04: As the omero system user, install the OMERO.server" >> $file
if [[ $OS =~ "centos6_py27" ]] ; then
	var="${OS//_/}"
	echo "#start-copy-omeroscript" >> $file
	echo "cp settings.env omero-$var.env step04_$OS_omero.sh ~omero " >> $file
	echo "#end-copy-omeroscript" >> $file
	start=$(sed -n '/#start-install/=' step04_"$OS"_omero.sh)
	start=$((start+1))
	line=$(sed -n ''$start',$p' step04_"$OS"_omero.sh)
else 
	echo "#start-copy-omeroscript" >> $file
	echo "cp settings.env step04_all_omero.sh ~omero " >> $file
	echo "#end-copy-omeroscript" >> $file
	start=$(sed -n '/#start-install/=' step04_all_omero.sh)
	start=$((start+1))
	line=$(sed -n ''$start',$p' step04_all_omero.sh)
fi
echo "$line" >> $file
echo "#end-step04" >> $file

v=$OS
if [ $OS = "debian8" ] ; then
	v="ubuntu1404"
fi

echo -en '\n' >> $file
echo "#start-step05: As root, install a Web server: Nginx or Apache" >> $file
echo "#start-nginx" >> $file
start=$(sed -n '/#start-install/=' step05_"$v"_nginx.sh)
start=$((start+1))
line=$(sed -n ''$start',$p' step05_"$v"_nginx.sh)
echo "$line" >> $file
echo "#end-nginx" >> $file
echo -en '\n' >> $file
echo "#start-apache" >> $file

apachever="apache24" #webserver might become a parameter
if [ $OS = "centos6" ] || [ $OS = "centos6_py27_ius" ] ; then
	apachever="apache22"
fi
line=$(sed -n ''/#start-copy/','/#end-copy/'p' step05_"$v"_"$apachever".sh)
echo "$line" >> $file
echo "#start-configure: As the omero system user, configure OMERO.web" >> $file
start=$(sed -n '/#start-config/=' setup_omero_"$apachever".sh)
start=$((start+1))
line=$(sed -n ''$start',$p' setup_omero_"$apachever".sh)
echo "$line" >> $file
echo "#end-configure" >> $file
#start install
echo "#start-apache-install" >> $file
start=$(sed -n '/#start-install/=' step05_"$v"_"$apachever".sh)
start=$((start+1))
line=$(sed -n ''$start',$p' step05_"$v"_"$apachever".sh)
echo "$line" >> $file
echo "#end-apache-install" >> $file
echo "#end-apache" >> $file
echo "#end-step05" >> $file

if [[ $OS =~ "centos6" ]] ; then
	v="centos6"
fi

echo -en '\n' >> $file
echo "#start-step06: As root, run the scripts to start OMERO and OMERO.web automatically" >> $file
line=$(sed -n '2,$p' step06_"$v"_daemon.sh)
echo "$line" >> $file
echo "#end-step06" >> $file

echo -en '\n' >> $file
echo "#start-step07: As root, secure OMERO" >> $file
start=$(sed -n '/#start/=' step07_all_perms.sh)
start=$((start+1))
line=$(sed -n ''$start',$p' step07_all_perms.sh)
echo "$line" >> $file
echo "#end-step07" >> $file

echo -en '\n' >> $file
echo "#start-step08: As root, perform regular tasks" >> $file
echo "#start-omeroweb-cron" >> $file
line=$(sed -n '2,$p' omero-web-cron)
echo "$line" >> $file
echo "#end-omeroweb-cron" >> $file
echo "#Copy omero-web-cron into the appropriate location" >> $file
echo "#start-copy-omeroweb-cron" >> $file
line=$(sed -n '2,$p' step08_all_cron.sh)
echo "$line" >> $file
echo "#end-copy-omeroweb-cron" >> $file
echo "#end-step08" >> $file

if [[ $OS =~ "centos" ]]; then
echo "#start-selinux" >> $file
line=$(sed -n '2,$p' setup_centos_selinux.sh)
echo "$line" >> $file
echo "#end-selinux" >> $file
fi
