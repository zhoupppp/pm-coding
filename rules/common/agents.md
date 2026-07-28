# Agent Orchestration

## Available Agents

Located in `~/.claude/agents/`:

### Engineering
| Agent | Purpose | When to Use |
|-------|---------|-------------|
| planner | Implementation planning | Complex features, refactoring |
| architect | System design | Architectural decisions |
| tdd-guide | Test-driven development | New features, bug fixes |
| code-reviewer | Code review | After writing code |
| security-reviewer | Security analysis | Before commits |
| build-error-resolver | Fix build errors | When build fails |
| e2e-runner | E2E testing | Critical user flows |
| refactor-cleaner | Dead code cleanup | Code maintenance |
| doc-updater | Documentation | Updating docs |
| rust-reviewer | Rust code review | Rust projects |

### Product & Strategy
| Agent | Purpose | When to Use |
|-------|---------|-------------|
| prd-reviewer | PRD quality review | Before PRD finalization |
| user-story-splitter | Break features into stories | Feature decomposition |
| competitive-analyst | Competitive analysis | Market/competitor research |

### Immediate Agent Usage

No user prompt needed:
1. Complex feature requests - Use **planner** agent
2. Code just written/modified - Use **code-reviewer** agent
3. Bug fix or new feature - Use **tdd-guide** agent
4. Architectural decision - Use **architect** agent
5. PRD or product spec written - Use **prd-reviewer** agent
6. Competitor or market analysis needed - Use **competitive-analyst** agent
7. Multi-stage PM workflow - Use `/pm-launch`, `/pm-competitor`, `/pm-ship`, or `/pm-weekly` orchestration commands

## Parallel Task Execution

ALWAYS use parallel Task execution for independent operations:

```markdown
# GOOD: Parallel execution
Launch 3 agents in parallel:
1. Agent 1: Security analysis of auth module
2. Agent 2: Performance review of cache system
3. Agent 3: Type checking of utilities

# BAD: Sequential when unnecessary
First agent 1, then agent 2, then agent 3
```

## Multi-Perspective Analysis

For complex problems, use split role sub-agents:
- Factual reviewer
- Senior engineer
- Security expert
- Consistency reviewer
- Redundancy checker
- Product/PM perspective (when feature has user-facing impact)

## PM Skills Integration

When product/PM tasks arise, agents should consult `rules/common/pm-workflows.md` for the PM workflow and available PM skills in `skills/pm/`. Key capabilities:

- **Product Strategy**: `product-strategy`, `swot-analysis`, `pestle-analysis`, `porters-five-forces`
- **Product Discovery**: `brainstorm-ideas-*`, `identify-assumptions-*`, `opportunity-solution-tree`
- **Market Research**: `competitor-analysis`, `market-sizing`, `user-personas`
- **Execution**: `create-prd`, `user-stories`, `brainstorm-okrs`, `sprint-plan`
- **Orchestration**: `/pm-launch`, `/pm-competitor`, `/pm-ship`, `/pm-weekly`
