## Unziping and extracting schema-files from openidm to postgres
unzip openidm.zip \
openidm/db/postgresql/ \
openidm/samples/sync-with-ldap-bidirectional/conf/ \
-d /tmp/

# Putting the schema-files in new folders for optional use
cd /opt/repo/

cp /tmp/openidm/db/postgresql/scripts/openidm.pgsql postgres/02_openidm.sql
cp /tmp/openidm/db/postgresql/scripts/activiti.postgres.create.engine.sql postgres/03_activiti.postgres.create.engine.sql
cp /tmp/openidm/db/postgresql/scripts/activiti.postgres.create.history.sql postgres/04_activiti.postgres.create.identity.sql
cp /tmp/openidm/db/postgresql/scripts/activiti.postgres.create.identity.sql postgres/05_activiti.postgres.create.history.sql
cp /tmp/openidm/db/postgresql/scripts/audit.pgsql postgres/06_audit.sql
cp /tmp/openidm/db/postgresql/scripts/default_schema_optimization.pgsql postgres/07_default_schema_optimization.sql

cp /tmp/openidm/db/postgresql/conf/datasource.jdbc-default.json openidm/conf/datasource.jdbc-default.json
cp /tmp/openidm/db/postgresql/conf/repo.jdbc.json openidm/conf/repo.jdbc.json

sed 's/localhost/opendj/;s/1389/389/' openidm/samples/sync-with-ldap-bidirectional/conf/provisioner.openicf-ldap.json > openidm/conf/provisioner.openicf-ldap.json

sed -i 's/localhost:5432/postgres:5432/g' openidm/conf/datasource.jdbc-default.json
