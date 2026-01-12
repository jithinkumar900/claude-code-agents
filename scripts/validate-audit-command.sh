#!/bin/bash
# Validation script for infrastructure audit operations
# Enforces read-only access for audit agent

set -e

# Read input from stdin (JSON with tool_input)
INPUT=$(cat)
COMMAND=$(echo "$INPUT" | jq -r '.tool_input.command // empty')

# If no command, allow
if [ -z "$COMMAND" ]; then
    exit 0
fi

# Block all write/delete/modify operations
DESTRUCTIVE_PATTERNS="DELETE|DESTROY|REMOVE|TERMINATE|SHUTDOWN|DISABLE|REVOKE|CREATE|UPDATE|MODIFY|PUT|PATCH|INSERT|DROP|ALTER|TRUNCATE"
if echo "$COMMAND" | grep -iE "\b($DESTRUCTIVE_PATTERNS)\b" > /dev/null; then
    echo "Blocked: Audit agent has read-only access. Cannot perform write/modify operations." >&2
    exit 2
fi

# Block SSH/RDP direct access (should use bastion with logging)
if echo "$COMMAND" | grep -iE '^(ssh|rdp|rds|scp)\s' > /dev/null; then
    echo "Blocked: Direct SSH/RDP access not allowed. Use bastion host with audit logging." >&2
    exit 2
fi

# Block kubectl apply/delete/patch
if echo "$COMMAND" | grep -iE 'kubectl.*(apply|delete|patch|edit|set|scale|rollout)' > /dev/null; then
    echo "Blocked: Audit agent cannot modify Kubernetes resources. Use kubectl get/describe only." >&2
    exit 2
fi

# Block helm install/upgrade/delete
if echo "$COMMAND" | grep -iE 'helm.*(install|upgrade|delete|uninstall|rollback)' > /dev/null; then
    echo "Blocked: Audit agent cannot modify Helm releases. Use helm list/status/get only." >&2
    exit 2
fi

# Block terraform apply/destroy
if echo "$COMMAND" | grep -iE 'terraform.*(apply|destroy|import)' > /dev/null; then
    echo "Blocked: Audit agent cannot modify infrastructure. Use terraform plan/show/state only." >&2
    exit 2
fi

# Block aws resource modification
if echo "$COMMAND" | grep -iE 'aws.*(create|delete|update|put|modify|terminate|start|stop|reboot)' > /dev/null; then
    echo "Blocked: Audit agent cannot modify AWS resources. Use describe/list/get only." >&2
    exit 2
fi

# Block docker run (could be used to modify systems)
if echo "$COMMAND" | grep -iE 'docker\s+run' > /dev/null; then
    # Allow if it's just for scanning
    if ! echo "$COMMAND" | grep -iE '(trivy|grype|snyk|checkov|tfsec|scout)' > /dev/null; then
        echo "Blocked: Audit agent can only run scanning containers." >&2
        exit 2
    fi
fi

# Allow read-only operations
# kubectl: get, describe, logs, top, auth can-i
# helm: list, status, get, history
# aws: describe, list, get
# terraform: plan, show, state list, validate
# docker: images, ps, inspect

exit 0
