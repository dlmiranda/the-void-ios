# The Void MVP QA Script (Light)

**Build:** __________  
**Device:** __________  
**Tester:** __________  
**Date:** __________

## Critical Path (Must Pass)

- [ ] App launches with no crash on fresh start.
- [ ] Empty message cannot be sent.
- [ ] Whitespace-only message cannot be sent.
- [ ] Valid message + delay can be sent.
- [ ] Sent message is hidden immediately.
- [ ] Hidden message does not show in Released before unlock.
- [ ] Message appears in Released after unlock time.
- [ ] App works fully offline.

## Core Screens

- [ ] Compose screen works (type, choose delay, send).
- [ ] Released screen works (list + empty state).
- [ ] Status screen shows correct counts and next unlock.
- [ ] Settings screen saves default delay preset.
- [ ] Tab navigation across all 4 screens is stable.

## Persistence

- [ ] Messages persist after force-close and relaunch.
- [ ] Settings persist after relaunch.
- [ ] No data corruption observed after multiple sends.

## Usability

- [ ] Send button enable/disable behavior is clear.
- [ ] Dates/times are readable and sensible.
- [ ] No dead taps or broken layouts on iPhone.
- [ ] App remains usable with 20+ messages.

## Scope Guardrails

- [ ] SwiftUI only.
- [ ] iPhone only.
- [ ] Local storage only.
- [ ] No login/auth.
- [ ] No cloud/backend.
- [ ] No push notifications.
- [ ] No third-party libraries.

## Optional (If Implemented)

- [ ] Reset local data requires confirmation.
- [ ] Reset local data works safely without crash.

## Bug Notes

- [ ] No P0 bugs
- [ ] No P1 bugs
- Notes: ____________________________________________

## Final Decision

- [ ] PASS MVP
- [ ] FAIL MVP
- Sign-off: ____________________
