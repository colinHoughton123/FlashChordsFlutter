# FlashChords Regression Test Plan

## Scope
- Platforms: iOS, Android
- Excludes: analytics tracking, TestFlight upgrade flow

## Global Setup Matrix
Use these mode combinations across key tests:
1. Listener OFF / Timer OFF
2. Listener OFF / Timer ON
3. Listener ON / Timer OFF
4. Listener ON / Timer ON

Also vary:
- Language: EN + 2 non-Latin (e.g., Hindi, Japanese) + RTL (Arabic) once added
- Font size: default + large (Dynamic Type)

## Regression Test Table

| ID | Area | Platform | Preconditions | Steps | Expected Result |
|---|---|---|---|---|---|
| G-01 | App Launch | iOS, Android | Fresh install | Launch app | Welcome screen loads, no crash |
| G-02 | App Relaunch | iOS, Android | After use | Force close, reopen | Restores last language and settings |
| G-03 | Navigation | iOS, Android | None | Open Config, back to Welcome, Start deck, go to Summary | No crashes, state preserved |
| G-04 | Dynamic Type | iOS, Android | System font large | Open Welcome, Config, Flashcard, Summary | No text overflow, all text readable |
| G-05 | Language Change | iOS, Android | Any language | Change language, restart app | Selected language persists |

| ID | Area | Platform | Preconditions | Steps | Expected Result |
|---|---|---|---|---|---|
| W-01 | Welcome Layout | iOS, Android | Default | Verify title, catchphrase, Start, Configure | Title shows FlashChords™, catchphrase italicized |
| W-02 | Info Dialog | iOS, Android | Any | Tap info icon | Modal opens with correct localized text, scrollable if needed |
| W-03 | Language Picker | iOS, Android | Many languages | Open picker, scroll | Scroll works, hint visible, all languages reachable |
| W-04 | Language Picker (Traditional) | iOS, Android | Choose zh_Hant | Select zh_Hant, restart | UI appears in Traditional Chinese |

| ID | Area | Platform | Preconditions | Steps | Expected Result |
|---|---|---|---|---|---|
| C-01 | Config Save | iOS, Android | Default | Toggle options, Save | Options persist |
| C-02 | Inversion Warning | iOS, Android | Listener ON + >1 inversion | Enable listener then select >1 inversion | Modal shows with OK, checkbox; “Don’t show again” persists |
| C-03 | Inversion Warning Reset | iOS, Android | Reset debug | Use debug reset | Warning appears again |
| C-04 | At Least One | iOS, Android | Deselect last option | Try to deselect all | Config warning appears, selection restored |

| ID | Area | Platform | Preconditions | Steps | Expected Result |
|---|---|---|---|---|---|
| F-01 | Start Deck | iOS, Android | Listener OFF / Timer OFF | Start | Card displays immediately, no listener UI |
| F-02 | Listener Start Overlay | iOS, Android | Listener ON | Start | “Starting listener…” overlay, card appears after ready |
| F-03 | Timer Only | iOS, Android | Listener OFF / Timer ON | Start, wait | Timer counts down, reveal on timeout |
| F-04 | Listener Only | iOS, Android | Listener ON / Timer OFF | Play correct chord | Auto-correct triggers animation, next card |
| F-05 | Listener + Timer | iOS, Android | Listener ON / Timer ON | Play correct chord before timeout | Auto-correct, timer stops, next card |
| F-06 | Manual Correct | iOS, Android | Listener OFF | Tap ✅ | Card animates, stats update |
| F-07 | Manual Incorrect | iOS, Android | Listener OFF | Tap ❌ | Error deck created, stats update |
| F-08 | Reveal Back | iOS, Android | Any | Tap card | Back shows keyboard image with green dots |
| F-09 | Swipe Controls | iOS, Android | Listener OFF | Swipe right/left | Same as tap correct/incorrect |
| F-10 | Average Time | iOS, Android | Timer ON | Play several cards | Average (correct) displays correctly |
| F-11 | Counts Layout | iOS, Android | Any | Play cards | Incorrect/Correct counts visible |

| ID | Area | Platform | Preconditions | Steps | Expected Result |
|---|---|---|---|---|---|
| L-01 | Free Limit | iOS, Android | Listener ON, limit=10 | Play >10 listener cards | Listener disabled, warning shown |
| L-02 | After Limit | iOS, Android | Limit reached | Continue deck | App continues, listener stays off |
| L-03 | Debug Upgrade On | iOS, Android | Tap debug upgrade | Enable upgrade | Listener remains available past limit |
| L-04 | Debug Upgrade Off | iOS, Android | Upgrade ON | Disable upgrade | Listener limit enforced again |
| L-05 | Summary Listener Status | iOS, Android | Listener ON/OFF | Finish deck | Summary reflects listener mode |

| ID | Area | Platform | Preconditions | Steps | Expected Result |
|---|---|---|---|---|---|
| S-01 | Summary Stats | iOS, Android | Any | Finish deck | Correct/Incorrect counts and averages accurate |
| S-02 | Error Deck | iOS, Android | Incorrect cards | Finish deck | Error deck starts as expected |
| S-03 | Restart | iOS, Android | Summary screen | Tap Restart | New run starts cleanly |
| S-04 | Done | iOS, Android | Summary screen | Tap Done | Returns to Welcome |

| ID | Area | Platform | Preconditions | Steps | Expected Result |
|---|---|---|---|---|---|
| A-01 | Mic Permission Denied | iOS, Android | Deny mic | Start with listener on | Error message shows, listener off |
| A-02 | Mic Interrupted | iOS, Android | Interrupt audio | Start listener, trigger interruption | Error message shown, listener stops safely |

| ID | Area | Platform | Preconditions | Steps | Expected Result |
|---|---|---|---|---|---|
| D-01 | Chord Detection Accuracy | iOS, Android | Listener ON | Play correct chords | Auto-correct in ≤0.3s from stable play |
| D-02 | False Positives | iOS, Android | Listener ON | Play wrong chords | Must not confirm within 3 frames |
| D-03 | Inversions | iOS, Android | Multiple inversions | Play inversion not shown | Still marked correct, warning shown |
| D-04 | Fast Chord Changes | iOS, Android | Listener ON | Rapid chord changes | No crashes, stable detection |
| D-05 | Noise | iOS, Android | Listener ON | Background noise | No false corrects |

## Screen Checklists

### Welcome Screen
- FlashChords™ title rendered correctly
- Catchphrase italicized and above Start button
- Info icon opens scrollable modal
- Language picker opens and scrolls
- Start / Configure buttons responsive

### Config Screen
- All options selectable and saved
- At least one selection enforced
- Inversion warning shows only when conditions met
- “Don’t show again” persists

### Flashcard Screen
- Listener overlay shows only when listener enabled
- Timer shows correctly and cancels on correct
- Counts, averages, played/to-go layout correct
- Reveal card shows keyboard with dots

### Summary Screen
- Counts correct/incorrect accurate
- Average time correct vs all accurate
- Error deck handling works
- Done/Restart both correct
