create or alter versioned schema core_code_public;

create or replace procedure core_code_public.create_connection(connection_name string, connection_string string, database string, collection string)
  returns variant
  language python
  runtime_version = '3.11'
  packages = ('snowflake-snowpark-python')
  imports = (
    '/libs/dnspython-2.7.0-py3-none-any.zip',
    '/libs/pymongo-4.12.1-cp311-cp311-manylinux_2_17_x86_64.manylinux2014_x86_64.zip',
    '/procedures/connection.py'
  )
  handler = 'connection.create_connection';

create or replace procedure core_code_public.test_connection(connection_name string)
  returns string
  language python
  runtime_version = 3.11
  packages = ('snowflake-snowpark-python')
  imports = (
    '/libs/dnspython-2.7.0-py3-none-any.zip',
    '/libs/pymongo-4.12.1-cp311-cp311-manylinux_2_17_x86_64.manylinux2014_x86_64.zip',
    '/procedures/connection.py'
  )
  handler = 'connection.test_connection';

create or replace procedure core_code_public.ping()
  returns variant
  language python
  runtime_version = '3.11'
  packages = ('snowflake-snowpark-python')
  imports = ('/procedures/utils.py')
  handler = 'utils.ping';

grant usage on schema core_code_public to application role app_public;
grant usage on all procedures in schema core_code_public to application role app_public;
