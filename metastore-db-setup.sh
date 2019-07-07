#!/bin/bash
set -e

HIVE_VERSION=2.3.0

# Get the schema
wget https://github.com/apache/hive/blob/master/metastore/scripts/upgrade/postgres/hive-txn-schema-$HIVE_VERSION.postgres.sql

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" <<-EOSQL
  CREATE USER hive WITH PASSWORD 'hive';
  CREATE DATABASE metastore;
  GRANT ALL PRIVILEGES ON DATABASE metastore TO hive;
  \c metastore
  \i hive-schema-$HIVE_VERSION.postgres.sql
  \i hive-txn-schema-$HIVE_VERSION.postgres.sql
  \pset tuples_only
  \o /tmp/grant-privs
SELECT 'GRANT SELECT,INSERT,UPDATE,DELETE ON "' || schemaname || '"."' || tablename || '" TO hive ;'
FROM pg_tables
WHERE tableowner = CURRENT_USER and schemaname = 'public';
  \o
  \i /tmp/grant-privs
EOSQL
