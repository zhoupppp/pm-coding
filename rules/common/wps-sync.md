# WPS 便签云同步规则

> 本规则扩展 [common/hooks.md](../common/hooks.md)，定义 .md 文档自动同步到 WPS 便签云的完整规范。

## 触发条件

当 Claude Code 执行以下操作时，**必须同步到 WPS 便签云**：

- `Write` 工具创建新 `.md` 文件
- `Edit` 工具修改已有 `.md` 文件

## 同步流程

```
Write/Edit .md 文件
  → PostToolUse Hook 自动记录到 ~/.claude/wps-sync-queue.jsonl
    → AI 检测队列中的待同步项
      → 调用 wps-note-cloud MCP 创建/更新笔记
        → 标签自动生成：[项目名] + [文档类型] + cc_HP笔记本
```

## 标签自动推断规则

| 路径关键词 | 项目标签 | 文档类型关键词 | 文档类型标签 |
|-----------|---------|--------------|------------|
| `superIR` / `supir` | `superIR` | `prd`/`需求`/`产品方案` | `PRD` |
| `投资者交流` / `investor` | `投资者交流` | `技术`/`tech`/`架构`/`方案` | `技术方案` |
| `临时客户需求` | `临时客户需求` | `会议`/`纪要`/`meeting` | `会议纪要` |
| `App7.0` | `App7.0` | `测试`/`test`/`验收`/`报告` | `测试报告` |
| `zgrs` | `zgrs` | `分析`/`analysis`/`research`/`洞察` | `分析报告` |
| `.claude/plans` | `Claude配置` | `计划`/`plan`/`规划` | `计划` |
| `.claude/projects` | `Claude记忆` | `规则`/`rule`/`规范`/`config` | `配置规范` |

## 排除规则

以下 `.md` 文件**不同步**到 WPS：
- `CHANGELOG.md`、`README.md`（开源项目元文件）
- `node_modules/` 下的 `.md`
- `.git/` 下的 `.md`
- `package-lock` 相关的 `.md`

## 更新策略

- **新建**：WPS 中创建新笔记，内容 = 文件全文
- **修改**：通过文件名匹配 WPS 中已有笔记，更新内容
- **不删除**：即使本地 .md 被删除，WPS 笔记保留（作为历史存档）

## MCP 调用参考

使用 `wps-note-cloud` MCP 服务器（已配置在 settings.json）：
- URL: `https://ainote.kdocs.cn/mcp-svc/mcp`
- 认证：通过 `X-API-Key` header

## 关联

- [[wps-note-cloud MCP 配置]]
- [[md-sync-to-wps-note-cloud]] memory
- [[common/hooks.md]]
