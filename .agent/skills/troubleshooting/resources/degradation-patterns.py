from typing import Optional, Callable, TypeVar
import logging

logger = logging.getLogger(__name__)
T = TypeVar('T')

def with_fallback(
    primary: Callable[[], T],
    fallback: Callable[[], T],
    log_error: bool = True
) -> T:
    """Try primary function, fall back to fallback on error."""
    try:
        return primary()
    except Exception as e:
        if log_error:
            logger.error(f"Primary function failed: {e}")
        return fallback()

# Usage Example:
# def get_user_profile(user_id: str) -> UserProfile:
#     return with_fallback(
#         primary=lambda: fetch_from_cache(user_id),
#         fallback=lambda: fetch_from_database(user_id)
#     )

def try_multiple(funcs: list[Callable[[], T]], default: T) -> T:
    """Try a list of functions in order, return the first one that succeeds or the default."""
    for func in funcs:
        try:
            return func()
        except Exception:
            continue
    return default
