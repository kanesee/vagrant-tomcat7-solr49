#!/bin/sh

sudo apt-get update
sudo apt-get install -y puppet



# Setup Solr
# wget http://archive.apache.org/dist/lucene/solr/4.9.0/solr-4.9.0.tgz
# tar -vxf solr-4.9.0.tgz
# mkdir /opt/solr
# mv -r solr-4.9.0/example/solr/* /opt/solr/
# cp solr-4.9.0/example/webapps/solr.war /opt/solr/
# cp -r solr-4.9.0/example/lib/ext/* /var/lib/tomcat6/shared/