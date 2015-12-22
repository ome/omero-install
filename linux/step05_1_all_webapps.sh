
#!/bin/bash

# Figure details
URL_FIGURE=http://downloads.openmicroscopy.org/figure/1.2.0/figure-1.2.0.zip
NAME_FIGURE=figure-1.2.0

# Web tagging details
URL_WEBTAGGING=http://downloads.openmicroscopy.org/webtagging/1.3.0/webtagging-1.3.0.zip
NAME_WEBTAGGING=webtagging-1.3.0

# Read parameter
VIRTUALENV=false
for arg in "$@"; do
	case "$arg" in ve)
	VIRTUALENV=true;;
	esac
done

# Add OMERO.figure
cd ~omero
wget $URL_FIGURE
unzip -q $NAME_FIGURE.zip
mv $NAME_FIGURE OMERO.server/lib/python/omeroweb/figure

# Install required packages
if [ $VIRTUALENV = true ]; then
	/home/omero/omeroenv/bin/pip2.7 install reportlab markdown
else
	pip install reportlab markdown
fi

# Register the app
su - omero -c "OMERO.server/bin/omero config append omero.web.apps '\"figure\"'"
su - omero -c "OMERO.server/bin/omero config append omero.web.ui.top_links '[\"Figure\", \"figure_index\", {\"title\": \"Open Figure in new tab\", \"target\": \"figure\"}]'"

# Webtagging
wget $URL_WEBTAGGING
unzip -q $NAME_WEBTAGGING.zip
mv $NAME_WEBTAGGING/autotag OMERO.server/lib/python/omeroweb/autotag
mv $NAME_WEBTAGGING/tagsearch OMERO.server/lib/python/omeroweb/tagsearch

# Register the app
su - omero -c "OMERO.server/bin/omero config append omero.web.apps '\"autotag\"'"
su - omero -c "OMERO.server/bin/omero config append omero.web.apps '\"tagsearch\"'"
su - omero -c "OMERO.server/bin/omero config append omero.web.ui.center_plugins '[\"Auto Tag\", \"autotag/auto_tag_init.js.html\", \"auto_tag_panel\"]'"
su - omero -c "OMERO.server/bin/omero config append omero.web.ui.top_links '[\"Tag Search\", \"tagsearch\"]'"

# Web gallery
#clone the repository
git clone https://github.com/ome/gallery.git
mv gallery OMERO.server/lib/python/omeroweb/gallery
su - omero -c "OMERO.server/bin/omero config append omero.web.apps '\"gallery\"'"
