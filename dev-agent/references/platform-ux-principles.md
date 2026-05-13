# Platform UX Principles

Use this when design or implementation depends on platform behavior.

## Web

- Preserve browser basics: URLs, back/forward, tab order, responsive layout, and form semantics.
- Use native controls unless custom controls materially improve the task.
- Test keyboard navigation and narrow widths early.

## iOS

- Respect safe areas, Dynamic Type, standard navigation patterns, gestures, haptics, privacy prompts, and permission timing.
- Keep primary actions reachable and avoid hidden destructive behavior.
- Use platform-native affordances unless the product has a strong reason not to.

## Android

- Respect back behavior, system bars, Material interaction expectations, permissions, notification channels, and varied screen densities.
- Avoid iOS-only interaction assumptions such as swipe locations or modal behavior.
- Test small phones and large foldable/tablet layouts when relevant.

## Desktop

- Support keyboard shortcuts, hover/focus states, resizable windows, dense data views, and multi-panel workflows.
- Keep controls discoverable without turning the page into a marketing layout.

## Cross-Platform Checks

- Touch targets and pointer targets fit the platform.
- Loading, error, empty, permission, offline, and long-content states are defined.
- Motion can be reduced.
- Text can grow or localize without breaking layout.
