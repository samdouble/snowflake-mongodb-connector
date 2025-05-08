from snowflake.snowpark import Session


def ping(_session: Session) -> dict[str, str]:
    return {"status": "ok"}
