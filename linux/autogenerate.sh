#!/bin/bash
# installation of the recommended dependencies
# i.e. Java 1.8, nginx
OS=${OS:-centos6}
file=walkthrough_$OS.sh
if [ -e $file ]; then
	rm $file
fi
cat <<EOF > $file
#!/bin/bash
set -e -u -x
source settings.env
EOF

echo -en '\n' >> $file
echo "#step 1: Install dependencies as root" >> $file
if [ $OS = "centos7" ] ; then
	number=$(sed -n '/#start-workaround/=' step01_"$OS"_deps.sh)
	number=$((number-1))
	line=$(sed -n '2,'$number'p' step01_"$OS"_deps.sh)
	echo "$line" >> $file
	number=$(sed -n '/#end-workaround/=' step01_"$OS"_deps.sh)
	number=$((number+1))
	line=$(sed -n ''$number',$p' step01_"$OS"_deps.sh)
else
	line=$(sed -n '2,$p' step01_"$OS"_deps.sh)
fi
echo "$line" >> $file
echo "#end step 1" >> $file

# review the name of the original file.
if [ $OS = "centos6_py27_ius" ] ; then
	echo -en '\n' >> $file
	echo "#step 1.1: virtual env" >> $file
	#find from where to start copying
	start=$(sed -n '/#start-install/=' step03_"$OS"_virtualenv_deps.sh)
	start=$((start+1))
	number=$(sed -n '/#start-dev/=' step03_"$OS"_virtualenv_deps.sh)
	number=$((number-1))
	line=$(sed -n ''$start','$number'p' step03_"$OS"_virtualenv_deps.sh)
	echo "$line" >> $file
	number=$(sed -n '/#end-dev/=' step03_"$OS"_virtualenv_deps.sh)
	number=$((number+1))
	line=$(sed -n ''$number',$p' step03_"$OS"_virtualenv_deps.sh)
	echo "$line" >> $file
	echo "#end step 1.1:" >> $file
fi

echo -en '\n' >> $file
echo "#step 2: Set-up as root" >> $file
if [ $OS = "centos6_py27" ] || [ $OS = "centos6_py27_ius" ] ; then
	line=$(sed -n '2,$p' step02_"$OS"_setup.sh)
else 
	line=$(sed -n '2,$p' step02_all_setup.sh)
fi
echo "$line" >> $file
echo "#end step 2:" >> $file

# postgres remove section
echo -en '\n' >> $file
echo "#step 3: Database user and database creation as root" >> $file
#find from where to start copying
start=$(sed -n '/#start-setup/=' step03_all_postgres.sh)
start=$((start+1))
line=$(sed -n ''$start',$p' step03_all_postgres.sh)
echo "$line" >> $file
echo "#end step 3" >> $file

echo -en '\n' >> $file
echo "#step 4: OMERO.server install as the omero system user" >> $file
if [ $OS = "centos6_py27" ] || [ $OS = "centos6_py27_ius" ] ; then
	var="${OS//_/}"
	echo "cp settings.env omero-$var.env step04_$OS_omero.sh ~omero " >> $file
	start=$(sed -n '/#start-install/=' step04_"$OS"_omero.sh)
	start=$((start+1))
	line=$(sed -n ''$start',$p' step04_"$OS"_omero.sh)
else 
	echo "cp settings.env step04_all_omero.sh ~omero " >> $file
	start=$(sed -n '/#start-install/=' step04_all_omero.sh)
	start=$((start+1))
	line=$(sed -n ''$start',$p' step04_all_omero.sh)
fi
echo "$line" >> $file
echo "#end step 4" >> $file

v=$OS
if [ $OS = "debian8" ] ; then
	v="ubuntu1404"
fi

echo -en '\n' >> $file
echo "#step 5: Install Web server, Nginx, as root" >> $file
start=$(sed -n '/#start-install/=' step05_"$v"_nginx.sh)
start=$((start+1))
line=$(sed -n ''$start',$p' step05_"$v"_nginx.sh)

echo "$line" >> $file
echo "#end step 5" >> $file

if [ $OS = "centos6_py27" ] || [ $OS = "centos6_py27_ius" ] ; then
	v="centos6"
fi

echo -en '\n' >> $file
echo "#step 6: Scripts to start OMERO and OMERO.web automatically as root" >> $file
line=$(sed -n '2,$p' step06_"$v"_daemon.sh)
echo "$line" >> $file
echo "#end step 6" >> $file

echo -en '\n' >> $file
echo "#step 7: Securing OMERO as root" >> $file
start=$(sed -n '/#start/=' step07_all_perms.sh)
start=$((start+1))
line=$(sed -n ''$start',$p' step07_all_perms.sh)
echo "$line" >> $file
echo "#end step 7" >> $file

echo -en '\n' >> $file
echo "#step 8: Regular tasks" >> $file
line=$(sed -n '2,$p' step08_all_cron.sh)
echo "$line" >> $file
echo "#end step 8" >> $file
