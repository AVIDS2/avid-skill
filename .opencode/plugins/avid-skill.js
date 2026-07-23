/**
 * AVID Skill plugin for OpenCode.ai
 *
 * Injects using-avid bootstrap context and auto-registers the skills directory.
 * Pattern mirrors obra/superpowers OpenCode plugin.
 */

import path from 'path';
import fs from 'fs';
import os from 'os';
import { fileURLToPath } from 'url';

const __dirname = path.dirname(fileURLToPath(import.meta.url));

const extractAndStripFrontmatter = (content) => {
  const match = content.match(/^---\n([\s\S]*?)\n---\n([\s\S]*)$/);
  if (!match) return { frontmatter: {}, content };

  const frontmatterStr = match[1];
  const body = match[2];
  const frontmatter = {};

  for (const line of frontmatterStr.split('\n')) {
    const colonIdx = line.indexOf(':');
    if (colonIdx > 0) {
      const key = line.slice(0, colonIdx).trim();
      const value = line.slice(colonIdx + 1).trim().replace(/^["']|["']$/g, '');
      frontmatter[key] = value;
    }
  }

  return { frontmatter, content: body };
};

const normalizePath = (p, homeDir) => {
  if (!p || typeof p !== 'string') return null;
  let normalized = p.trim();
  if (!normalized) return null;
  if (normalized.startsWith('~/')) {
    normalized = path.join(homeDir, normalized.slice(2));
  } else if (normalized === '~') {
    normalized = homeDir;
  }
  return path.resolve(normalized);
};

let _bootstrapCache = undefined;

const resolveAvidSkillsDir = (homeDir, configDir) => {
  const candidates = [
    process.env.AVID_SKILLS_DIR,
    path.resolve(__dirname, '../../skills'),
    path.join(configDir, 'skills', 'avid-skill'),
    path.join(homeDir, '.config', 'opencode', 'skills', 'avid-skill'),
  ].filter(Boolean);

  for (const c of candidates) {
    const p = normalizePath(c, homeDir) || c;
    if (p && fs.existsSync(path.join(p, 'using-avid', 'SKILL.md'))) return p;
  }
  return path.resolve(__dirname, '../../skills');
};

export const AvidSkillPlugin = async ({ client, directory }) => {
  const homeDir = os.homedir();
  const envConfigDir = normalizePath(process.env.OPENCODE_CONFIG_DIR, homeDir);
  const configDir = envConfigDir || path.join(homeDir, '.config/opencode');
  const avidSkillsDir = resolveAvidSkillsDir(homeDir, configDir);

  const getBootstrapContent = () => {
    if (_bootstrapCache !== undefined) return _bootstrapCache;

    const skillPath = path.join(avidSkillsDir, 'using-avid', 'SKILL.md');
    if (!fs.existsSync(skillPath)) {
      _bootstrapCache = null;
      return null;
    }

    const fullContent = fs.readFileSync(skillPath, 'utf8');
    const { content } = extractAndStripFrontmatter(fullContent);

    const toolMapping = `**Tool Mapping for OpenCode:**
When skills reference tools you don't have, substitute OpenCode equivalents:
- \`TodoWrite\` / TaskCreate → \`todowrite\`
- \`Task\` / Agent tool with subagents → OpenCode subagent system (@mention)
- \`Skill\` tool → OpenCode's native \`skill\` tool
- \`Read\`, \`Write\`, \`Edit\`, \`Bash\` → your native tools
- Tavily / Context7 / Playwright MCP → use if configured in opencode.json

Use OpenCode's native \`skill\` tool to list and load AVID skills (e.g. product-bootstrap).`;

    _bootstrapCache = `<IMPORTANT>
You have AVID skills loaded (avid-skill plugin).

**using-avid is included below (already loaded — do not re-load it).**

${content}

${toolMapping}

AVID defaults are advisory and scene-dependent:
1. New product/vertical → prefer product-bootstrap when research is missing.
2. Self-build → prefer research-before-build.
3. Missing tool → prefer install-dont-reinvent.
4. Agent runtime → agent-framework-choice by scene (web FE/BE: do not default to Pi SDK; local harness: Pi/pi-ai/embed Pi; durable workflow: LangGraph).
5. Implementation → ponytail; Superpowers only on Claude Code when helpful.
Skip/adapt with a one-line reason when a default is a bad fit. Never force an invalid runtime.
</IMPORTANT>`;

    return _bootstrapCache;
  };

  return {
    config: async (config) => {
      config.skills = config.skills || {};
      config.skills.paths = config.skills.paths || [];
      if (!config.skills.paths.includes(avidSkillsDir)) {
        config.skills.paths.push(avidSkillsDir);
      }
    },

    'experimental.chat.messages.transform': async (_input, output) => {
      const bootstrap = getBootstrapContent();
      if (!bootstrap || !output.messages.length) return;
      const firstUser = output.messages.find((m) => m.info.role === 'user');
      if (!firstUser || !firstUser.parts.length) return;
      if (firstUser.parts.some((p) => p.type === 'text' && p.text.includes('EXTREMELY_IMPORTANT'))) return;

      const ref = firstUser.parts[0];
      firstUser.parts.unshift({ ...ref, type: 'text', text: bootstrap });
    },
  };
};

// OpenCode discovers the default export or named plugin export depending on version.
export default AvidSkillPlugin;
