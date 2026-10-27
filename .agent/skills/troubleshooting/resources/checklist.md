# Error Handling Review Checklist

## Fundamentals
- [ ] **Fail Fast**: Are inputs validated at the entry point of the function?
- [ ] **No Silencing**: Are there any empty `except` or `catch` blocks?
- [ ] **Meaningful Messages**: Does the error message describe both *what* happened and *how* to potentially fix it?
- [ ] **Correct Log Level**: Is the error logged at the appropriate level (ERROR vs WARN)?

## Resilience
- [ ] **Resource Cleanup**: Are files, sockets, and DB connections closed in a `finally` block or context manager?
- [ ] **Retries**: For external network calls, is there a retry mechanism with exponential backoff?
- [ ] **Circuit Breakers**: For high-traffic external dependencies, is there a circuit breaker to prevent cascading failure?
- [ ] **Graceful Degradation**: If a non-critical feature fails, does the app still provide a fallback or partial functionality?

## Context & Debugging
- [ ] **Preserve Stack Trace**: When re-throwing, is the original exception preserved (e.g., `raise ... from e`)?
- [ ] **Metadata**: Are relevant IDs (user_id, request_id, resource_id) included in the error context?
- [ ] **Type Safety**: Are custom exception classes used instead of generic `Error` or `Exception`?

## Documentation
- [ ] **API Documentation**: Does the API documentation list possible error codes and their meanings?
- [ ] **User Communication**: Is the error message shown to the user sanitized (no internal stack traces or DB details)?

