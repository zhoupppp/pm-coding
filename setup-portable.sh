#!/usr/bin/env bash
# ============================================================
# Claude Code 生产级 PM 研发引擎 — 便携部署脚本
# 在新电脑上运行此脚本即可复刻规则体系
# 不含：API Key / MCP / 个人记忆 / Skills / Agents
# ============================================================
set -e

echo "========================================"
echo "  Claude Code 生产级 PM 引擎 — 部署"
echo "========================================"
echo ""

CLAUDE_HOME="${HOME}/.claude"
SOURCE_DIR="$(cd "$(dirname "$0")" && pwd)"
WARNINGS=0
OKS=0

# ---- 1. 创建目录结构 ----
echo "[1/6] 创建目录结构..."
mkdir -p "${CLAUDE_HOME}/rules/common"
mkdir -p "${CLAUDE_HOME}/templates"
mkdir -p "${CLAUDE_HOME}/checklists"
echo "  ✓ 目录就绪"

# ---- 2. 部署 CLAUDE.md ----
echo ""
echo "[2/6] 部署核心配置..."
if [ -f "${SOURCE_DIR}/CLAUDE.md" ]; then
    cp "${SOURCE_DIR}/CLAUDE.md" "${CLAUDE_HOME}/CLAUDE.md"
    echo "  ✓ CLAUDE.md ($(wc -l < "${CLAUDE_HOME}/CLAUDE.md") 行)"
else
    echo "  ✗ CLAUDE.md 未找到！规则体系无法加载"
    WARNINGS=$((WARNINGS + 1))
fi

