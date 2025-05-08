from pymongo import MongoClient
from snowflake.snowpark import Session


def test_connection(session: Session) -> list[dict[str, str]]:
    return session.sql("select 1;").collect()
