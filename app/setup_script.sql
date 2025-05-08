create or alter versioned schema core;

create application role if not exists app_public;
create schema if not exists core;
grant usage on schema core to application role app_public;

create or replace procedure core.test_connection(connection_string string, database string, collection string)
  returns variant
  language python
  runtime_version = '3.11'
  packages = ('snowflake-snowpark-python')
  imports = ('/libs/pymongo-4.12.1-cp311-cp311-manylinux_2_17_x86_64.manylinux2014_x86_64.zip', '/procedures/connection.py')
  handler = 'connection.test_connection';
grant usage on procedure core.test_connection(string, string, string) to application role app_public;

create or replace procedure core.ping()
  returns variant
  language python
  runtime_version = '3.11'
  packages = ('snowflake-snowpark-python')
  imports = ('/procedures/utils.py')
  handler = 'utils.ping';
grant usage on procedure core.ping() to application role app_public;
