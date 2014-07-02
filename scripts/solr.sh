#!/bin/sh


# Setup Solr
mkdir downloads
curl http://archive.apache.org/dist/lucene/solr/4.9.0/solr-4.9.0.tgz | tar xz
mv solr-4.9.0 downloads/solr
sudo cp downloads/solr/example/lib/ext/* /usr/share/tomcat7/lib/
sudo cp downloads/solr/dist/solr-4.9.0.war /var/lib/tomcat7/webapps/solr.war
sudo cp -R downloads/solr/example/solr /var/lib/tomcat7
sudo chown -R tomcat7:tomcat7 /var/lib/tomcat7/solr

sudo service tomcat7 restart