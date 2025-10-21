## 🌊 **Flow**

### 🧭 **Positioning**

> “The right time, at the right cadence.”

**Flow** is not a timer — it’s a space where the user *records, understands, and respects their own rhythm of focus.*
The goal isn’t aggressive productivity — it’s fluidity.
Each session is a wave — it begins, builds, breaks, and starts again.

---

### 🎨 **Visual Identity**

**Overall tone:** light, continuous, fluid.
No red or orange (forced energy).
The palette should reflect **balance and consistency.**

| Element       | Guideline                    | Example              |
| ------------- | ---------------------------- | -------------------- |
| **Primary**   | Petrol blue or grayish blue  | `#2E5EAA`            |
| **Secondary** | Translucent light blue       | `#A3C9F9`            |
| **Accent**    | Soft lilac for active states | `#C2B8FF`            |
| **Neutrals**  | Off-white and soft grays     | `#F8FAFB`, `#D6DAE0` |

**Typography:**

* **San Francisco Rounded** (native and fluid)
* **Font weight:** medium to semibold — avoid heavy bolds.
* Avoid uppercase — Flow is calm, it doesn’t shout.

**SF Symbols Iconography:**

* Active session → `waveform.circle.fill`
* Ended session → `pause.circle.fill`
* Actions → `play.fill`, `plus.circle`, `checkmark.circle`

---

### 🧠 **Brand Tone**

Keywords:

> “Calm. Intentional. Present.”

It’s not a productivity app — it’s an app for mental presence.
Avoid words like *goal, task, performance.*
Prefer *session, rhythm, interval, flow.*

---

### 🧩 **Conceptual Architecture**

Each **Flow Session** is an object:

```swift
struct FlowSession: Identifiable, Codable {
    let id: UUID
    let start: Date
    let end: Date?
    let duration: TimeInterval
    let note: String?
}
```

* The app encourages users to manually start and end sessions — no gamification.
* Widgets and Live Activities display the **current Flow** (elapsed time and state).

---

### 💬 **Microcopy / Voice & Tone**

| Context            | Suggested Text                          |
| ------------------ | --------------------------------------- |
| Home screen        | “Enter your Flow.”                      |
| Main button        | “Start session” / “End session”         |
| Empty state        | “No sessions yet. Take the first step.” |
| Final notification | “Your Flow has ended.”                  |
| Widget             | “In Flow for 12 min.”                   |

---

### ⚙️ **Experience & Behavior**

* App starts with a subtle *fade-in*, softly breathing background.
* Main button uses a “press and hold” animation instead of a dry tap.
* Live Activity:

  * Animated wave icon (slow loop).
  * Elapsed time shown in the corner.
* Small Widget: “Flow active for X min.”
* Medium Widget: shows the last 3 sessions.

---

### 📱 **Quick Pitch (for class or portfolio)**

> “Flow is a minimalist app for intentional focus sessions.
> The user begins, maintains, and ends each session consciously.
> The Widget and Live Activity preserve the presence of that state — unhurried, without noise.
> Time isn’t a countdown, it’s a line of continuity.”
