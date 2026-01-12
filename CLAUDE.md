# Claude Code Sub-Agents Collection

This project contains **128 specialized Claude Code agents** covering DevOps, SRE, development, security, data engineering, and more.

## Quick Start

### Invoke an Agent Directly
```bash
/agents kubernetes-specialist
/agents terraform-engineer
/agents helm-specialist
```

### Let Claude Auto-Select
Just describe your task - Claude will delegate to the appropriate agent:
- "Deploy to Kubernetes" → `kubernetes-specialist`
- "Write Terraform for AWS" → `terraform-engineer`
- "Create a Helm chart" → `helm-specialist`
- "We have a production incident" → `incident-responder`

---

## Agent Categories

### Infrastructure & DevOps (16 agents)

| Agent | Description |
|-------|-------------|
| `cloud-architect` | Multi-cloud AWS/GCP/Azure architecture design |
| `azure-infra-engineer` | Azure-specific infrastructure engineering |
| `database-administrator` | Database management, performance, replication |
| `deployment-engineer` | Blue-green, canary, rolling deployments |
| `devops-engineer` | CI/CD pipelines and automation |
| `devops-incident-responder` | DevOps-specific incident management |
| `incident-responder` | System incident response and recovery |
| `kubernetes-specialist` | Container orchestration and K8s management |
| `network-engineer` | Network architecture and troubleshooting |
| `platform-engineer` | Internal developer platforms and self-service |
| `security-engineer` | Infrastructure security and DevSecOps |
| `sre-engineer` | Site reliability, SLOs, error budgets |
| `terraform-engineer` | Infrastructure as Code with Terraform |
| `windows-infra-admin` | Windows/Active Directory automation |
| `helm-specialist` | Helm charts and Helmfile management |
| `build-engineer` | Build systems and artifact management |

### Quality & Security (15 agents)

| Agent | Description |
|-------|-------------|
| `chaos-engineer` | Chaos engineering and resilience testing |
| `code-reviewer` | Code review and best practices |
| `test-automator` | Test automation frameworks |
| `qa-expert` | Quality assurance strategies |
| `performance-engineer` | Performance testing and optimization |
| `debugger` | Debugging and troubleshooting |
| `error-detective` | Error analysis and root cause |
| `security-auditor` | Security assessments and audits |
| `compliance-auditor` | Compliance frameworks (SOC2, ISO, PCI) |
| `penetration-tester` | Penetration testing and vulnerability assessment |
| `accessibility-tester` | Accessibility testing (WCAG) |
| `architect-reviewer` | Architecture review and patterns |
| `ad-security-reviewer` | Active Directory security review |
| `powershell-security-hardening` | PowerShell security hardening |
| `refactoring-specialist` | Code refactoring and modernization |

### Core Development (11 agents)

| Agent | Description |
|-------|-------------|
| `backend-developer` | Backend systems and APIs |
| `frontend-developer` | Frontend development |
| `fullstack-developer` | Full-stack applications |
| `api-designer` | API design and architecture |
| `microservices-architect` | Microservices patterns |
| `websocket-engineer` | Real-time communication |
| `ui-designer` | UI/UX design implementation |
| `cli-developer` | Command-line tool development |
| `mobile-developer` | Mobile app development |
| `electron-pro` | Electron desktop apps |
| `game-developer` | Game development |

### Language Specialists (27 agents)

| Agent | Description |
|-------|-------------|
| `python-pro` | Python development |
| `javascript-pro` | JavaScript/Node.js |
| `typescript-pro` | TypeScript development |
| `golang-pro` | Go development |
| `rust-engineer` | Rust development |
| `java-architect` | Java architecture |
| `csharp-developer` | C# development |
| `cpp-pro` | C++ development |
| `php-pro` | PHP development |
| `ruby/rails-expert` | Ruby on Rails |
| `swift-expert` | Swift/iOS development |
| `kotlin-specialist` | Kotlin/Android |
| `elixir-expert` | Elixir/Phoenix |
| `react-specialist` | React.js |
| `vue-expert` | Vue.js |
| `angular-architect` | Angular |
| `nextjs-developer` | Next.js |
| `django-developer` | Django/Python web |
| `laravel-specialist` | Laravel/PHP |
| `spring-boot-engineer` | Spring Boot/Java |
| `flutter-expert` | Flutter mobile |
| `graphql-architect` | GraphQL APIs |
| `sql-pro` | SQL and databases |
| `postgres-pro` | PostgreSQL specialist |
| `wordpress-master` | WordPress development |
| `dotnet-core-expert` | .NET Core |
| `dotnet-framework-4.8-expert` | .NET Framework 4.8 |

### Data & AI (13 agents)

| Agent | Description |
|-------|-------------|
| `data-engineer` | Data pipelines and ETL |
| `data-scientist` | Data science and analytics |
| `data-analyst` | Data analysis and visualization |
| `machine-learning-engineer` | ML model development |
| `ml-engineer` | Machine learning systems |
| `mlops-engineer` | MLOps and model deployment |
| `ai-engineer` | AI systems development |
| `llm-architect` | Large language model architecture |
| `nlp-engineer` | Natural language processing |
| `prompt-engineer` | Prompt engineering |
| `database-optimizer` | Database optimization |
| `search-specialist` | Search systems (Elasticsearch) |
| `data-researcher` | Data research and insights |

