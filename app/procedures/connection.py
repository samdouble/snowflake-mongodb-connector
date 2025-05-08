from pymongo import MongoClient
from snowflake.snowpark import Session


def test_connection(session: Session, connection_string: str, database: str, collection: str) -> list[dict[str, str]]:
    client = MongoClient(connection_string)
    db = client[database]
    collection = db[collection]
    return collection.find_one()
