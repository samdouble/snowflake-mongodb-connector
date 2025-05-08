from snowflake.snowpark import Session

from app.procedures.utils import ping


def test_ping():
    session = Session.builder.config("local_testing", True).create()
    assert ping(session) == {"status": "ok"}