### Developer Experience (13 agents)

| Agent | Description |
|-------|-------------|
| `documentation-engineer` | Technical documentation |
| `api-documenter` | API documentation |
| `technical-writer` | Technical writing |
| `dx-optimizer` | Developer experience optimization |
| `git-workflow-manager` | Git workflows and branching |
| `dependency-manager` | Dependency management |
| `tooling-engineer` | Developer tooling |
| `legacy-modernizer` | Legacy system modernization |
| `mcp-developer` | Model Context Protocol development |
| `slack-expert` | Slack integrations |
| `m365-admin` | Microsoft 365 administration |
| `powershell-7-expert` | PowerShell 7 automation |
| `powershell-5.1-expert` | PowerShell 5.1 scripts |

### Specialized Domains (13 agents)

| Agent | Description |
|-------|-------------|
| `blockchain-developer` | Blockchain and Web3 |
| `iot-engineer` | IoT systems |
| `embedded-systems` | Embedded development |
| `fintech-engineer` | Financial technology |
| `payment-integration` | Payment systems |
| `quant-analyst` | Quantitative analysis |
| `mobile-app-developer` | Native mobile apps |
| `powershell-module-architect` | PowerShell module design |
| `powershell-ui-architect` | PowerShell UI development |
| `ux-researcher` | UX research |
| `seo-specialist` | Search engine optimization |
| `content-marketer` | Content marketing |
| `wordpress-master` | WordPress development |

### Business & Product (12 agents)

| Agent | Description |
|-------|-------------|
| `product-manager` | Product management |
| `project-manager` | Project management |
| `business-analyst` | Business analysis |
| `scrum-master` | Agile/Scrum practices |
| `customer-success-manager` | Customer success |
| `sales-engineer` | Technical sales |
| `market-researcher` | Market research |
| `competitive-analyst` | Competitive analysis |
| `trend-analyst` | Trend analysis |
| `risk-manager` | Risk management |
| `legal-advisor` | Legal guidance |
| `research-analyst` | Research and analysis |

### Meta & Orchestration (10 agents)

| Agent | Description |
|-------|-------------|
| `multi-agent-coordinator` | Multi-agent task coordination |
| `workflow-orchestrator` | Workflow orchestration |
| `it-ops-orchestrator` | IT operations orchestration |
| `agent-organizer` | Agent organization and routing |
| `error-coordinator` | Error handling coordination |
| `context-manager` | Context management |
| `task-distributor` | Task distribution |
| `knowledge-synthesizer` | Knowledge synthesis |
| `performance-monitor` | Performance monitoring |

---

## Validation Scripts

Safety hooks are available in `.claude/scripts/`:

| Script | Purpose |
|--------|---------|
| `validate-deployment.sh` | Blocks destructive deployment operations |
| `validate-audit-command.sh` | Enforces read-only for auditing |
| `validate-db-operations.sh` | Blocks write SQL operations |
| `validate-k8s-command.sh` | Prevents dangerous kubectl commands |
| `validate-network-command.sh` | Protects network configurations |
| `validate-security-command.sh` | Controls security tool usage |

---

## Directory Structure

```
.claude/
├── agents/           # 128 agent definitions
│   ├── kubernetes-specialist.md
│   ├── terraform-engineer.md
│   ├── helm-specialist.md
│   ├── cloud-architect.md
│   ├── ... (124 more)
├── scripts/          # Validation hooks
│   ├── validate-deployment.sh
│   ├── validate-audit-command.sh
│   ├── validate-db-operations.sh
│   ├── validate-k8s-command.sh
│   ├── validate-network-command.sh
│   └── validate-security-command.sh
├── settings.json     # Project settings
└── CLAUDE.md         # This documentation
```

---

## Common Workflows

### Cloud-Native Application
1. `cloud-architect` - Design architecture
2. `kubernetes-specialist` - Container orchestration
3. `helm-specialist` - Package management
4. `devops-engineer` - CI/CD pipeline
5. `sre-engineer` - Reliability engineering

### Infrastructure Automation
1. `terraform-engineer` - IaC development
2. `cloud-architect` - Cloud design
3. `security-engineer` - Security hardening
4. `network-engineer` - Network configuration

### Incident Response
1. `incident-responder` - Initial response
2. `sre-engineer` - SLO analysis
3. `database-administrator` - DB troubleshooting
4. `kubernetes-specialist` - K8s debugging

### Platform Engineering
1. `platform-engineer` - Platform design
2. `deployment-engineer` - Deployment automation
3. `devops-engineer` - Tooling
4. `cloud-architect` - Infrastructure

---

## Adding Custom Agents

Create a new `.md` file in `.claude/agents/`:

```markdown
---
name: my-custom-agent
description: Description of when to use this agent
tools: Read, Write, Edit, Bash, Glob, Grep
---

You are a specialist in [domain]...

[Agent instructions and capabilities]
```

---

## Credits

Base agents sourced from [VoltAgent/awesome-claude-code-subagents](https://github.com/VoltAgent/awesome-claude-code-subagents) with additional custom agents (helm-specialist).
