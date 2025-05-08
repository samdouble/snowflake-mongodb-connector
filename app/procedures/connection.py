# import dns.resolver
import _snowflake
from pymongo import MongoClient
from snowflake.snowpark import Session


def create_connection(
    session: Session,
    connection_name: str,
    connection_string: str,
    database: str,
    collection: str,
) -> list[dict[str, str]]:
    #dns.resolver.default_resolver = dns.resolver.Resolver(configure=False)
    #dns.resolver.default_resolver.nameservers = ['8.8.8.8']

    session.sql("""
        create or replace network rule core_data.network_rule_connection1
        mode = egress
        type = host_port
        value_list = ('mongodb.net');
    """).collect()
    session.sql(f"""
        create or replace secret core_data.secret_connection1
        type = generic_string
        secret_string = '{connection_string}';
    """).collect()
    session.sql("""
        create or replace external access integration eai_connection1
        allowed_network_rules = (core_data.network_rule_connection1)
        allowed_authentication_secrets = (all)
        enabled = true;
    """).collect()
    session.sql("""
        alter procedure core_code_public.create_connection(string, string, string, string) set
        secrets = ('cred' = core_data.secret_connection1)
        external_access_integrations = (eai_connection1);
    """).collect()
    session.sql("""
        alter procedure core_code_public.test_connection(string) set
        secrets = ('cred' = core_data.secret_connection1)
        external_access_integrations = (eai_connection1);
    """).collect()

    client = MongoClient(connection_string)
    db = client[database]
    collection = db[collection]
    return collection.find_one()

def test_connection(session: Session, connection_name: str) -> str:
    # Retrieve the access token from Snowflake secret
    access_token = _snowflake.get_generic_secret_string('cred')
    return access_token
