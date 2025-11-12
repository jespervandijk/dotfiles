---
applyTo: "**"
---

### **OBJECTIVE**

Create three types of branches:

1. One non-breaking branch (patches + minors that pass tests)
2. One major upgrades branch (version-breaking but code-working upgrades)
3. Separate branches for each upgrade/group that fails tests and needs manual fixes

### **PHASE 1: SETUP & EXCLUSIONS**

1. **Check package.json and exclude these packages from ALL upgrades:**

   - Packages without `^` (pinned/exact versions)
   - `@types/node` (never upgrade)
   - `tailwindcss` (stay on major version 3.x)
   - Any package that's a peer dependency of another package not supporting latest versions
   - Any package with peer dependencies that can't be upgraded

2. **Identify special-case packages:**

   - **0.x packages**: Treat ANY version bump as major (breaking)
   - **@tjip/_ or @abn/_ packages**: ALWAYS treat as major (breaking), regardless of semver
   - These will be tested later in the major upgrades phase

3. **Create base non-breaking branch**: `{app-name}-{date}-non-breaking-upgrades`

4. **Preview available upgrades** (excluding restricted packages):
   - `ncu --target patch` - see patch upgrades
   - `ncu --target minor` - see minor upgrades
   - `ncu --target latest` - see all upgrades including majors
   - Note which packages fall under special-case rules

### **PHASE 2: NON-BREAKING UPGRADES (Patches + Minors)**

**Exclude from this phase:**

- Restricted packages (pinned, @types/node, tailwindcss 4.x)
- 0.x packages (treat as major)
- @tjip/_ or @abn/_ packages (treat as major)
- Actual major version bumps

**Apply patches + minors together:**

1. **Batch Test**: Apply ALL patch + minor upgrades at once

   ```bash
   ncu --target minor -u --reject "pinned-pkg,tailwindcss,@tjip/*,@abn/*,0.x-packages"
   npm install
   ```

2. **Run Tests**: Adapt commands based on your package.json scripts
   ```bash
   npm run build && npm run test:unit && npm run eslint
   ```
3. **If ALL PASS**: Commit to non-breaking branch, move to Phase 3
4. **If ANY FAIL**:

   - Revert ALL upgrades
   - Enter **One-by-One Mode**:
     - Test packages individually, ordered by "most likely to fail" (frameworks/core deps first, tooling last)
     - If passes: add to non-breaking branch
     - If fails: note for separate branch creation later

5. **Commit**: `git commit -m "patch + minor upgrades (excl 0.x, @tjip/*, @abn/*, majors)"`

### **PHASE 3: MAJOR UPGRADES (Breaking Versions, Potentially Working Code)**

**Include in this phase:**

- Actual major version bumps (1.x → 2.x)
- 0.x packages (any version bump)
- @tjip/_ and @abn/_ packages (any version bump)

**Create major upgrades branch**: `{app-name}-{date}-major-upgrades`

1. **Batch Test**: Apply ALL major upgrades at once

   ```bash
   ncu --target latest -u --reject "pinned-pkg,tailwindcss"
   # This will upgrade everything including 0.x and @tjip/*/@abn/* packages
   npm install
   ```

2. **Run Tests**: Adapt commands based on your package.json scripts
   ```bash
   npm run build && npm run test:unit && npm run eslint
   ```
3. **If ALL PASS**:
   - Commit to major upgrades branch
   - You're done! All upgrades worked.
   - Move to summary
4. **If ANY FAIL**:

   - Revert ALL upgrades
   - Enter **One-by-One Mode** (CRITICAL - don't skip this):
     - Test packages individually, ordered by "most likely to fail"
     - **If passes: IMMEDIATELY commit to major upgrades branch**
     - If fails: note package name for Phase 4
   - **GOAL: Get as many majors as possible onto the major-upgrades branch**
   - **Only truly broken upgrades should go to Phase 4**

5. **Commit each working major**: After each successful test, immediately commit:
   ```bash
   git add -A && git commit -m "add {package} major upgrade"
   ```
6. **Final commit for majors**: `git commit -m "major upgrades that pass tests"` (if you batched any)

### **PHASE 4: BREAKING UPGRADE HANDLING**

For each upgrade/group that FAILED tests in Phase 3:

1. **Create separate branch**: `{app-name}-{date}-upgrade-{package-or-group-name}`
2. **Group ONLY when peer dependencies force it**:
   - If Package A requires specific version of Package B
   - Test them together as a group
   - NEVER use `--legacy-peer-deps` - always resolve peer conflicts properly
3. **Otherwise: one branch per package** - keep it strict

4. **Document the failure** in commit message:
   ```bash
   git commit -m "upgrade {package} - BREAKING: {describe what failed}"
   ```

### **FINAL DELIVERABLE**

- Branch 1: **non-breaking branch** with patches + minors that passed
- Branch 2: **major upgrades branch** with majors that passed (if any)
- Branch 3+: Individual branches for each breaking upgrade needing manual fixes
- Clear summary of what succeeded vs what needs manual work
