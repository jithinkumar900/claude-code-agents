#!/bin/bash
# Validation script for Kubernetes operations
# Provides safety guardrails for kubectl/helm commands

set -e

# Read input from stdin (JSON with tool_input)
INPUT=$(cat)
COMMAND=$(echo "$INPUT" | jq -r '.tool_input.command // empty')

# If no command, allow
if [ -z "$COMMAND" ]; then
    exit 0
fi

# Block kubectl delete namespace (very destructive)
if echo "$COMMAND" | grep -iE 'kubectl\s+delete\s+namespace' > /dev/null; then
    echo "Blocked: Deleting namespaces is too destructive. Remove resources individually." >&2
    exit 2
fi

# Block kubectl delete all
if echo "$COMMAND" | grep -iE 'kubectl\s+delete\s+all' > /dev/null; then
    echo "Blocked: 'kubectl delete all' is too destructive. Delete resources selectively." >&2
    exit 2
fi

# Block kubectl exec with dangerous commands
if echo "$COMMAND" | grep -iE 'kubectl\s+exec' > /dev/null; then
    DANGEROUS="rm\s+-rf|mkfs|dd\s+if|>\s*/dev|chmod\s+777|curl.*\|.*sh|wget.*\|.*sh"
    if echo "$COMMAND" | grep -iE "$DANGEROUS" > /dev/null; then
        echo "Blocked: Dangerous command detected in kubectl exec." >&2
        exit 2
    fi
fi

# Require confirmation for production context
if echo "$COMMAND" | grep -iE '\-\-context.*(prod|production)' > /dev/null; then
    if echo "$COMMAND" | grep -iE '(delete|scale|rollout\s+undo|patch)' > /dev/null; then
        echo "Warning: Modifying production cluster. Ensure you have proper authorization." >&2
        # Allow but warn
    fi
fi

# Block helm upgrade --force on production
if echo "$COMMAND" | grep -iE 'helm\s+upgrade.*\-\-force' > /dev/null; then
    if echo "$COMMAND" | grep -iE '(prod|production)' > /dev/null; then
        echo "Blocked: --force flag not allowed for production helm upgrades." >&2
        exit 2
    fi
fi

# Block kubectl drain without proper flags
if echo "$COMMAND" | grep -iE 'kubectl\s+drain' > /dev/null; then
    if ! echo "$COMMAND" | grep -iE '\-\-ignore-daemonsets' > /dev/null; then
        echo "Warning: kubectl drain should include --ignore-daemonsets flag." >&2
        # Allow but warn
    fi
fi

# Block cordon without uncordon plan
if echo "$COMMAND" | grep -iE 'kubectl\s+cordon' > /dev/null; then
    echo "Warning: Remember to uncordon the node after maintenance." >&2
    # Allow but warn
fi

# Block edit in interactive mode (not supported)
if echo "$COMMAND" | grep -iE 'kubectl\s+edit' > /dev/null; then
    echo "Blocked: Interactive edit not supported. Use kubectl patch or apply instead." >&2
    exit 2
fi

# All checks passed
exit 0
