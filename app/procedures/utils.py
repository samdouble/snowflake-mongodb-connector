from snowflake.snowpark import Session


def ping(session: Session) -> dict[str, str]:
    return {"status": "ok"}
