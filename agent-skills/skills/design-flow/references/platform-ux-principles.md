# Platform UX Principles

Use this reference when creating a design package for mobile apps.

## Shared Mobile Principles

- Make the first screen answer the user's next action quickly.
- Keep primary actions visible; gestures are accelerators, not the only path.
- Use undo for reversible destructive actions like dismissing a card.
- Preserve explainability for recommendations that use personal data.
- Respect minimum touch targets: roughly 44pt on iOS and 48dp on Android.
- Never rely only on color to communicate priority, risk, or status.
- Avoid autoplay voice, background listening, or cross-app automation unless explicitly approved.
- For assistant products, distinguish generated phrasing from decision authority.

## iOS

- Favor clear hierarchy, direct manipulation, and reversible actions.
- Use sheets or inline disclosure for secondary details.
- Make privacy and data-source explanations visible when health, location, messages, or contacts are involved.
- Keep tab navigation stable and predictable.
- Avoid hiding critical actions behind long press or swipe only.

## Android

- Respect system back behavior and gesture navigation.
- Use snackbars or equivalent feedback for undo after transient actions.
- Bottom navigation should represent stable top-level destinations.
- Permission explanations should be concrete and tied to user value.
- State changes should be visible and accessible to screen readers.

## HCI Checks

- Recognition beats recall: show available actions.
- Progressive disclosure: summarize first, reveal detail on demand.
- Feedback: every action needs immediate response.
- Error prevention: high-risk automation requires confirmation.
- Consistency: repeated gestures and controls should mean the same thing everywhere.
- User control: allow dismiss, snooze, adjust rule, and revoke source permissions.
