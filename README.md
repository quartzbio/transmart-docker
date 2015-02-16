# transmart-docker
A proof of concept docker for transmart

# Disclaimer
This work is only a proof of concept, and should only be used for testing purposes. 
It is not distributed by the Transmart foundation nor by the eTRIKS consortium.

# What is it ?
This docker provides a fat container running tomcat, solr, Rserve and Postgres, to deliver the transmart web-app.

## transmart version
The transmart software currently provided in the master branch is transmart.war.1.2.2.e.fg-fix
as downloaded from https://portal.etriks.org/Portal/

# How to use it ?
clone the repository, and type: **make run** 
By default it will bind the docker ports to your computer, then point your browser to: (http://localhost:8080)

N.B: If you use boot2docker (e.g. on MacOsX or Windows), use instead the boot2docker ip 
(e.g. http://192.168.59.103:8080).

## how to connect to the Postgres instance running inside the docker

The ports should be forwarded, so that you should be able to connect from your computer:
```
PGPASSWORD=biomart_user psql transmart -h localhost -U biomart_user
```

## actual deployment
in a real-life deployment, a lot of files should actually be written on the host or in a data volume:
 - the database files (currently in /var/lib/postgresql/tablespaces)
 - the logs: in /var/logs/ and /var/log/supervisor/
 - the data files (CEL files): ? 
 

# Implementation

I used the installation instructions from here: 
https://wiki.transmartfoundation.org/pages/viewpage.action?pageId=6619205

## postgres
To be able to connect from the host computer, I had to mess with postgresql.conf and pg_hba.conf in 
/etc/postgresql/9.3/main/.

## solr port
We had to set the solr port in /usr/share/tomcat7/.grails/transmartConfig/Config.groovy

## supervisor: for running services
In a docker, quite often we can not use the normal startup scripts. 
I used supervisor as a simple way to start the required services, have a look at **supervisord.conf** to check it. 

# Troubleshooting, TODO

## Sample Details not working
I get an endless "Loading" message.

## pdi-ce-4.4.0-stable.tar.gz quite huge
the transmart-data could probably try to avoid this big download.

## split the docker into many sub-dockers
Instead of a big monolithic container, we could use one for the database, one for solR, one for solR. 

## reduce the overall size
It is currently probably overweighted.


