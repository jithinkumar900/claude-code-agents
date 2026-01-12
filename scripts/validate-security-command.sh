#!/bin/bash
# Validation script for security operations
# Ensures safe security assessment without causing harm

set -e

# Read input from stdin (JSON with tool_input)
INPUT=$(cat)
COMMAND=$(echo "$INPUT" | jq -r '.tool_input.command // empty')

# If no command, allow
if [ -z "$COMMAND" ]; then
    exit 0
fi

# Block actual exploitation tools
EXPLOIT_TOOLS="metasploit|msfconsole|msfvenom|sqlmap.*--dump|hydra.*-l|john.*--wordlist|hashcat"
if echo "$COMMAND" | grep -iE "$EXPLOIT_TOOLS" > /dev/null; then
    echo "Blocked: Active exploitation tools require explicit authorization." >&2
    exit 2
fi

# Block network attacks
if echo "$COMMAND" | grep -iE 'hping.*--flood|slowloris|ddos' > /dev/null; then
    echo "Blocked: Network attack tools not permitted." >&2
    exit 2
fi

# Warn on vulnerability scanners (they should be authorized)
if echo "$COMMAND" | grep -iE 'nmap|nikto|nessus|openvas|nuclei' > /dev/null; then
    echo "Warning: Vulnerability scanning detected. Ensure you have authorization." >&2
    # Allow but warn
fi

# Allow security assessment tools
# trivy, grype, snyk, checkov, tfsec, etc. are allowed

# All checks passed
exit 0
