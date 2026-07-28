# Claude Code 生产级 PM 研发引擎 — 便携指南

> 这套配置是将 Claude Code 从「代码助手」升级为「生产级 AI 产品研发引擎」的完整体系。
> 所有规则文件跨机器可移植，不含个人数据。

---

## 快速移植（3 步）

### 到另一台电脑

```bash
# 1. 复制整个 ~/.claude/ 目录（或至少下面这些文件）
scp -r ~/.claude/CLAUDE.md \
       ~/.claude/rules/common/ \
       ~/.claude/templates/ \
       ~/.claude/checklists/ \
       user@new-machine:~/.claude/

# 2. 在新电脑上手动配置 settings.json（API Key + MCP）
# 3. 重启 Claude Code，验证：「请读取 CLAUDE.md 第一行标题」
```

### 给团队成员

```bash
# 方案 A：Git 仓库
git clone your-repo/claude-config ~/.claude-team-config
cp ~/.claude-team-config/CLAUDE.md ~/.claude/
cp -r ~/.claude-team-config/rules/ ~/.claude/

# 方案 B：打包传输
tar -czf claude-config.tar.gz CLAUDE.md rules/ templates/ checklists/
# 传到对方电脑后解压到 ~/.claude/
```

---

## 文件清单（按职责分层）

### 第一层：宪法（每次会话加载）
| 文件 | 行数 | 内容 |
|------|:----:|------|
| `~/.claude/CLAUDE.md` | 151 | 身份、原则、任务识别、需求信号、P0封控、记忆规则、项目自检、模式切换 |

### 第二层：规则库（自动加载）
| 文件 | 内容 |
|------|------|
| `rules/common/dev-7step.md` | 7步流程 + 编码质量三原则 |
| `rules/common/task-workflows.md` | 数据分析/工作汇报/会议纪要/调研/学习 |
| `rules/common/ai-quality.md` | Hallucination检测 + 置信度 + 降级 |
| `rules/common/code-review.md` | 代码审查标准 |
| `rules/common/security.md` | 安全规范 |
| `rules/common/testing.md` | 测试要求（80%覆盖率 + TDD） |
| `rules/common/coding-style.md` | 编码风格 |
| `rules/common/product-acceptance.md` | 产品验收7维度 |
| `rules/common/ui-test-evidence.md` | UI截图留痕 |
| `rules/common/experience.md` | 经验沉淀规则 |
| `rules/common/project-config.md` | 项目自检 + 模板 + 继承规则 |
| `rules/common/agents.md` | Agent调度 |
| `rules/common/development-workflow.md` | 开发流程 |
| `rules/common/git-workflow.md` | Git规范 |
| `rules/common/hooks.md` | Hook系统 |
| `rules/common/patterns.md` | 设计模式 |
| `rules/common/performance.md` | 模型策略（待修正） |

### 第三层：模板
| 文件 | 用途 |
|------|------|
| `templates/spec-card.md` | 规格卡（8维，编码前强制填写） |
| `templates/rollback-plan.md` | 回滚方案 |
| `templates/acceptance-report.md` | 验收报告（8种任务类型适配） |
| `templates/retrospective.md` | 复盘模板（经验沉淀用） |

### 第四层：检查清单
| 文件 | 用途 |
|------|------|
| `checklists/production-gate.md` | 上线前6大门禁 |
| `checklists/code-review.md` | 代码审查逐项勾选 |

---

## 外部依赖矩阵

部署后运行 `bash ~/.claude/setup-portable.sh` 自动检查。以下为每种依赖缺失时的影响：

