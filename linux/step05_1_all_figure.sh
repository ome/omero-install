
#!/bin/bash

# Read parameter
VIRTUALENV=false
for arg in "$@"; do
	case "$arg" in ve)
	VIRTUALENV=true;;
	esac
done

# Add OMERO.figure
cd ~omero
wget http://downloads.openmicroscopy.org/figure/1.2.0/figure-1.2.0.zip
unzip -q figure-1.2.0.zip
mv figure-1.2.0 OMERO.server/lib/python/omeroweb/figure

# Install required packages
if [ $VIRTUALENV = true ]; then
	/home/omero/omeroenv/bin/pip2.7 install reportlab markdown
else
	pip install reportlab markdown
fi

su - omero -c "OMERO.server/bin/omero config append omero.web.apps '\"figure\"'"
su - omero -c "OMERO.server/bin/omero config append omero.web.ui.top_links '[\"Figure\", \"figure_index\", {\"title\": \"Open Figure in new tab\", \"target\": \"figure\"}]'"