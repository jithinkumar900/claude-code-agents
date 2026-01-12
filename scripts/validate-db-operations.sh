#!/bin/bash
# Validation script for database operations
# Enforces read-only access for database queries

set -e

# Read input from stdin (JSON with tool_input)
INPUT=$(cat)
COMMAND=$(echo "$INPUT" | jq -r '.tool_input.command // empty')

# If no command, allow
if [ -z "$COMMAND" ]; then
    exit 0
fi

# Define read-only SQL patterns
READ_PATTERNS="SELECT|EXPLAIN|ANALYZE|SHOW|DESCRIBE|WITH|\\\\d|\\\\l|\\\\dt|\\\\di|\\\\dn"

# Define write SQL patterns to block
WRITE_PATTERNS="INSERT|UPDATE|DELETE|DROP|CREATE|ALTER|TRUNCATE|REPLACE|GRANT|REVOKE|VACUUM|REINDEX"

# Check if command contains database client
if echo "$COMMAND" | grep -iE '(psql|mysql|redis-cli|mongo|sqlite)' > /dev/null; then

    # Block write operations in SQL
    if echo "$COMMAND" | grep -iE "\b($WRITE_PATTERNS)\b" > /dev/null; then
        echo "Blocked: Write operations not allowed. Use migration tools for schema/data changes." >&2
        exit 2
    fi

    # Warn if not using read-only user (unless explicitly configured)
    if echo "$COMMAND" | grep -iE '(psql|mysql)' > /dev/null; then
        if ! echo "$COMMAND" | grep -iE '(readonly|reader|select_only|replica|standby)' > /dev/null; then
            echo "Warning: Consider using a read-only database user for safety." >&2
            # Allow but warn
        fi
    fi
fi

# Block pg_dump without proper flags (could overwrite files)
if echo "$COMMAND" | grep -iE 'pg_dump|mysqldump' > /dev/null; then
    if echo "$COMMAND" | grep -iE '>\s*/' > /dev/null; then
        echo "Blocked: Direct file output not allowed. Use stdout and redirect manually." >&2
        exit 2
    fi
fi

# Block redis write commands
if echo "$COMMAND" | grep -iE 'redis-cli' > /dev/null; then
    REDIS_WRITE="SET|DEL|FLUSHDB|FLUSHALL|EXPIRE|RENAME|MOVE|COPY|LPUSH|RPUSH|SADD|ZADD|HSET|PFADD"
    if echo "$COMMAND" | grep -iE "\b($REDIS_WRITE)\b" > /dev/null; then
        echo "Blocked: Redis write operations not allowed in analysis mode." >&2
        exit 2
    fi
fi

# Block mongo write operations
if echo "$COMMAND" | grep -iE 'mongo' > /dev/null; then
    MONGO_WRITE="insert|update|delete|remove|drop|create|replaceOne|updateOne|deleteOne"
    if echo "$COMMAND" | grep -iE "\b($MONGO_WRITE)\b" > /dev/null; then
        echo "Blocked: MongoDB write operations not allowed." >&2
        exit 2
    fi
fi

# All checks passed
exit 0
