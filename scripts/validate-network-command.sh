#!/bin/bash
# Validation script for network operations
# Provides safety guardrails for network commands

set -e

# Read input from stdin (JSON with tool_input)
INPUT=$(cat)
COMMAND=$(echo "$INPUT" | jq -r '.tool_input.command // empty')

# If no command, allow
if [ -z "$COMMAND" ]; then
    exit 0
fi

# Block iptables flush (very destructive)
if echo "$COMMAND" | grep -iE 'iptables.*-F|iptables.*--flush' > /dev/null; then
    echo "Blocked: Flushing iptables can disconnect you. Use specific rule deletion." >&2
    exit 2
fi

# Block dangerous network interface commands
if echo "$COMMAND" | grep -iE 'ifconfig.*down|ip\s+link\s+set.*down' > /dev/null; then
    echo "Blocked: Disabling network interfaces can cause connectivity loss." >&2
    exit 2
fi

# Block route deletion without confirmation
if echo "$COMMAND" | grep -iE 'route\s+del|ip\s+route\s+del' > /dev/null; then
    echo "Warning: Route deletion can cause connectivity issues. Verify before executing." >&2
    # Allow but warn
fi

# Block DNS resolver changes
if echo "$COMMAND" | grep -iE '>\s*/etc/resolv.conf|echo.*resolv.conf' > /dev/null; then
    echo "Blocked: Direct modification of resolv.conf not allowed." >&2
    exit 2
fi

# Warn on firewall rule changes
if echo "$COMMAND" | grep -iE 'iptables|firewall-cmd|ufw' > /dev/null; then
    echo "Warning: Firewall changes detected. Ensure you have console access as backup." >&2
    # Allow but warn
fi

# All checks passed
exit 0
