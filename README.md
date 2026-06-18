<div align="center">

<!-- Header with left text and right logo -->
<div style="display: flex; align-items: center; justify-content: space-between; width: 100%;">
  <div style="text-align: left;">
    <strong style="font-size: 1.2em;">Draw your verses</strong><br>
    <strong style="font-size: 1em;">Mantra:</strong> Pixel-less precision, infinite resolution.<br>
    <strong style="font-size: 1em;">Tagline:</strong> One SVG, all sizes.
  </div>
  <div>
    <img src="https://www.protee.org/images/wos_SvgWidgets/wos_SvgWidgets.png" alt="wos_SVGwidgets Logo" width="60" style="border-radius: 12px;">
  </div>
</div>

<!-- Title and badges -->
# wos_SvgWidgets

[![4D Component](https://img.shields.io/badge/4D-Component-blue)](#)
[![License: Commercial](https://img.shields.io/badge/License-Commercial-red.svg)](#license)
[![Platform: macOS & Windows](https://img.shields.io/badge/Platform-macOS%20%7C%20Windows-lightgrey)](#)
[![4D v21+](https://img.shields.io/badge/4D-v21%2B-brightgreen)](#)

</div>

## Overview

wos_SvgWidgets provides a splendid, fully customizable SVG editor component, originally developed for GenieSolutions. Where code meets canvas in perfect harmony, this component allows you to integrate powerful vector drawing capabilities directly into your 4D applications.

All underlying sub-widgets are exposed and available, giving you the flexibility to build your own custom vector drawing tools.

---

## Key Features

- **Ready-to-Use Editor**: Includes a powerful `svgEditor` widget that you can seamlessly place directly into your forms.
- **Easy Launch**: A convenience method is provided to instantly open a form pre-populated with the editor for dedicated SVG editing tasks, requiring only a few lines of code.
- **Specialized Signing Mode**: A unique option allows you to "stick" or lock the selected drawing tool, creating dedicated zones for handwritten signatures and effectively turning the editor into a signing pad.
- **Exposed Sub-Widgets**: All underlying sub-widgets are available, enabling you to assemble your own custom vector drawing tools.
- **Multi-Language Support**: Localized in **English (EN)**, with **French (FR)** and other languages coming soon.

### Current Limitation
Please note that the SVGpath element is not currently supported for editing within the widget.

---

## Installation & Dependencies

### Prerequisites
- **4D v21** or higher (Project mode recommended).
- [**wok_Krolific**](https://github.com/protee/wok_Krolific) – Licensing component (mandatory dependency).
- [**wox_Xlibrary**](https://github.com/protee/wox_Xlibrary) – Core utilities (mandatory dependency).
- [**woc_Colours**](https://github.com/protee/woc_Colours) – Color management engine (mandatory dependency).
- The [**4D SVG component**](https://github.com/4d/4D-SVG) must be available in your project.

### Installation via Dependencies Manager (GitHub)

Starting with 4D v21, the recommended way to install wos_SvgWidgets (and any ogTools component) is through the **Dependencies Manager** using the **GitHub repository**:

1. In your 4D project, open the **Dependencies Manager** (`Project > Dependencies`).
2. Click the `+` button and select **Add a dependency from a Git URL**.
3. Enter the following Git URL:`protee/wos_SvgWidgets`
4. Choose the desired version (e.g., `main`, `latest`, or a specific release tag).
5. Confirm the installation – the component will be automatically fetched from GitHub, placed in the `Components` folder, and linked to your project.

> **Note**: For team development, commit the dependency configuration file (`dependencies.json`) to your source control so all team members automatically fetch the same version from GitHub.

---

## How It Works

1.  **Place the Widget**: Drag and drop the `svgEditor` widget onto any form in your application.
2.  **Launch the Editor**: Use the provided convenience method to open a dedicated form pre-populated with the editor, requiring only a few lines of code.
3.  **Enable Signing Mode**: Activate the unique "sticky" drawing tool option to lock a selected tool, creating a dedicated zone for handwritten signatures.
4.  **Build Custom Tools**: Leverage the exposed sub-widgets to assemble your own custom vector drawing tools tailored to your specific needs.

---

## Part of the ogTools Suite

wos_SvgWidgets is the vector graphics pillar of the comprehensive **ogTools suite** – an integrated development ecosystem for 4D. Other key components include:

| Component | Description |
|-----------|-------------|
| **wok_Krolific** | Centralized licensing system. |
| **wox_Xlibrary** | Core utilities for everyday development tasks. |
| **zen_Nucleus** | The complete ORDA framework binding your database to a sophisticated UI. |
| **woc_Colours** | Advanced, indexed color management engine. |
| **waz_Wazar** | Intelligent UI widgets for modern interfaces. |
| **wor_Recursive** | Manage hierarchical data with ease. |
| **wob_Boxes** | Secure, Dropbox-like file repository. |
| **wod_DevTools** | Instant documentation generation. |
| **wom_Make** | Build and automation toolkit. |
| **wqr_Quickreport** | ORDA‑friendly reporting. |

> Together, these components form a powerful framework that allows developers to focus on unique business logic rather than reinventing the wheel.

---

## License

wos_SvgWidgets is a **commercial component** and is part of the paid ogTools suite. A valid license is required for use. For licensing options and trial requests, please contact the sales team directly.

---

## Localization

wos_SvgWidgets is currently localized in **English (EN)**, with **French (FR)** and other languages on demand.

Localization affects error messages, UI prompts, and built-in pane texts.

---

## Support & Resources

- **Official Website**: [https://www.protee.org](https://www.protee.org)
- **Documentation**: Full documentation and HDI (Host Database Interface) demos are included with your purchase.

For direct inquiries:
- **Email**: [og@protee.org](mailto:og@protee.org)
- **Phone**: +33 6 3718 5941

---

## About the Creator

wos_SvgWidgets and the ogTools suite are developed by **Protée sarl**, a company with over 30 years of expertise in 4D development. Led by Olivier Grimbert, the team focuses on delivering high‑quality, production‑grade tools that enhance developer productivity and application reliability.

---

<div align="center">
  <sub>Built with ❤️ for the 4D community by Protée sarl. © 2016 - Present</sub>
</div>	