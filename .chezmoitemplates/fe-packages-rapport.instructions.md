---
applyTo: "**"
---

### OBJECTIVE

Generate a comprehensive audit of all available package upgrades for a specific list of frontend applications. The final output is a single markdown report saved in the workspace and pasted in the chat; no next-steps or branch instructions should be included in the deliverable.

### PHASE 1: SETUP & RULES

1. Identify Target Applications: The audit will be performed ONLY on the following application folders (relative to the workspace root):

   - `adviesmodule-ui`
   - `adviesmodule-ui-wrapper`
   - `haas-ui`
   - `haas-admin-ui`
   - `klantprofiel-ui`
   - `maximale-hypotheek-ui`
   - `medewerkers-ui`
   - `risicomodule-ui`
   - `risicomodule-ui-wrapper`
   - `verhuur-hypotheek-ui`

2. Define Audit & Filtering Rules (apply exactly):
   - Pinned packages (exact version, no `^` or `~`) must be excluded from the report.
   - `tailwindcss`: only report upgrades that remain inside major `3.x`; exclude any suggestion to upgrade to `4.x` or higher.
   - `@types/node`: only report minor and patch upgrades; exclude any major version upgrade.
   - Treat packages on `0.x` as breaking (see Phase 2 grouping below).

### PHASE 2: AUDIT & CATEGORIZATION

1. Scan Each Application: from the app folder run `npx npm-check-updates --target latest` and collect the console output.

   ```powershell
   # from the application's folder
   npx npm-check-updates --target latest
   ```

2. Process and Filter: apply the Phase 1 rules to the raw `ncu` output. Remove pinned packages, remove `tailwindcss` 3→4 suggestions, and ignore `@types/node` major bumps.

3. Categorize upgrades into FOUR groups (every non-excluded package must be placed in exactly one group):

   - Patch — same major & minor; patch number increases (x.y.z → x.y.z').
   - Minor — same major; minor number increases (x.y.z → x.(y+1).0 or similar).
   - Major — major number increases (x.y.z → (x+1).0.0 or similar).
   - 0-major — any change where the current installed version is `0.x.y` (any bump is considered breaking).

   After assigning packages into the four groups, remove any package whose name begins with `@tjip/` or `@abn/` from those groups and place it instead into the separate group: **TJIP / ABN (excluded)**. That group should list every `@tjip/*` and `@abn/*` upgrade found for the application.

4. Special-case notes:
   - If an `ncu` line shows a range or pre-release, classify according to the semantic version change rules above.
   - If a package's current version is pinned in `package.json`, do not include it anywhere in the report.

### FINAL DELIVERABLE (required)

- Produce one consolidated markdown file saved to `ncu-results/fe-packages-rapport.md` in the workspace. The file must contain the full report.
- Also paste the same markdown content into the chat when finished.
- The report must contain, per application, four sections: `Patch`, `Minor`, `Major`, `0-major`, and a separate `TJIP / ABN (excluded)` list.
- Do not include any next-steps, branch creation instructions, or commands in the final deliverable — the markdown report is the final artifact.

### RUNBOOK / COMMANDS (optional helper)

To scan all apps from the workspace root (PowerShell):

```powershell
$apps = @( 'adviesmodule-ui','adviesmodule-ui-wrapper','haas-ui','haas-admin-ui','klantprofiel-ui','maximale-hypotheek-ui','medewerkers-ui','risicomodule-ui','risicomodule-ui-wrapper','verhuur-hypotheek-ui' )
foreach($app in $apps){
  $p = Join-Path $PWD.Path $app
  if(Test-Path $p){
    Push-Location $p
    Write-Host "=== $app ==="
    npx -y npm-check-updates --target latest
    Pop-Location
  } else { Write-Host "MISSING: $p" }
}
```
