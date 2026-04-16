# Release Checklist (MVP)

Use this checklist before shipping a test build or tagging an MVP release.

**Target build/commit:** __________  
**Release type:** Internal Test / MVP Candidate  
**Owner:** __________  
**Date:** __________

---

## 1) Scope Lock (MVP)

- [ ] Includes only MVP features:
  - Compose
  - Released
  - Void Status
  - Settings (minimal)
- [ ] No new out-of-scope features added late.
- [ ] No backend/cloud/login/subscription logic introduced.
- [ ] No push notification dependency.

---

## 2) Functional Gates

- [ ] User can send a valid thought with delay preset.
- [ ] Sent thought stays hidden until unlock time.
- [ ] Released screen shows only unlocked messages.
- [ ] Status counts are accurate (hidden/released/next unlock).
- [ ] Settings changes persist and reload correctly.

---

## 3) Persistence & Data Safety

- [ ] Messages persist across app relaunch.
- [ ] Settings persist across app relaunch.
- [ ] First launch (no data file) works without crash.
- [ ] No known data loss bugs in normal usage.
- [ ] Optional reset-data flow is confirmed safe (if present).

---

## 4) QA Evidence

- [ ] `MVP_QA_SCRIPT.md` completed for this build.
- [ ] Critical tests passed: __ / 7.
- [ ] `MVP_QA_SCRIPT_LIGHT.md` spot-check completed.
- [ ] `QA_RUN_LOG.md` updated with this run.
- [ ] Repro steps captured for all failed tests.

---

## 5) Bug Gate (Go/No-Go)

- [ ] P0 open bugs = 0
- [ ] P1 open bugs = 0
- [ ] Any P2 bugs are documented and acceptable for MVP.
- [ ] No crash-on-launch or crash-on-send issues.

---

## 6) UX Readiness

- [ ] Empty states are clear and friendly.
- [ ] Disabled button states are obvious.
- [ ] Text remains readable on iPhone screen sizes.
- [ ] Tab navigation is stable and predictable.
- [ ] No obvious layout breaks in portrait orientation.

---

## 7) Technical Constraints Check

- [ ] SwiftUI-only implementation.
- [ ] iPhone-only target.
- [ ] Local persistence only.
- [ ] No third-party dependencies added for MVP.
- [ ] Codebase remains beginner-friendly and maintainable.

---

## 8) Pre-Release Sanity

- [ ] Build runs on at least one physical iPhone.
- [ ] Build runs on simulator clean install.
- [ ] Offline mode sanity check passed.
- [ ] App icon/name/version look correct for test distribution.

---

## 9) Release Decision

**Decision:**  
- [ ] GO (Release this build)
- [ ] NO-GO (Block release)

**Reason:**  
____________________________________________________

**Follow-up actions (if NO-GO):**
- [ ] Fix bugs listed in QA log
- [ ] Re-run critical test set
- [ ] Update QA run log with retest results

**Approvals:**  
- Product/Owner: ____________________  
- QA: ____________________  
- Dev: ____________________
