#!/usr/bin/env bash
# ============================================================
# Claude Code 生产级 PM 研发引擎 — 便携部署脚本
# 在新电脑上运行此脚本即可复刻规则体系
# 不含：API Key / MCP / 个人记忆 / Skills / Agents
# ============================================================
set -e

echo "=== Claude Code 生产级配置部署 ==="
echo ""

CLAUDE_HOME="${HOME}/.claude"
SOURCE_DIR="$(cd "$(dirname "$0")" && pwd)"

# ---- 1. 创建目录结构 ----
echo "[1/4] 创建目录..."
mkdir -p "${CLAUDE_HOME}/rules/common"
mkdir -p "${CLAUDE_HOME}/templates"
mkdir -p "${CLAUDE_HOME}/checklists"
mkdir -p "${CLAUDE_HOME}/plans"
mkdir -p "${CLAUDE_HOME}/backups"

# ---- 2. 部署核心宪法 ----
echo "[2/4] 部署 CLAUDE.md..."
if [ -f "${SOURCE_DIR}/CLAUDE.md" ]; then
    cp "${SOURCE_DIR}/CLAUDE.md" "${CLAUDE_HOME}/CLAUDE.md"
    echo "  ✓ CLAUDE.md ($(wc -l < "${CLAUDE_HOME}/CLAUDE.md") 行)"
else
    echo "  ⚠ CLAUDE.md 未找到，请确保与脚本同目录"
fi

# ---- 3. 部署规则库 ----
echo "[3/4] 部署 rules/common/..."
RULES_SRC="${SOURCE_DIR}/rules/common"
if [ -d "$RULES_SRC" ]; then
    cp "$RULES_SRC"/*.md "${CLAUDE_HOME}/rules/common/" 2>/dev/null
    COUNT=$(ls "${CLAUDE_HOME}/rules/common/" | wc -l)
    echo "  ✓ ${COUNT} 个规则文件"
else
    echo "  ⚠ rules/common/ 未找到"
fi

# ---- 4. 部署模板和清单 ----
echo "[4/4] 部署模板和清单..."
if [ -d "${SOURCE_DIR}/templates" ]; then
    cp "${SOURCE_DIR}/templates"/*.md "${CLAUDE_HOME}/templates/" 2>/dev/null
    echo "  ✓ templates/ ($(ls "${CLAUDE_HOME}/templates/" | wc -l) 个)"
fi
if [ -d "${SOURCE_DIR}/checklists" ]; then
    cp "${SOURCE_DIR}/checklists"/*.md "${CLAUDE_HOME}/checklists/" 2>/dev/null
    echo "  ✓ checklists/ ($(ls "${CLAUDE_HOME}/checklists/" | wc -l) 个)"
fi

echo ""
echo "========================================"
echo "  部署完成！"
echo "========================================"
echo ""
echo "已部署："
echo "  ~/.claude/CLAUDE.md          核心宪法"
echo "  ~/.claude/rules/common/      规则库（自动加载）"
echo "  ~/.claude/templates/         操作模板"
echo "  ~/.claude/checklists/        检查清单"
echo ""
echo "你还需要手动配置："
echo "  1. ~/.claude/settings.json   API Key + MCP 服务器"
echo "  2. 项目级 CLAUDE.md          每个项目根目录"
echo "  3. ~/.claude/memory/          项目记忆（可选）"
echo ""
echo "验证部署：启动新会话，输入 '请读取 ~/.claude/CLAUDE.md 的第一行标题'"
echo "预期输出：'# 生产级 AI 产品研发引擎'"
