# skillz

A combination of UI design skills and references for **building websites**, collected from other public GitHub repos and bundled in one place so they are easy to copy and use. Works with **Claude Code** and **Codex** on Linux, macOS and Windows.

Every skill is an unmodified copy of its original. See [SOURCES.md](SOURCES.md) for the source repo and licence of each one; licence texts are in [licenses/](licenses/).

## Quick start: tell your agent
Paste this into Claude Code or Codex, opened in your project:

> Install the skills from https://github.com/0xcipherdaemon/skillz into this project by following the "Install into a project" section of its README. Then tell me which skills were added.

**For AI agents reading this:** cloning the repo is not enough. Run the install command below from the project root so the skills are copied into `.claude/skills` and `.agents/skills`, then delete the `.skillz` clone. Start a new session afterwards so the skills are picked up. Once installed, use the skills whose descriptions match the task (UI, animation, deploys and so on); you do not need to load all of them.

## Install into a project
Run from the root of the project you want the skills in. You only need `git` plus bash or PowerShell.

**Linux / macOS / Git Bash / WSL**
```
git clone --depth 1 https://github.com/0xcipherdaemon/skillz.git .skillz && bash .skillz/install.sh && rm -rf .skillz
```
**Windows PowerShell** (also PowerShell 7 on any OS)
```
git -c core.longpaths=true clone --depth 1 https://github.com/0xcipherdaemon/skillz.git .skillz; .\.skillz\install.ps1; Remove-Item .skillz -Recurse -Force
```
This copies every skill into **both** `<project>/.claude/skills` (Claude Code) and `<project>/.agents/skills` (Codex). Nothing global is touched, so the skills exist for that project only. Re-running refreshes them.

Options (bash `--target claude|codex|both`, `--only a,b`, `--skip a,b`; PowerShell `-Target`, `-Only`, `-Skip`):
- `--target`: install for one tool only (default `both`)
- `--only` / `--skip`: choose groups, e.g. `--only ui-design,animation`

Add `.claude/skills` and `.agents/skills` to your `.gitignore` if you don't want the skills committed into the project.

## Install as Claude Code plugins
Claude Code only; Codex uses the installer above.
```
/plugin marketplace add 0xcipherdaemon/skillz
/plugin install ui-design@skillz
/plugin install animation@skillz
```
Other groups: `dev`, `vercel`.

## Groups
| Group | Skills |
|---|---|
| `ui-design` (30) | impeccable, ui-ux-pro-max, frontend-design, web-design-guidelines, design-taste-frontend (+v1), high-end-visual-design, minimalist-ui, industrial-brutalist-ui, stitch-design-taste, redesign-existing-projects, gpt-taste, full-output-enforcement, image-to-code, imagegen-frontend-web/mobile, brandkit, brand, design, design-system, banner-design, slides, ui-styling, apple-design, emil-design-eng, break-ui, mobile-native, pick-ui-library, prototype, ask-sonner |
| `animation` (16) | GSAP (core, react, scrolltrigger, timeline, plugins, utils, performance, frameworks), animate, animate-expo, animation-performance, animation-vocabulary, find-animation-opportunities, improve-animations, review-animations, react-view-transitions |
| `dev` (3) | graphify, write-swift, writing-guidelines |
| `vercel` (6) | react-best-practices, composition-patterns, react-native-skills, deploy-to-vercel, vercel-cli-with-tokens, vercel-optimize |

Some skills are written for Claude Code and may not work fully in Codex.

## Adding or updating a skill
Copy the skill folder into `plugins/<group>/skills/`, list it in [SOURCES.md](SOURCES.md) with its licence, and add a new group to `.claude-plugin/marketplace.json` (with a `plugins/<group>/.claude-plugin/plugin.json`) if needed.
