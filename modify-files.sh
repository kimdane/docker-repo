for zipfile in $(ls /opt/repo/bin/zip/*.zip); do
	echo "Unzipping $zipfile"
	unzip -qn $zipfile -d /opt/repo/bin/
done

openidmbin=/opt/repo/bin/openidm
opendjbin=/opt/repo/bin/opendj
openambin=/opt/repo/bin/openam
postgres=/opt/repo/postgres

if [ -e "$openidmbin" ]; then
	## Extracting schema-files from openidm to postgres
	mkdir -p $postgres
	cp $openidmbin/db/postgresql/scripts/openidm.pgsql $postgres/02_openidm.sql
	cp $openidmbin/db/postgresql/scripts/activiti.postgres.create.engine.sql $postgres/03_activiti.postgres.create.engine.sql
	cp $openidmbin/db/postgresql/scripts/activiti.postgres.create.history.sql $postgres/04_activiti.postgres.create.identity.sql
	cp $openidmbin/db/postgresql/scripts/activiti.postgres.create.identity.sql $postgres/05_activiti.postgres.create.history.sql
	cp $openidmbin/db/postgresql/scripts/audit.pgsql $postgres/06_audit.sql
	cp $openidmbin/db/postgresql/scripts/default_schema_optimization.pgsql $postgres/07_default_schema_optimization.sql

	cp -r $postgres /docker-entrypoint-initdb.d
	cp $openidmbin/db/postgresql/conf/datasource.jdbc-default.json $openidmbin/conf/datasource.jdbc-default.json
	cp $openidmbin/db/postgresql/conf/repo.jdbc.json $openidmbin/conf/repo.jdbc.json

	sed 's/localhost/opendj/;s/1389/389/' $openidmbin/samples/sync-with-ldap-bidirectional/conf/provisioner.openicf-ldap.json > $openidmbin/conf/provisioner.openicf-ldap.json
	sed -i 's/openidm.host=localhost/openidm.host=iam.example.com/;s/.*openidm.repo.host.*/openidm.repo.host=postgres/;s/.*openidm.repo.port.*/openidm.repo.port=5432/' $openidmbin/resolver/boot.properties
	rm -rf $openidmbin/samples
	rm -rf $openidmbin/db
	echo "IDM succesfully extracted."
fi

if [ -e "$opendjbin" ]; then
	echo "DS succesfully extracted."
fi

if [ -e "$openambin" ]; then
	for zipfile in $(ls $openambin/*.zip)
		do unzip -qn $zipfile -d $openambin
		echo "SSOConfig succesfully extracted."
	done
	echo "AM succesfully extracted."
fi
