# UI Test Evidence — 功能测试截图留痕规范

> This file defines the mandatory workflow for UI/functional testing with screenshot evidence.

## 🔴 Iron Rules

- **ALWAYS** create a `.test-evidence/` directory at project root for all test evidence
- **ALWAYS** take screenshots at each key step of UI testing (not just the final result)
- **ALWAYS** generate an HTML report summarizing all steps, screenshots, and pass/fail results
- **NEVER** commit `.test-evidence/` to git — it must be in `.gitignore` or global gitignore
- **NEVER** store test evidence in `docs/`, `src/`, or any tracked directory
- **NEVER** skip screenshot capture — every UI test must have visual evidence

## 📋 Trigger Conditions

This rule activates when any of the following keywords appear in the task:
- UI 测试、功能测试、界面测试、验收测试
- 截图、留痕、测试报告、验收报告
- acceptance testing, UI testing, visual testing
- E2E 测试涉及界面验证

## 📁 Directory Structure

```
project-root/
├── .test-evidence/                    # Gitignored, never committed
│   └── {YYYY-MM-DD}_{feature-name}/   # One folder per test session
│       ├── screenshots/
│       │   ├── 01-step-name.png
│       │   ├── 02-step-name.png
│       │   └── ...
│       └── report.html                # Self-contained HTML report
```

## 📸 Screenshot Naming Convention

```
{序号}-{步骤描述}.png

Examples:
01-login-page-loaded.png
02-fill-username-password.png
03-click-submit-button.png
04-dashboard-displayed.png
05-error-state-empty-form.png
```

## 📝 Minimum Evidence Requirements

Every UI test session MUST capture:

| Category | Minimum Screenshots |
|----------|-------------------|
| Page load / idle state | 1 |
| Key interaction steps | 1 per step |
| Loading state (if applicable) | 1 |
| Success result | 1 |
| Error state (if applicable) | 1 |
| Empty state (if applicable) | 1 |

## 📄 HTML Report Template

The report must be a **self-contained HTML file** (no external dependencies) with:

1. **Header**: Test name, date, project, tester (Claude / manual)
2. **Summary table**: Total steps, passed, failed, skipped
3. **Step-by-step detail**: Each step with:
   - Step number and description
   - Screenshot (embedded as base64 or relative path)
   - Expected behavior vs actual behavior
   - Pass/Fail badge
4. **Footer**: Test duration, environment info

## 🔧 Playwright Integration

For automated tests, add screenshot capture in test code:

```typescript
import { test, expect } from '@playwright/test';

test('feature flow', async ({ page }) => {
  const evidenceDir = '.test-evidence/2026-05-29_feature-name/screenshots';

  await page.goto('/target-page');
  await page.screenshot({ path: `${evidenceDir}/01-page-loaded.png`, fullPage: true });

  await page.fill('[data-testid="input"]', 'test data');
  await page.screenshot({ path: `${evidenceDir}/02-filled-form.png` });

  await page.click('[data-testid="submit"]');
  await page.screenshot({ path: `${evidenceDir}/03-result.png` });

  await expect(page.locator('[data-testid="success"]')).toBeVisible();
});
```

## 🔄 Workflow

```
1. Create .test-evidence/{date}_{feature}/ directory
2. Start testing (manual or automated)
3. Screenshot each key step → screenshots/
4. Record expected vs actual for each step
5. Generate report.html with all evidence embedded
6. Open report.html for user review
7. NEVER commit .test-evidence/ to git
```

## ✅ Integration with Existing Rules

- Follows `common/testing.md` coverage requirements
- HTML report follows user's output convention (HTML format in `docs/对话输出报告/` is for docs; `.test-evidence/` is for test artifacts)
- Report generation does NOT require user confirmation (technical task)
