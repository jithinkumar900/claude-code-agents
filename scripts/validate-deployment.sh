#!/bin/bash
# Validation script for deployment operations
# Blocks unsafe deployment commands and enforces safety rules

set -e

# Read input from stdin (JSON with tool_input)
INPUT=$(cat)
COMMAND=$(echo "$INPUT" | jq -r '.tool_input.command // empty')

# If no command, allow (might be other tool operations)
if [ -z "$COMMAND" ]; then
    exit 0
fi

# Allow only specific deployment tools
ALLOWED_TOOLS="^(kubectl|helm|docker|aws|gcloud|az|git|curl|wget|jq|yq)"
if ! echo "$COMMAND" | grep -E "$ALLOWED_TOOLS" > /dev/null; then
    echo "Blocked: Only deployment tools allowed (kubectl, helm, docker, aws, gcloud, az, git)" >&2
    exit 2
fi

# Block destructive kubectl operations without explicit confirmation
if echo "$COMMAND" | grep -iE 'kubectl.*delete.*(deployment|service|pod|namespace|pvc|configmap|secret)' > /dev/null; then
    if ! echo "$COMMAND" | grep -iE '\-\-dry-run' > /dev/null; then
        echo "Blocked: Destructive kubectl operations require --dry-run first. Use 'kubectl delete ... --dry-run=client' to preview." >&2
        exit 2
    fi
fi

# Block force push
if echo "$COMMAND" | grep -iE 'git.*push.*(\-f|\-\-force)' > /dev/null; then
    echo "Blocked: Force push is not allowed. Use regular push or --force-with-lease for safety." >&2
    exit 2
fi

# Require explicit context for production kubectl operations
if echo "$COMMAND" | grep -iE 'kubectl.*(prod|production)' > /dev/null; then
    if ! echo "$COMMAND" | grep -iE '(\-\-context|\-n|KUBECONFIG)' > /dev/null; then
        echo "Warning: Production kubectl operations should explicitly set context or namespace." >&2
        # Allow but warn (exit 0)
    fi
fi

# Block helm delete/uninstall without --dry-run
if echo "$COMMAND" | grep -iE 'helm.*(delete|uninstall)' > /dev/null; then
    if ! echo "$COMMAND" | grep -iE '\-\-dry-run' > /dev/null; then
        echo "Blocked: helm delete/uninstall requires --dry-run first." >&2
        exit 2
    fi
fi

# Block dangerous docker operations
if echo "$COMMAND" | grep -iE 'docker.*(rm|rmi|prune|system\s+prune)' > /dev/null; then
    if echo "$COMMAND" | grep -iE '\-\-force|\-f' > /dev/null; then
        echo "Blocked: Forced docker cleanup operations not allowed." >&2
        exit 2
    fi
fi

# Block AWS destructive operations
if echo "$COMMAND" | grep -iE 'aws.*(delete|terminate|destroy)' > /dev/null; then
    echo "Blocked: AWS destructive operations require manual execution." >&2
    exit 2
fi

# All checks passed
exit 0
