# gitdevr 0.0.0.9000

- Inline links remain identifiable without color, keyboard focus is visible and diffviewer text is readable in both modes. Footer backgrounds now span the viewport between the small and medium breakpoints without horizontal overflow (#10).
- Mobile navigation, sidebars, footers and copy buttons now follow the shared responsive layout. Tab and pill hover styles no longer affect other navigation components, and development badges use the shared red color.
- Footer and navigation colors now follow the Chulapa GitDev skins, and the standalone dark brand resolves its background and primary colors consistently with gitdev-dark.
- Quarto callout icons retain their shapes and now follow the site theme and brand colors through CSS masks.
- Code blocks now use the GitHub palette in light mode and One Dark in dark mode, with small adjustments to comments and One Dark names for accessible contrast.
- Navigation hover and focus states have improved contrast, and linked code tokens retain their underline.
- Mobile code blocks scroll within their containers.
- Page transitions and callout icon animations respect reduced motion preferences.
- The package is in active development.
- `test()` now returns `NULL` invisibly, as documented.
