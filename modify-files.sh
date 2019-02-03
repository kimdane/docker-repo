dir=/opt/repo/openidm
if [ -e "$dir" ]; then
	mv /opt/repo/openidm /opt/repo/openidm-conf
fi

file=/opt/repo/bin/staging/openidm.zip
if [ -s "$file" ]; then
	## Unziping and extracting schema-files from openidm to postgres
	unzip -n /opt/repo/bin/staging/openidm.zip -d /opt/repo/

	# Putting the schema-files in new folders for optional use
	cp /tmp/openidm/db/postgresql/scripts/openidm.pgsql /docker-entrypoint-initdb.d/02_openidm.sql
	cp /tmp/openidm/db/postgresql/scripts/activiti.postgres.create.engine.sql /docker-entrypoint-initdb.d/03_activiti.postgres.create.engine.sql
	cp /tmp/openidm/db/postgresql/scripts/activiti.postgres.create.history.sql /docker-entrypoint-initdb.d/04_activiti.postgres.create.identity.sql
	cp /tmp/openidm/db/postgresql/scripts/activiti.postgres.create.identity.sql /docker-entrypoint-initdb.d/05_activiti.postgres.create.history.sql
	cp /tmp/openidm/db/postgresql/scripts/audit.pgsql /docker-entrypoint-initdb.d/06_audit.sql
	cp /tmp/openidm/db/postgresql/scripts/default_schema_optimization.pgsql /docker-entrypoint-initdb.d/07_default_schema_optimization.sql

	cp /tmp/openidm/db/postgresql/conf/datasource.jdbc-default.json /opt/repo/openidm/conf/datasource.jdbc-default.json
	cp /tmp/openidm/db/postgresql/conf/repo.jdbc.json /opt/repo/openidm/conf/repo.jdbc.json

	sed 's/localhost/opendj/;s/1389/389/' /opt/repo/openidm/samples/sync-with-ldap-bidirectional/conf/provisioner.openicf-ldap.json > /opt/repo/openidm/conf/provisioner.openicf-ldap.json
	sed -i 's/openidm.host=localhost/openidm.host=iam.example.com/;s/.*openidm.repo.host.*/openidm.repo.host=postgres/;s/.*openidm.repo.port.*/openidm.repo.port=5432/' /opt/openidm/resolver/boot.properties

	rm -rf /opt/openidm/samples
	rm -rf /opt/openidm/db
fi

dir=/opt/repo/openidm-conf
if [ -e "$dir" ]; then
	cp -rv /opt/repo/openidm-conf/* /opt/repo/openidm/
  rm -rf /opt/repo/openidm-conf
fi

file=/opt/repo/bin/staging/opendj.zip
dir=/opt/repo/opendj
if [ -e "$dir" ]; then
	mv /opt/repo/opendj /opt/repo/opendj-conf
	if [ -s "$file" ]; then
		## Unziping and extracting opendj
		unzip -n /opt/repo/bin/staging/opendj.zip -d /opt/repo/
	fi
	cp -rv /opt/repo/opendj-conf/* /opt/repo/opendj/
else
	echo "Could not find folders. Exiting"
	if [ -s "$file" ]; then
		## Unziping and extracting opendj
		unzip -n /opt/repo/bin/staging/opendj.zip -d /opt/repo/
	fi
fi