# ---- 3. 部署 rules/common/ ----
echo ""
echo "[3/6] 部署规则库 (rules/common/)..."
RULES_SRC="${SOURCE_DIR}/rules/common"
if [ -d "$RULES_SRC" ]; then
    cp "$RULES_SRC"/*.md "${CLAUDE_HOME}/rules/common/" 2>/dev/null
    COUNT=$(ls "${CLAUDE_HOME}/rules/common/" | wc -l)
    echo "  ✓ rules/common/ (${COUNT} 个文件)"
else
    echo "  ✗ rules/common/ 未找到！所有流程规则不可用"
    WARNINGS=$((WARNINGS + 1))
fi

# ---- 4. 部署 PM Skills ----
echo ""
echo "[4/6] 部署 PM Skills (skills/pm/)..."
PM_SRC="${SOURCE_DIR}/skills/pm"
if [ -d "$PM_SRC" ] && [ "$(ls "$PM_SRC" 2>/dev/null)" ]; then
    mkdir -p "${CLAUDE_HOME}/skills/pm"
    cp -r "$PM_SRC"/* "${CLAUDE_HOME}/skills/pm/" 2>/dev/null
    PM_COUNT=$(find "${CLAUDE_HOME}/skills/pm" -name "SKILL.md" | wc -l)
    echo "  ✓ skills/pm/ (${PM_COUNT} 个 Skill)"
else
    echo "  ⚠ skills/pm/ 未找到 → PM 工作流退化"
    WARNINGS=$((WARNINGS + 1))
fi

# ---- 5. 部署模板和清单 ----
echo ""
echo "[5/6] 部署模板和清单..."
if [ -d "${SOURCE_DIR}/templates" ]; then
    cp "${SOURCE_DIR}/templates"/*.md "${CLAUDE_HOME}/templates/" 2>/dev/null
    echo "  ✓ templates/ ($(ls "${CLAUDE_HOME}/templates/" | wc -l) 个)"
fi
if [ -d "${SOURCE_DIR}/checklists" ]; then
    cp "${SOURCE_DIR}/checklists"/*.md "${CLAUDE_HOME}/checklists/" 2>/dev/null
    echo "  ✓ checklists/ ($(ls "${CLAUDE_HOME}/checklists/" | wc -l) 个)"
fi

# ---- 5. 依赖检查 ----
echo ""
echo "[6/6] 外部依赖检查..."
echo "----------------------------------------"

# 检查 settings.json（Claude Code 启动必需）
if [ -f "${CLAUDE_HOME}/settings.json" ]; then
    echo "  ✓ settings.json        [硬依赖] API Key 配置"
    OKS=$((OKS + 1))
else
    echo "  ✗ settings.json        [硬依赖] 缺失 → Claude Code 无法启动"
    WARNINGS=$((WARNINGS + 1))
fi

# 检查 PM Skills（pm-workflows.md 引用了 24 个）
PM_SKILL_COUNT=$(find "${CLAUDE_HOME}/skills/pm" -name "SKILL.md" 2>/dev/null | wc -l)
if [ "$PM_SKILL_COUNT" -gt 0 ]; then
    echo "  ✓ PM Skills            [软依赖] 检测到 ${PM_SKILL_COUNT} 个 Skill"
    OKS=$((OKS + 1))
else
    echo "  ⚠ PM Skills            [软依赖] 缺失 → PM 工作流退化，Claude 用通用能力替代"
    WARNINGS=$((WARNINGS + 1))
fi

# 检查 code-reviewer Agent
AGENT_DIRS=("${CLAUDE_HOME}/agents" "${CLAUDE_HOME}/plugins")
FOUND_AGENT=0
for dir in "${AGENT_DIRS[@]}"; do
    if [ -f "${dir}/code-reviewer.md" ]; then
        FOUND_AGENT=1
        break
    fi
done
if [ "$FOUND_AGENT" -eq 1 ]; then
    echo "  ✓ code-reviewer Agent  [软依赖]"
    OKS=$((OKS + 1))
else
    echo "  ⚠ code-reviewer Agent  [软依赖] 缺失 → 代码审查退化，用 Claude 自带能力替代"
    WARNINGS=$((WARNINGS + 1))
fi

# 检查 security-reviewer Agent
FOUND_SEC=0
for dir in "${AGENT_DIRS[@]}"; do
    if [ -f "${dir}/security-reviewer.md" ]; then
        FOUND_SEC=1
        break
    fi
done
if [ "$FOUND_SEC" -eq 1 ]; then
    echo "  ✓ security-reviewer    [软依赖]"
    OKS=$((OKS + 1))
else
    echo "  ⚠ security-reviewer    [软依赖] 缺失 → 安全审查不可用，安全门禁空转"
    WARNINGS=$((WARNINGS + 1))
fi

# 检查 GordenSuperPPTSkill（工作汇报流程引用）
FOUND_PPT=0
for dir in "${CLAUDE_HOME}/skills" "${CLAUDE_HOME}/skills-archive" "${CLAUDE_HOME}/plugins"; do
    if [ -d "${dir}/GordenSuperPPTSkill" ] || [ -f "${dir}/GordenSuperPPTSkill/SKILL.md" ]; then
        FOUND_PPT=1
        break
    fi
done
if [ "$FOUND_PPT" -eq 1 ]; then
    echo "  ✓ GordenSuperPPTSkill  [可选] PPT 生成"
    OKS=$((OKS + 1))
else
    echo "  ⚠ GordenSuperPPTSkill  [可选] 缺失 → PPT 生成降级为 Markdown"
    WARNINGS=$((WARNINGS + 1))
fi

# ---- 结果汇总 ----
echo ""
echo "========================================"
echo "  部署完成"
echo "========================================"
echo ""
echo "规则文件：已部署"
echo "  ~/.claude/CLAUDE.md"
echo "  ~/.claude/rules/common/ (${COUNT} 个)"
echo "  ~/.claude/skills/pm/ (${PM_COUNT} 个 Skill)"
echo "  ~/.claude/templates/"
echo "  ~/.claude/checklists/"
echo ""
echo "依赖状态：${OKS} 就绪 / ${WARNINGS} 缺失"
echo ""

# 分级警告
CRITICAL=0
# settings.json 缺失 = critical
if [ ! -f "${CLAUDE_HOME}/settings.json" ]; then
    CRITICAL=1
fi

if [ "$CRITICAL" -eq 1 ]; then
    echo "🔴 严重：硬依赖缺失，系统无法运行"
    echo "   → 手动配置 ~/.claude/settings.json（API Key）"
fi

if [ "$WARNINGS" -gt 1 ]; then
    echo "🟡 警告：${WARNINGS} 个软依赖缺失，部分功能退化"
    echo "   → PM 工作流 / 代码审查 / PPT 生成降级运行"
    echo "   → 详见 PORTABLE-GUIDE.md 依赖矩阵"
elif [ "$WARNINGS" -eq 1 ]; then
    echo "🟡 提示：1 个外部依赖缺失，功能可运行但有限制"
fi

if [ "$WARNINGS" -eq 0 ]; then
    echo "🟢 全部依赖就绪"
fi

echo ""
echo "验证：启动新会话，输入 '请读取 ~/.claude/CLAUDE.md 的第一行标题'"
echo "预期：'# 生产级 AI 产品研发引擎'"