| 依赖 | 级别 | 引用位置 | 缺失时退化行为 |
|------|:----:|---------|---------------|
| `settings.json`（API Key） | 🔴 硬依赖 | Claude Code 启动 | Claude Code 无法启动，必须手动配置 |
| `rules/common/*.md`（19 个文件） | 🔴 硬依赖 | CLAUDE.md 规则索引 | 已内置在仓库 ✅，部署后自动就绪 |
| PM Skills（24 个） | 🟡 软依赖 | `rules/common/pm-workflows.md` | Claude 用通用能力替代，不走专业 PM 工具。现象：竞品分析质量不稳定，PRD 格式不统一 |
| `code-reviewer` Agent | 🟡 软依赖 | `dev-7step.md` Step 5 | 代码审查退化，用 Claude 自带能力替代。现象：审查不如专用 Agent 细致 |
| `security-reviewer` Agent | 🟡 软依赖 | `dev-7step.md` Step 6 | 安全审查空转。现象：认证/支付代码无人审查 |
| `GordenSuperPPTSkill` | 🟢 可选 | `task-workflows.md` 工作汇报 | PPT 生成降级为 Markdown。现象：需要手动粘到 PPT |
| `supir-mcp-server` | 🟢 可选 | MCP 配置（不在仓库内） | RSC 平台数据查询不可用 |
| `wps-note-cloud` MCP | 🟢 可选 | 个人 MCP 服务 | MD 文档不同步到 WPS 便签 |
| 项目级 `CLAUDE.md` | 🟢 可选 | 项目启动自检 | 项目上下文缺失，Claude 不知道项目技术栈/业务规则 |

---

## 移植时不需要传的文件

| 文件 | 原因 |
|------|------|
| `settings.json` | 含个人API Key和MCP路径 |
| `settings.local.json` | 含个人白名单 |
| `memory/` | 含联系人、项目私密信息 |
| `skills/` | 90个未清理，对方可能不需要 |
| `agents/` | 45个未评估，大部分对方可能不需要 |
| `commands/` | 66个，和Agent重叠 |
| `backups/` | 历史备份 |

---

## 新机器上的手动配置清单

部署规则文件后，在新机器上还需：

1. **settings.json** — 配置 API Key + MCP 服务器
2. **项目级 CLAUDE.md** — 每个项目根目录创建（或用项目自检自动生成）
3. **项目 memory/** — 如有跨机器需求，手动复制项目记忆文件
4. **Skills** — 只复制你实际高频使用的 5-10 个

---

## 架构决策记录

### ADR-001：为什么 CLAUDE.md 只有 151 行而不是 400+
- **决策**：将详细流程拆入 rules/common/，CLAUDE.md 保留触发词和原则
- **原因**：Claude Code 自动加载 rules/ 目录所有文件。CLAUDE.md 只需告诉 Claude「有哪些规则可用」，详细内容在 rules/ 中随用随取
- **效果**：Token 消耗降低 63%

### ADR-002：为什么用 rules/ 而不是 @引用
- **决策**：详细规则放入 rules/common/ 自动加载，而非在 CLAUDE.md 中用 @ 手动引用
- **原因**：@引用不会自动加载；rules/ 目录下的 .md 文件由 Claude Code 自动注入上下文
- **效果**：不存在「规则引用断裂，Claude 忘记规则」的风险

### ADR-003：为什么项目 CLAUDE.md 只需要 40-60 行
- **决策**：项目级配置只写差异（技术栈/业务规则/全局例外）
- **原因**：遵循「只写 Claude 无法从代码中自动发现的内容」原则
- **效果**：新项目 5 分钟完成配置，AI 产品经理不需要维护 20+ 个文件

### ADR-004：记忆规则分类
- **决策**：工作联系人（姓名/手机/邮箱）→ 可记；凭据（API Key/Token）→ settings.json；纯PII（身份证/银行卡）→ 不记
- **原因**：联系人信息是日常工作必需的客户档案，不是隐私负担
- **风险**：明文存储仍有泄露风险，需确保 memory/ 不被提交到 Git

---

## 快速验证

部署后在新会话中发送以下任一条：

```
# 验证身份
请读取 CLAUDE.md 第一行标题

# 验证任务识别
帮我写一个周报

# 验证P0封控
帮我把数据库里的 users 表删掉

# 验证需求澄清
帮我优化一下性能
```

预期行为：
- 标题：「生产级 AI 产品研发引擎」
- 周报：走 4 步汇报流程（先确认受众，不直接输出内容）
- 删表：触发 P0 确认模板，不直接执行
- 优化性能：追问具体指标，不直接写代码

---

**最后更新**：2026-07-27
**版本**：v1.0
