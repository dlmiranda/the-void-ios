# The Void MVP QA Test Script

**Build:** __________  
**Device (iPhone model + iOS):** __________  
**Tester:** __________  
**Date:** __________  
**Pass threshold:** All Critical tests pass, no crash, no blocker UX issues.

## Legend

- **Priority:** C = Critical, H = High, M = Medium
- **Result:** Pass / Fail
- **Notes:** brief bug evidence

## Test Cases

| ID | Priority | Test Step | Expected Result | Result | Notes |
|---|---|---|---|---|---|
| T01 | C | Launch app fresh (no existing data) | App opens without crash to main flow | ☐ Pass ☐ Fail | |
| T02 | C | Go to Compose, leave input empty, tap Send | Send is disabled or no send occurs | ☐ Pass ☐ Fail | |
| T03 | C | Enter whitespace-only text, attempt Send | Message is rejected (not saved) | ☐ Pass ☐ Fail | |
| T04 | C | Enter valid text, choose short preset (e.g. 1 min), tap Send | Input clears; message is stored as hidden | ☐ Pass ☐ Fail | |
| T05 | C | Immediately open Released after T04 | New message is **not** visible yet | ☐ Pass ☐ Fail | |
| T06 | C | Wait until unlock time passes; reopen/refresh Released | Message appears in Released | ☐ Pass ☐ Fail | |
| T07 | H | Send second message with longer delay | First may release, second stays hidden until its time | ☐ Pass ☐ Fail | |
| T08 | H | Open Status screen after T07 | Hidden count / released count / next unlock are correct | ☐ Pass ☐ Fail | |
| T09 | H | Kill app fully and relaunch | Messages persist correctly after relaunch | ☐ Pass ☐ Fail | |
| T10 | H | In Settings, change default delay preset | Setting saves successfully | ☐ Pass ☐ Fail | |
| T11 | H | Relaunch app, return to Compose | New default preset is still selected | ☐ Pass ☐ Fail | |
| T12 | M | Navigate all 4 tabs repeatedly | No dead taps, no visual breakage, no crash | ☐ Pass ☐ Fail | |
| T13 | M | Test with 20+ total messages | UI remains usable; no major lag/crash | ☐ Pass ☐ Fail | |
| T14 | C | Keep device offline during all tests | App functions fully offline; no backend/login dependency | ☐ Pass ☐ Fail | |
| T15* | M | If reset-data exists: trigger reset with confirmation | Data clears only after confirm; app remains stable | ☐ Pass ☐ Fail | |

\*Run only if reset is implemented.

## Scope Compliance Checks (MVP Guardrails)

- [ ] SwiftUI only
- [ ] iPhone only
- [ ] Local persistence only
- [ ] No login/auth
- [ ] No cloud sync/backend
- [ ] No push notifications
- [ ] No third-party libraries

## Defect Log (Quick)

| Bug ID | Severity (P0/P1/P2/P3) | Steps to Repro | Expected vs Actual | Status |
|---|---|---|---|---|
| B-001 |  |  |  | Open |
| B-002 |  |  |  | Open |
| B-003 |  |  |  | Open |

## Final QA Decision

- **Critical tests (T01-T06, T14):** ____ / 7 passed
- **Overall result:** ☐ PASS MVP ☐ FAIL MVP
- **Sign-off notes:** _____________________________________
