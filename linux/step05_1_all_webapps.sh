
#!/bin/bash

PY_ENV=${PY_ENV:-all}

# Figure details
URL_FIGURE=http://downloads.openmicroscopy.org/figure/1.2.0/figure-1.2.0.zip
NAME_FIGURE=figure-1.2.0

# Web tagging details
URL_WEBTAGGING=http://downloads.openmicroscopy.org/webtagging/1.3.0/webtagging-1.3.0.zip
NAME_WEBTAGGING=webtagging-1.3.0

# Gallery 
URL_GALLERY=https://github.com/ome/gallery/archive/v1.0.0.zip
NAME_GALLERY_ZIP=v1.0.0.zip
NAME_GALLERY=gallery-1.0.0

# web test
URL_WEBTEST=https://github.com/openmicroscopy/webtest/archive/master.zip
NAME_WEBTEST_ZIP=master.zip
NAME_WEBTEST=webtest-master

# Add OMERO.figure
cd ~omero
wget $URL_FIGURE
unzip -q $NAME_FIGURE.zip
mv $NAME_FIGURE OMERO.server/lib/python/omeroweb/figure

echo "value=$PY_ENV"
# Install required packages
if [ "$PY_ENV" = "ius" ]; then
	/home/omero/omeroenv/bin/pip2.7 install reportlab markdown
elif [ "$PY_ENV" = "scl" ]; then
	set +u
	source /opt/rh/python27/enable
	set -u
	pip install reportlab markdown
else
	pip install reportlab markdown
fi

# Register the app
su - omero -c "OMERO.server/bin/omero config append omero.web.apps '\"figure\"'"
su - omero -c "OMERO.server/bin/omero config append omero.web.ui.top_links '[\"Figure\", \"figure_index\", {\"title\": \"Open Figure in new tab\", \"target\": \"figure\"}]'"

# Copy the script 
FOLDER=OMERO.server/lib/python/omeroweb/figure/scripts
cp $FOLDER/omero/figure_scripts/Figure_To_Pdf.py OMERO.server/lib/scripts/omero/figure_scripts

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
wget $URL_GALLERY
unzip -q $NAME_GALLERY_ZIP

mv $NAME_GALLERY OMERO.server/lib/python/omeroweb/gallery
su - omero -c "OMERO.server/bin/omero config append omero.web.apps '\"gallery\"'"

# Web test
wget $URL_WEBTEST
unzip -q $NAME_WEBTEST_ZIP

mv $NAME_WEBTEST OMERO.server/lib/python/omeroweb/webtest
su - omero -c "OMERO.server/bin/omero config append omero.web.apps '\"webtest\"'"

su - omero -c "OMERO.server/bin/omero config append omero.web.ui.right_plugins '[\"ROIs\", \"webtest/webclient_plugins/right_plugin.rois.js.html\", \"image_roi_tab\"]'"
su - omero -c "OMERO.server/bin/omero config append omero.web.ui.center_plugins '[\"Split View\", \"webtest/webclient_plugins/center_plugin.splitview.js.html\", \"split_view_panel\"]'"
