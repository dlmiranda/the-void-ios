# The Void QA Checklist (Xcode)

Use this checklist for repeatable QA in Simulator or on a physical iPhone.

## Setup

- [ ] Clean build folder in Xcode (`Product -> Clean Build Folder`)
- [ ] Run app from Xcode
- [ ] Start from a known state:
  - [ ] fresh install, or
  - [ ] `Settings -> Clear All Local Data`

---

## 1) Compose Validation

- [ ] Compose screen loads with large text area and delay picker
- [ ] Send button is disabled when input is empty
- [ ] Send button stays disabled for whitespace-only input (`"   "`)
- [ ] Enter valid text + tap Send -> input clears
- [ ] "Sent to The Void" confirmation appears briefly
- [ ] Selected preset behavior feels consistent after send

---

## 2) Delay Preset + Unlock Logic

- [ ] Compose shows only: `1 Hour`, `Tonight`, `Tomorrow`, `3 Days`, `1 Week`
- [ ] (Debug only) verify `2 Minutes` preset behavior if exposed in debug paths
- [ ] Sent message gets correct unlock behavior for chosen preset
- [ ] No message appears in Released before unlock time

---

## 3) Released Screen

- [ ] Empty state appears when nothing has unlocked
- [ ] After unlock time passes, message appears in Released
- [ ] Released list is chronological and readable
- [ ] Each released card shows:
  - [ ] message text
  - [ ] readable timestamp
- [ ] No locked message text appears in Released early

---

## 4) Void Screen (Hidden Metadata Only)

- [ ] Shows locked count correctly
- [ ] Shows next unlock time when applicable
- [ ] Shows locked item cards with:
  - [ ] Sent date
  - [ ] Unlock date
  - [ ] Remaining time
- [ ] Hidden message text is never shown on Void screen
- [ ] Empty Void state appears when nothing is locked

---

## 5) Time-Based Refresh

- [ ] Keep app open until unlock boundary passes
- [ ] Message moves from locked -> released without manual app restart
- [ ] Foreground refresh works:
  - [ ] background app
  - [ ] return to app
  - [ ] state updates correctly (no stale lock/release view)

---

## 6) Persistence / Restart

- [ ] Send 2-3 messages with different presets
- [ ] Stop app in Xcode and run again
- [ ] Messages are still present after restart
- [ ] Locked vs Released split remains correct after restart

---

## 7) Settings

- [ ] App name and one-line description visible
- [ ] Version text displays (placeholder/app version)
- [ ] Tap "Clear All Local Data" -> confirmation appears
- [ ] Cancel leaves data untouched
- [ ] Confirm clear removes all messages from:
  - [ ] Released
  - [ ] Void
  - [ ] counts/status

---

## 8) Error Banner (Persistence QA)

- [ ] Persistence error banner appears when `lastPersistenceError` is set (if you simulate failure)
- [ ] Banner is non-blocking (can still navigate/use app)
- [ ] Banner auto-dismisses after a short delay

---

## 9) Navigation + UI Stability

- [ ] All 4 tabs open and switch smoothly
- [ ] No crashes while rapidly switching tabs
- [ ] Dark mode readability is good across all screens
- [ ] No clipped text or broken layouts on target iPhone simulator/device

---

## 10) MVP Guardrails

- [ ] No login/auth flow
- [ ] No cloud sync behavior
- [ ] No push notification dependency
- [ ] App functions offline

---

## Quick Pass / Fail Gate

- [ ] PASS: No crashes, no early-release leaks, persistence survives restart
- [ ] FAIL: Any data loss, early reveal, or unlock flow inconsistency
