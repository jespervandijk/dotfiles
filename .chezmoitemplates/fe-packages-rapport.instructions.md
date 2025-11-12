---
applyTo: "**"
---

# Frontend packages rapport - instructions (repository copy)

Objective

Generate a complete, reproducible audit of available package upgrades for a fixed list of frontend applications. The final output must be a single markdown file saved in the repository (`ncu-results/fe-packages-rapport.md`) and pasted in the chat. No next-steps, branch instructions, or commands must appear in the final deliverable.

Scope (target applications)

Only scan these app folders relative to the repository root:

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

Audit & filtering rules (apply exactly)

1. Pinned packages (exact version, no `^` or `~`) must be excluded from the report.
2. `tailwindcss`: only report upgrades that remain inside major `3.x`; exclude any suggestion to upgrade to `4.x` or higher.
3. `@types/node`: only report minor and patch upgrades; exclude any major version upgrade.
4. ALWAYS list ALL possible package upgrades reported by `npx npm-check-updates --target latest` for each app, except those explicitly excluded by rules 1-3. "ALL possible" means every package line `ncu` outputs (current → latest) after applying the excludes; do not summarize or replace multiple entries with generic placeholders like "tooling majors".
5. Treat packages on `0.x` as breaking (see Phase 2 grouping below).

Phase 2: Scan, filter, and categorize

1. Scan each app (PowerShell):

```powershell
# run from each app folder
npx -y npm-check-updates --target latest
```

2. Apply filtering rules (Phase 1). Remove pinned packages and excluded tailwind/@types/node major bumps.

3. Categorize every remaining package into exactly one of the FOUR groups:

- Patch — same major & minor; patch number increases (x.y.z → x.y.z').
- Minor — same major; minor number increases (x.y.z → x.(y+1).0 or similar).
- Major — major number increases (x.y.z → (x+1).0.0 or similar).
- 0-major — any change where the current installed version is `0.x.y` (any bump is considered breaking).

Important: After assigning packages into the four groups, remove any package whose name begins with `@tjip/` or `@abn/` from those groups and place it instead into the separate group **TJIP / ABN (excluded)**.

Special cases and clarifications

- If `ncu` shows a range, caret, tilde or pre-release in the recommended version, classify according to the semantic difference between the current installed version and the highest semver in the range.
- When a package is listed in `ncu` output but the package is pinned in `package.json` (no ^ or ~), do not include it in the report.
- The report must list packages explicitly; no high-level placeholders or bullet summaries for multiple packages.

Final deliverable

- Save the report to `ncu-results/fe-packages-rapport.md` and paste the same markdown into the chat when finished.
- The report must include, per application, the four groups: `Patch`, `Minor`, `Major`, `0-major`, and a `TJIP / ABN (excluded)` list. Each list must contain every package upgrade (package name, current → suggested) after filtering.
- Do not include next steps, branch names, or commands in the final markdown.

Runbook (optional)

A PowerShell snippet to scan all apps from the repository root:

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
