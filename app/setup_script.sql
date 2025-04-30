create or alter versioned schema core;

create application role if not exists app_public;
create schema if not exists core;
grant usage on schema core to application role app_public;

create or replace procedure core.hello()
  returns string
  language sql
  execute as owner
  as
  begin
    return 'Hello Snowflake!';
  end;

grant usage on procedure core.hello() to application role app_public;
