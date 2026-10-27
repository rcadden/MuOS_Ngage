package errors

import (
	"errors"
	"fmt"
)

// User represents a user in the system.
type User struct {
	ID   string
	Name string
}

var db = struct {
	QueryUser func(id string) (*User, error)
}{
	QueryUser: func(id string) (*User, error) {
		return nil, nil
	},
}

// 1. Basic Error Handling
func GetUser(id string) (*User, error) {
	user, err := db.QueryUser(id)
	if err != nil {
		return nil, fmt.Errorf("failed to query user: %w", err)
	}
	if user == nil {
		return nil, errors.New("user not found")
	}
	return user, nil
}

// 2. Custom Error Types
type ValidationError struct {
	Field   string
	Message string
}

func (e *ValidationError) Error() string {
	return fmt.Sprintf("validation failed for %s: %s", e.Field, e.Message)
}

// 3. Sentinel Errors
var (
	ErrNotFound     = errors.New("not found")
	ErrUnauthorized = errors.New("unauthorized")
	ErrInvalidInput = errors.New("invalid input")
)
