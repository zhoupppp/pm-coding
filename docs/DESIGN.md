# Design System: PMCoding

## 1. Visual Theme & Atmosphere

A confident, developer-friendly product interface with gallery-airy spacing and fluid spring-physics motion. The atmosphere is clinical yet warm — like a well-lit architecture studio where structure meets approachability. Content reveals through orchestrated cascade animations rather than static information dumps. Every interaction has weight and intention; nothing moves without purpose.

**Density:** 4 — Balanced between airy and information-rich. Sections breathe with generous whitespace, but data-dense areas (skill grids) maintain scannable rhythm.

**Variance:** 6 — Mostly structured with deliberate asymmetric moments. Hero uses split-screen asymmetry. Stats bar uses clean 4-column symmetry. Skill grids use auto-fill fluidity.

**Motion:** 6 — Fluid CSS transitions with spring-physics intent. Scroll-triggered reveals with staggered cascades. Tab switches use directional fade. Hover states provide tactile -2px lift. No gratuitous animation — every motion communicates state change.

---

## 2. Color Palette & Roles

- **Cloud White** (#F8FAFC) — Primary background surface. Soft, slightly cool white that reduces eye strain during long sessions.
- **Pure Surface** (#FFFFFF) — Card fills, code boxes, modal backgrounds. Clean elevation surface.
- **Charcoal Ink** (#0F172A) — Primary headings. Slate-900 depth, never pure black.
- **Slate Body** (#475569) — Body text, descriptions. Slate-600 for relaxed readability.
- **Muted Steel** (#94A3B8) — Secondary labels, metadata, terminal dim text. Slate-400 for hierarchy without competition.
- **Whisper Border** (#E2E8F0) — Card borders, section dividers, 1px structural lines. Slate-200 for subtle definition.
- **Signal Blue** (#2563EB) — Single accent for CTAs, active tab underlines, focus rings, terminal prompts. Blue-600, saturation 75%. Used sparingly for maximum impact.

**Usage rules:**
- Signal Blue never fills large areas — only interactive elements and key highlights
- Whisper Border at 50% opacity (`rgba(226,232,240,0.5)`) for nested card dividers
- Charcoal Ink reserved for h1/h2 only — never for body text
- Muted Steel for all captions, labels, timestamps

---

## 3. Typography Rules

- **Display:** Geist — Track-tight (-0.02em for h1, -0.01em for h2). Weight-driven hierarchy: 800 for h1, 700 for h2, 600 for h3. No size screaming — h1 uses `clamp(2rem, 5vw, 3rem)`.
- **Body:** Geist — Relaxed leading (1.7), max-width 65ch. Slate Body color. No tracking adjustments.
- **Mono:** Geist Mono — For code blocks, terminal output, skill original names, metadata. Size 0.75× body text.
- **Banned:** Inter (premium context), Times New Roman/Georgia/Garamond (generic serifs), system UI fonts for display text.

**Scale:**
- h1: `clamp(2rem, 5vw, 3rem)`, weight 800, tight tracking
- h2: `clamp(1.5rem, 3vw, 2rem)`, weight 700
- h3: `1.125rem`, weight 600, uppercase section labels at 0.75rem
- body: `1rem`, weight 400, 1.7 leading
- caption: `0.75rem`, weight 600, uppercase, 1.5px letter-spacing

---

## 4. Component Stylings

### Buttons
- Flat fill for primary (Signal Blue → darker Blue-700 on hover). Tactile `translateY(-1px)` on hover, `translateY(0)` on active. No outer glow, no neon.
- Ghost/outline for secondary (white fill, Whisper Border, Charcoal Ink text).
- Border-radius: 0.5rem (8px). Padding: 0.675rem 1.5rem.
- Focus ring: 2px Signal Blue offset 2px.

### Cards
- Whisper Border 1px, 0.5rem border-radius. White fill.
- Hover: border-color transitions to Signal Blue at 50%, subtle `translateY(-2px)`, diffused shadow `0 4px 12px rgba(37,99,235,0.08)`.
- No cards for high-density data — use border-top dividers instead.

### Tabs (Skill Categories)
- Button group with transparent background, 2px bottom border (transparent default, Signal Blue active).
- Active state: Charcoal Ink text + Signal Blue bottom border.
- No pill-shaped tabs — clean underline style only.

### Terminal (Hero Visual)
- Off-Black (#0F172a) background, 0.625rem border-radius.
- Three traffic light dots (red/yellow/green) in top-left.
- Geist Mono font, Muted Steel text with Signal Blue prompts and Green-400 commands.
- No blinking cursor, no typing animation — static output feels more trustworthy.

### Modal (Skill Detail)
- Overlay: `rgba(0,0,0,0.4)` backdrop, centered card.
- White fill, 0.75rem border-radius, `0 20px 60px rgba(0,0,0,0.15)` shadow.
- Close button: ghost style, top-right.
- No slide-up animation — simple opacity fade (200ms).

### Code Boxes
- White fill, Whisper Border, Geist Mono font.
- Line-height 1.8 for readability. Comment color: Muted Steel.

---

## 5. Layout Principles

**Grid-first responsive architecture:**
- Contain layouts at 1040px max-width, centered with auto margins.
- Hero: 2-column CSS Grid (1fr 1fr), 70px gap. Collapses to single column below 768px.
- Stats: 4-column Grid. Collapses to 2×2 below 768px.
- Skill Grid: `repeat(auto-fill, minmax(240px, 1fr))`, 10px gap. Single column on mobile.
- Install: 2-column Grid. Single column on mobile.

**Spacing rhythm:**
- Section padding: `clamp(3rem, 8vw, 5rem)` vertical.
- Container padding: 2rem horizontal.
- Component gaps: 12px (tight), 16px (standard), 24px (section internal).
- No arbitrary values — stick to 4/8/12/16/24/32/48/64 progression.

**Asymmetric Hero:**
- Left: text content (60% visual weight).
- Right: terminal visual (40% weight, anchored right).
- Never center-aligned hero text — left-aligned with generous right whitespace.

**No flexbox percentage math:**
- Use CSS Grid `repeat()` and `minmax()` instead of `calc()` hacks.
- No overlapping elements — every element occupies its own clear spatial zone.

---

## 6. Motion & Interaction

**Spring Physics:**
- Default: `stiffness: 100, damping: 20` — premium, weighty feel.
- All interactive elements use CSS `transition` with `cubic-bezier(0.4, 0, 0.2, 1)` as fallback.

**Scroll Reveals:**
- IntersectionObserver triggers `.visible` class addition.
- Opacity 0→1, translateY(20px)→0 over 600ms.
- Staggered delays: hero (0ms), stats (200ms), sections (cascade).

**Tab Switches:**
- Fade-in animation: opacity 0→1, translateY(8px)→0 over 300ms.
- No horizontal slide — directional fade only.

**Hover States:**
- Buttons: `translateY(-1px)` over 200ms.
- Cards: border-color transition + subtle lift.
- Links: color transition from Muted Steel to Charcoal Ink.

**Perpetual Micro-Interactions:**
- None on landing page — static is premium for content sites.
- No parallax, no infinite loops, no ambient motion.

**Performance:**
- Animate exclusively via `transform` and `opacity`.
- No `width`/`height`/`top`/`left` animations.
- `will-change: transform` only on elements that will animate.

---

## 7. Anti-Patterns (Banned)

**Visual:**
- No emojis — use Lucide SVG icons exclusively (24px, stroke-width: 2)
- No Inter font (use Geist)
- No pure black (#000000) — use Charcoal Ink (#0F172a)
- No neon/outer glow shadows on buttons
- No purple or oversaturated accents
- No excessive gradient text on headers
- No custom mouse cursors
- No overlapping elements — clean spatial separation always
- No 3-column equal card layouts (use auto-fill fluid grid)
- No generic stock photos — use terminal/code visual instead
- No centered hero sections for this variance level
- No scroll arrows, bouncing chevrons, "scroll to explore" filler text
- No broken image links — use SVG or CSS-generated visuals only

**Copy:**
- No AI clichés: "Elevate", "Seamless", "Unleash", "Next-Gen", "Revolutionary"
- No fake statistics: "99.99%", "50% faster"
- No generic names: "John Doe", "Acme Corp", "Nexus"
- No placeholder lorem ipsum — all content must be real

**Code:**
- No inline styles — all styles in `<style>` block
- No `!important` — specificity management through class naming
- No CSS frameworks — pure handcrafted CSS
- No JavaScript frameworks — vanilla JS only
- No external dependencies — fully self-contained HTML

---

## 8. Responsive Rules

**Breakpoints:**
- Desktop: > 1024px — full layout
- Tablet: 768px–1024px — fluid scaling, some 2-column layouts become 1-column
- Mobile: < 768px — single column, reduced spacing

**Mobile-First Collapse:**
- Hero: 2-column → 1-column, terminal stacks below text
- Stats: 4-column → 2×2 grid
- Skill Grid: auto-fill → single column
- Install: 2-column → 1-column
- Tabs: horizontal scroll with `overflow-x: auto`

**Typography Scaling:**
- h1: `clamp(2rem, 5vw, 3rem)`
- h2: `clamp(1.5rem, 3vw, 2rem)`
- Body: minimum 1rem (14px), no scaling down

**Touch Targets:**
- All interactive elements minimum 44px tap target
- Tab buttons: padding ensures 44px height
- Buttons: min-height 44px

**Spacing Reduction:**
- Section padding: `clamp(3rem, 8vw, 5rem)` — automatically reduces on small screens
- Container padding: 2rem → 1rem on mobile
- Component gaps: maintain minimum 8px even on mobile
