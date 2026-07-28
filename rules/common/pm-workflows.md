# PM 产品工作流：从调研到产品定义

> 由全局 CLAUDE.md 引用。产品管理类任务（调研、分析、洞察、产品定义、GTM）自动加载本文件。

## 核心原则

1. **任何阶段都可作为入口**——用户说「只做竞品分析」→ 只走阶段 1；「写 PRD」→ 直接从阶段 4 开始
2. **感知时间压力**——用户提到「明天/今天/马上/紧急」时自动降级为快速模式，跳过非关键阶段
3. **每阶段结束主动提示**——「继续下一阶段 / 输出当前结果 / 进入研发 7 步」
4. **触发词消歧**——≥3 个 Skill 匹配同一 prompt 时列出选项让用户选择，不静默猜测
5. **受众条件触发**——仅在用户未提供受众信息且产出物存在多受众歧义时询问

---

## 阶段 1：调研（Research）— 搞清楚现状

| 场景 | 触发词 | 调用 Skill |
|------|--------|-----------|
| 宏观环境扫描 | 市场分析、行业趋势、PESTLE | `pm-product-strategy:market-scan` |
| 竞品分析 | 竞品、竞争对手、差异化 | `pm-market-research:competitive-analysis` |
| 用户研究 | 用户画像、分群、旅程地图 | `pm-market-research:research-users` |
| 市场容量 | 市场规模、TAM SAM SOM | `pm-market-research:market-sizing` |
| 用户反馈分析 | 评价分析、反馈整理、情感 | `pm-market-research:analyze-feedback` |

**输出**：事实标注来源，判断标注置信度。

## 阶段 2：分析（Analysis）— 从数据中找规律

| 场景 | 触发词 | 调用 Skill |
|------|--------|-----------|
| 同期群分析 | 留存、cohort、回访 | `pm-data-analytics:analyze-cohorts` |
| AB 测试分析 | AB 测试、显著性 | `pm-data-analytics:analyze-test` |
| 需求分类排序 | 功能请求、优先级 | `pm-product-discovery:triage-requests` |
| 数据查询 | 写 SQL、拉报表 | `pm-data-analytics:write-query` |

**输出**：数据结论有来源，推测和确定分开。

## 阶段 3：洞察（Insight）— 从规律中提炼方向

| 场景 | 触发词 | 调用 Skill |
|------|--------|-----------|
| 头脑风暴 | 脑暴、创意、功能点子 | `pm-product-discovery:brainstorm` |
| 机会评估 | OST、机会树 | `pm-product-discovery:opportunity-solution-tree` |
| 用户访谈 | 访谈提纲、访谈整理 | `pm-product-discovery:interview` |
| 指标体系设计 | 北极星、健康指标、看板 | `pm-product-discovery:setup-metrics` |
| 价值主张 | JTBD、价值主张画布 | `pm-product-strategy:value-proposition` |

**输出**：至少 1 个可验证的假设或方向。

## 阶段 4：产品定义（Definition）— 把方向写成方案

| 场景 | 触发词 | 调用 Skill |
|------|--------|-----------|
| 商业模型 | BMC、lean canvas、商业模式 | `pm-product-strategy:business-model` |
| 产品战略 | 战略画布、护城河 | `pm-product-strategy:strategy` |
| PRD 撰写 | PRD、需求文档、产品方案 | `pm-execution:write-prd` |
| 用户故事 | user story、拆分 | `pm-execution:write-stories` |
| OKR 规划 | OKR、季度目标 | `pm-execution:plan-okrs` |

**输出**：PRD 或等效定义文档。完成后提示「可进入阶段 5 验证，或直接进入研发 7 步」。

## 阶段 5：验证（Validation）— 最后一次冷静检查

| 场景 | 触发词 | 调用 Skill |
|------|--------|-----------|
| PRD 对抗性评审 | red team、挑刺、挑战 | `pm-execution:red-team-prd` |
| 事前验尸 | pre-mortem、风险预判 | `pm-execution:pre-mortem` |
| 利益相关者分析 | 干系人、stakeholder | `pm-execution:stakeholder-map` |
| GTM 策略 | 发布计划、GTM、上线 | `pm-go-to-market:plan-launch` |

**门禁**：至少完成 1 项验证，critical 问题已修正。通过后 → 进入研发 7 步流程。

---

## 快速模式

识别以下信号时跳过非关键阶段，直接输出最小可行产物：
- 用户提到「明天/今天/马上/紧急/快」
- 用户用了 `/quick`
- 连续两个阶段用户说「跳过/不用」

快速模式结束后标注「跳过的阶段，需要可以补」。

## 与通用调研的边界

- 轻量调研（了解一个概念、查一个技术选型）→ 走 `🔍 调研洞察` 4 步
- 专业产品调研（SWOT/BMC/用户画像等）→ 走本 PM 工作流

当无法判断时，用 1 个问题澄清：「快速了解（10 分钟级）还是系统性分析（1 小时级）？」
