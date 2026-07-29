# PMCoding

> 把 Claude Code 变成你的 AI 产品研发搭档——不只是写代码，而是从调研到上线全程护航。

🌐 **官网**: [zhoupppp.github.io/pm-coding](https://zhoupppp.github.io/pm-coding/)

<p align="center">
  <strong>66 个 PM 专业 Skill · 9 种工作场景 · 18 个规则文件 · 12 个核心 Agent</strong>
</p>

---

## 装上之后有什么不同？

| 你遇到的情况 | 默认 Claude | 装上 PMCoding |
|------------|-----------|--------------|
| 「帮我加个登录功能」 | 直接写代码 | 先问清楚：什么方式、给谁用、要不要验证码 |
| 「帮我分析竞品」 | 给几段文字 | 调竞品分析框架，出 SWOT + 差异化定位 |
| 「帮我把数据库字段删掉」 | 直接删 | ⚠️ 先弹确认：影响范围、回滚方案、等你点头 |
| 「帮我写个 PRD」 | 给通用模板 | 走产品定义流程，从商业模型到用户故事 |
| 「这个 API 好像不存在」 | 编一个假的 | 🔍 暂停验证，标注不确定 |
| 「明天要给投资人 PPT」 | 走普通流程 | 感知时间压力，直接跳到输出 |

---

## 快速开始

### 新用户（2 分钟）

```bash
git clone https://github.com/zhoupppp/pm-coding.git ~/.pm-coding
bash ~/.pm-coding/setup-portable.sh
cp ~/.pm-coding/settings.example.json ~/.claude/settings.json
# 编辑 settings.json 填入你的 API Key，然后重启 Claude Code
```

### 老用户（更新）

```bash
cd ~/.pm-coding && git pull && bash setup-portable.sh
```

### 验证

新会话中输入：`请读取 CLAUDE.md 的第一行标题`
预期输出：`# 生产级 AI 产品研发引擎`

---

## 能力全景

### 🧭 产品定义（5 阶段）
调研 → 分析 → 洞察 → 定义 → 验证。覆盖产品战略、市场研究、数据分析、产品执行、市场进入全流程。

### 🏗️ 产品研发（7 步）
需求澄清 → 规格定义 → 架构设计 → 编码实现 → 测试验收 → 安全审查 → 上线检查。

### 🛡️ 安全封控
6 类高风险操作（删数据库、推生产分支等）先弹确认。AI 幻觉自动检测。

### 📋 规格驱动
写代码前先出 8 维规格卡——确认「要做对的事」再动工。

### 🔧 66 个 PM Skill
从 SWOT、BMC、用户画像到 PRD、OKR、GTM——每个都是独立的专业工具。

[查看完整 Skill 列表 →](docs/skills.md)

---

## 工作场景

| 场景 | 触发示例 | Claude 的流程 |
|------|---------|-------------|
| 🧭 产品定义 | 市场调研、竞品分析、PRD | 5 阶段：调研→分析→洞察→定义→验证 |
| 🏗️ 产品研发 | 功能开发、Bug 修复 | 7 步：澄清→规格→架构→编码→测试→安全→上线 |
| 📊 数据分析 | 数据清洗、Excel、图表 | 5 步：需求→获取→清洗→验证→报告 |
| 📈 工作汇报 | PPT、周报、可视化报告 | 4 步：受众→结构→内容→视觉 |
| 📝 会议纪要 | 客户会议、内部评审 | 3 步：输入→提炼→行动项 |
| 🔍 轻量调研 | 快速了解、技术选型 | 4 步：范围→收集→验证→洞察 |
| 📚 学习研究 | 学新技术、理解原理 | 3 步：问题→解释→应用 |
| ✉️ 文档草拟 | 邮件、通知、方案 | 直接输出 + 脱敏 |
| 💬 快速咨询 | 问定义、快速确认 | 直接回答 + 置信度 |

---

## 安装后结构

```
~/.claude/
├── CLAUDE.md              ← 核心配置（每次会话加载）
├── agents/                ← 12 个核心 Agent（自动加载）
├── rules/common/          ← 18 个规则文件（自动加载）
├── skills/pm/             ← 66 个 PM Skill（PM 工作流调用）
├── templates/             ← 4 个操作模板
├── checklists/            ← 2 个可勾选清单
└── settings.json          ← 你的 API Key 配置
```

---

## 常见问题

<details>
<summary><strong>会让 Claude 变得很啰嗦吗？</strong></summary>
不会。轻量场景走轻量流程。`/quick` 一键跳过。只有代码变更或产品决策才走完整门禁。
</details>

<details>
<summary><strong>和默认 Claude Code 有什么不同？</strong></summary>
默认的 Claude 收到任务直接执行。这套配置会先判断类型、选流程、该澄清的澄清、该确认的确认——目标是「交付正确的产品」，不是「快速出代码」。
</details>

<details>
<summary><strong>能只装部分功能吗？</strong></summary>
可以。规则文件是独立的，删掉不需要的 rules/common/ 文件即可。setup-portable.sh 会告诉你缺了什么。
</details>

<details>
<summary><strong>新电脑怎么迁移？</strong></summary>
克隆仓库 → 运行 setup-portable.sh → 复制 settings.json。2 分钟搞定。
</details>

<details>
<summary><strong>需要付费吗？</strong></summary>
完全免费，MIT 开源。只需要你自己 Claude Code 的 API Key。
</details>

---

<p align="center">
  <sub>MIT License · 128 个文件 · 零外部依赖 · 源于真实产品工作需要</sub>
</p>
