---
name: troubleshooting-applications
description: Diagnoses and resolves application errors by applying robust error handling patterns, exception hierarchies, and resilient design principles. Use when an application is failing, logs show errors, or when implementing defensive programming strategies.
---

# Troubleshooting & Error Handling

## When to use this skill
- When an application is crashing or behaving unexpectedly.
- When you need to implement resilient error handling in new features.
- When designing APIs that need clear, actionable error responses.
- When debugging production issues using logs or stack traces.

## Workflow: The Troubleshooting Loop
1.  **Reproduce**: Create a minimal test case or script that triggers the failure.
2.  **Isolate**: Use logs and debugging tools to find the exact point of failure.
3.  **Analyze Pattern**: Identify if it's a Recoverable Error (e.g., timeout) or Unrecoverable (e.g., bug).
4.  **Apply Pattern**: Implement the appropriate pattern (Result types, custom exceptions, retries).
5.  **Verify & Degrade**: Ensure the fix works and implement graceful degradation if the error persists.

## Core Error Patterns

### 1. Error Handling Philosophies
- **Exceptions**: Use for truly exceptional, unexpected conditions.
- **Result Types**: Use for expected failures (e.g., validation, not found).
- **Fail Fast**: Validate inputs early to prevent deep-set errors.

### 2. Implementation Strategies
- **Custom Hierarchies**: Create base application error classes to categorize failures.
- **Context Management**: Use `try-finally` or `using` blocks to ensure resource cleanup.
- **Exponential Backoff**: Use retries for transient network/external service failures.
- **Circuit Breakers**: Prevent cascading failures in distributed systems.

## Language-Specific Examples
To keep this skill concise, refer to the following implementations:
- [Python Patterns](examples/python-patterns.py)
- [TypeScript Patterns](examples/typescript-patterns.ts)
- [Rust Patterns](examples/rust-patterns.rs)
- [Go Patterns](examples/go-patterns.go)

## Advanced Patterns & Resources
- [Circuit Breaker Implementation](resources/circuit-breaker.py)
- [Graceful Degradation Logic](resources/degradation-patterns.py)
- [Troubleshooting Checklist](resources/checklist.md)

## Instructions
- **Meaningful Messages**: Every error should explain *what* happened and *how* to fix it.
- **Preserve Context**: Always wrap errors with additional metadata (e.g., `user_id`, `request_id`) while preserving the original stack trace (`raise ... from e` in Python).
- **Log Levels**: Use `ERROR` for actionable issues, `WARN` for potential problems, and `DEBUG` for state-tracking.

