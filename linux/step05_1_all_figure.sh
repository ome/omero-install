
#!/bin/bash
wget http://downloads.openmicroscopy.org/figure/1.2.0/figure-1.2.0.zip

# Add OMERO web
cd ~omero
wget http://downloads.openmicroscopy.org/figure/1.2.0/figure-1.2.0.zip
unzip -q figure-1.2.0.zip
mv figure-1.2.0 OMERO.server/lib/python/omeroweb/figure

# Install required package for web
pip install reportlab markdown

su - omero -c "OMERO.server/bin/omero config append omero.web.apps '\"figure\"'"
su - omero -c "OMERO.server/bin/omero config append omero.web.ui.top_links '[\"Figure\", \"figure_index\", {\"title\": \"Open Figure in new tab\", \"target\": \"figure\"}]'"